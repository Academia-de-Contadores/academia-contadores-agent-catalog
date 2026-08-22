# GPT Builder ↔ GitHub Parity Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Provar, em cada execução, se cada um dos 12 GPTs canônicos no ChatGPT Builder é idêntico à sua representação canônica no GitHub, campo e arquivo por arquivo, ou registrar uma divergência explícita e rastreável.

**Architecture:** O ChatGPT Builder autenticado é a fonte de verdade do conteúdo vivo. A captura é somente de leitura: ela produz evidências versionáveis (metadados, instruções, arquivos baixados e schemas de Actions) e o validador local compara essas evidências com o repositório canônico indicado pelo catálogo. O catálogo central coordena a execução e o relatório; cada repositório de agente continua sendo dono dos seus próprios arquivos de instrução, knowledge e Actions.

**Tech Stack:** ChatGPT Builder no navegador interno autenticado; Bash 3.2+; `yq`, `jq`, `shasum`, `cmp`, `git`; GitHub privado da organização Academia-de-Contadores.

**Spec:** `reports/live-editor-audit-2026-08-22.md` e o pedido do usuário de validar igualdade entre o GPT personalizado vivo e o GitHub (2026-08-22).

## Global Constraints

- O escopo canônico é exatamente os 12 IDs em `catalog/agents.yaml`; aliases em `catalog/aliases.yaml` são variantes e nunca recebem repositório próprio.
- Nunca clicar em **Atualizar**, remover arquivo ou enviar arquivo no Builder durante a auditoria. A única interação que escreve localmente é duplo clique em um anexo para baixá-lo.
- Comparar texto de instruções como UTF-8 com finais de linha normalizados para `LF`; comparar anexos por SHA-256 e tamanho em bytes.
- Comparar OpenAPI como JSON semântico, com chaves ordenadas recursivamente antes do SHA-256; guardar também o arquivo bruto exportado do Builder.
- O resultado por campo é somente `MATCH`, `LIVE_ONLY`, `GIT_ONLY`, `DIFFERENT`, `INTENTIONAL_DIVERGENCE` ou `BLOCKED`. `MATCH` exige evidência, não apenas nome ou quantidade de arquivos.
- `INTENTIONAL_DIVERGENCE` exige uma justificativa, URL do Builder, data e aprovador no relatório. O caso conhecido de `ac.processos-escritorio` (zero anexos ao vivo versus quatro backups históricos) começa nessa categoria, não como `MATCH`.
- Nenhum segredo, cookie, cabeçalho de autorização, arquivo `.env` ou exportação de sessão entra em Git.
- Publicar no GitHub somente depois de todos os testes locais passarem e o SHA de `main` remoto for igual ao SHA local após o push.

---

## File Structure

| Caminho | Responsabilidade |
| --- | --- |
| `academia-contadores-agent-catalog/catalog/live-parity.yaml` | Registro dos 12 agentes, URL oficial do editor, caminho do repositório e política de exceção permitida. |
| `academia-contadores-agent-catalog/docs/gpt-github-parity-spec.md` | Contrato de igualdade: campos do Builder, normalizações e critérios de aprovação. |
| `academia-contadores-agent-catalog/tools/live-parity/README.md` | Checklist humano de captura no Builder, sem ações de escrita. |
| `academia-contadores-agent-catalog/tools/live-parity/capture.schema.json` | Schema validável de uma captura por agente. |
| `academia-contadores-agent-catalog/scripts/validate-live-parity.sh` | Valida todas as evidências contra os repositórios canônicos. |
| `academia-contadores-agent-catalog/tests/validate-live-parity.test.sh` | Testes de aceitação e de rejeição do validador. |
| `academia-contadores-agent-catalog/snapshots/YYYY-MM-DD/<agent-id>.yaml` | Evidência imutável, sem conteúdo sensível, do estado lido no Builder. |
| `agent-repos/<repo>/instructions/current-live-YYYY-MM-DD.md` | Instruções exportadas do GPT, quando mudarem. |
| `agent-repos/<repo>/knowledge/live-YYYY-MM-DD/` | Anexos baixados do GPT e `MANIFEST.md` com nome, bytes e SHA-256. |
| `agent-repos/<repo>/connectors/actions/<action>/openapi.live-YYYY-MM-DD.json` | Schema bruto de Action observado no Builder, quando existir. |
| `academia-contadores-agent-catalog/reports/live-parity-YYYY-MM-DD.md` | Resultado por agente/campo, exceções e SHAs publicados. |

## Definition of Done

Uma execução é aprovada quando os 12 agentes têm uma captura válida da mesma data, todo campo aplicável está `MATCH` ou possui `INTENTIONAL_DIVERGENCE` aprovado, os anexos têm hash e tamanho confirmados, as Actions têm comparação semântica confirmada, o relatório não tem `BLOCKED`, `LIVE_ONLY`, `GIT_ONLY` ou `DIFFERENT`, e todos os três repositórios alterados estão publicados em `origin/main`.

### Task 1: Fixar o contrato canônico e o inventário dos 12 GPTs

**Files:**
- Create: `academia-contadores-agent-catalog/docs/gpt-github-parity-spec.md`
- Create: `academia-contadores-agent-catalog/catalog/live-parity.yaml`
- Modify: `academia-contadores-agent-catalog/scripts/validate-catalog.sh`
- Modify: `academia-contadores-agent-catalog/tests/validate-catalog.test.sh`

**Interfaces:**
- Consumes: `catalog/agents.yaml`, `catalog/aliases.yaml` e `agent-repos/*/agent.yaml`.
- Produces: `catalog/live-parity.yaml`, com exatamente 12 registros `agent_id`, `repository`, `editor_url`, `instruction_path`, `knowledge_policy` e `actions_policy`.

- [ ] **Step 1: Escrever o teste que rejeita inventário incompleto ou URL de editor inválida**

Adicionar ao teste do catálogo uma fixture que remove `ac.fiscal` de `live-parity.yaml` e outra que define `editor_url: https://example.invalid`. Cada fixture deve falhar:

```bash
yq -i 'del(.agents[] | select(.agent_id == "ac.fiscal"))' \
  "$fixture/catalog/live-parity.yaml"
assert_rejected "live parity inventory missing ac.fiscal"

yq -i '(.agents[] | select(.agent_id == "ac.fiscal").editor_url) = "https://example.invalid"' \
  "$fixture/catalog/live-parity.yaml"
assert_rejected "live parity editor URL is not a ChatGPT editor URL"
```

- [ ] **Step 2: Executar o teste para confirmar a falha**

Run: `bash academia-contadores-agent-catalog/tests/validate-catalog.test.sh`

Expected: falha porque `live-parity.yaml` e suas validações ainda não existem.

- [ ] **Step 3: Escrever a especificação e o inventário completo**

Definir no contrato os campos obrigatórios: `display_name`, `description`, `conversation_starters`, `capabilities`, `instructions`, `knowledge`, `actions` e `editor_url`. Usar `agent.yaml` como fonte inicial para os 12 URLs oficiais; o comando abaixo deve produzir 12 linhas e seus resultados devem ser copiados para `live-parity.yaml`:

```bash
for manifest in agent-repos/*/agent.yaml; do
  printf '%s | %s | %s\n' \
    "$(yq -r '.agent.id' "$manifest")" \
    "$(yq -r '.source_capture.source_url' "$manifest")" \
    "$(yq -r '.instructions.system' "$manifest")"
done | sort
```

O formato a validar é:

```yaml
schema_version: 1
agents:
  - agent_id: ac.fiscal
    repository: ac-agente-fiscal
    editor_url: https://chatgpt.com/gpts/editor/g-6a72595c828c8191aec02f7931d9c626
    instruction_path: instructions/system.md
    knowledge_policy: required
    actions_policy: none
```

Em `scripts/validate-catalog.sh`, exigir: 12 registros únicos, conjunto de `agent_id` igual ao de `agents.yaml`, `repository` igual ao catálogo, `editor_url` com prefixo `https://chatgpt.com/gpts/editor/g-`, caminho de instrução relativo e políticas somente `required`, `none` ou `approved-exception`.

- [ ] **Step 4: Executar todos os testes de catálogo**

Run: `bash academia-contadores-agent-catalog/tests/validate-catalog.test.sh`

Expected: `validate-catalog.test.sh` encerra com código 0; a mensagem `unknown canonical_agent_id: ac.missing` aparece apenas na fixture negativa já existente.

- [ ] **Step 5: Commit**

```bash
git -C academia-contadores-agent-catalog add \
  catalog/live-parity.yaml docs/gpt-github-parity-spec.md \
  scripts/validate-catalog.sh tests/validate-catalog.test.sh
git -C academia-contadores-agent-catalog commit -m "feat: define GPT parity contract"
```

### Task 2: Criar o formato de evidência e o checklist de captura somente leitura

**Files:**
- Create: `academia-contadores-agent-catalog/tools/live-parity/README.md`
- Create: `academia-contadores-agent-catalog/tools/live-parity/capture.schema.json`
- Create: `academia-contadores-agent-catalog/snapshots/.gitkeep`
- Modify: `academia-contadores-agent-catalog/.gitignore`

**Interfaces:**
- Consumes: cada URL `editor_url` de `catalog/live-parity.yaml` e arquivos baixados em `/Users/levy/Downloads`.
- Produces: `snapshots/YYYY-MM-DD/<agent-id>.yaml`, validado por `capture.schema.json`.

- [ ] **Step 1: Escrever o teste que rejeita uma captura sem hash de anexo**

Criar uma captura mínima válida em diretório temporário, remover `.knowledge.assets[0].sha256` e fazer o futuro validador retornar erro:

```bash
yq -i 'del(.knowledge.assets[0].sha256)' \
  "$fixture/snapshots/2026-08-22/ac.fiscal.yaml"
expect_rejected "knowledge asset without SHA-256"
```

- [ ] **Step 2: Executar o teste para confirmar a falha**

Run: `bash academia-contadores-agent-catalog/tests/validate-live-parity.test.sh`

Expected: falha porque ainda não há schema nem validador de evidência.

- [ ] **Step 3: Escrever o schema e o checklist**

O schema deve requerer `schema_version`, `agent_id`, `captured_at`, `editor.url`, `editor.display_name`, `editor.instructions_sha256`, `knowledge.status` e `actions`. Todo item de `knowledge.assets` deve requerer `filename`, `bytes`, `sha256` e `repository_path`. O README deve determinar esta sequência por GPT:

```text
1. Abrir somente a URL oficial do editor.
2. Copiar nome, descrição, iniciadores, capacidades e texto de Instruções.
3. Abrir Conhecimento; anotar a lista completa e dar duplo clique em cada anexo.
4. Calcular `shasum -a 256` e `wc -c` de cada download.
5. Copiar o schema de cada Action; não clicar em Testar, Atualizar ou Remover.
6. Salvar a captura YAML e os arquivos no local previsto; rodar o validador.
```

Acrescentar à `.gitignore` apenas a regra `snapshots/.work/`, para que downloads temporários nunca sejam incluídos por engano; as capturas finais em `snapshots/YYYY-MM-DD/` devem ser versionadas.

- [ ] **Step 4: Executar o teste de schema e lint de YAML/JSON**

Run: `jq empty academia-contadores-agent-catalog/tools/live-parity/capture.schema.json && bash academia-contadores-agent-catalog/tests/validate-live-parity.test.sh`

Expected: ambos encerram com código 0 depois que o validador da Task 3 existir.

- [ ] **Step 5: Commit**

```bash
git -C academia-contadores-agent-catalog add \
  .gitignore tools/live-parity snapshots/.gitkeep \
  tests/validate-live-parity.test.sh
git -C academia-contadores-agent-catalog commit -m "feat: add live GPT evidence contract"
```

### Task 3: Implementar o validador determinístico de paridade

**Files:**
- Create: `academia-contadores-agent-catalog/scripts/validate-live-parity.sh`
- Modify: `academia-contadores-agent-catalog/tests/validate-live-parity.test.sh`
- Modify: `academia-contadores-agent-catalog/README.md`

**Interfaces:**
- Consumes: `catalog/live-parity.yaml`, `snapshots/<date>/*.yaml` e arquivos dos repositórios `../agent-repos/<repository>`.
- Produces: linhas `agent_id | field | state | evidence` e exit code 0 apenas para paridade aprovada.
- Command: `bash scripts/validate-live-parity.sh --snapshot snapshots/2026-08-22`.

- [ ] **Step 1: Escrever as fixtures que cobrem sucesso e falhas reais**

Criar fixtures para cada resultado que não seja sucesso: hash diferente, arquivo vivo ausente no Git, arquivo Git ausente ao vivo, instrução diferente, schema OpenAPI semanticamente diferente, agente desconhecido e exceção aprovada. Cada uma deve usar `expect_rejected`, exceto a exceção aprovada:

```bash
cp "$fixture/live.md" "$fixture/agent-repos/ac-agente-fiscal/knowledge/live-2026-08-22/manual.md"
printf 'mudanca' >> "$fixture/live.md"
expect_rejected "knowledge SHA-256 differs"

yq -i '.agent_id = "ac.inexistente"' \
  "$fixture/snapshots/2026-08-22/ac.fiscal.yaml"
expect_rejected "unknown canonical agent"
```

- [ ] **Step 2: Executar a suíte para confirmar que falha**

Run: `bash academia-contadores-agent-catalog/tests/validate-live-parity.test.sh`

Expected: falha porque `scripts/validate-live-parity.sh` ainda não existe.

- [ ] **Step 3: Implementar as comparações de conteúdo**

Implementar as seguintes funções Bash no validador, com as assinaturas abaixo:

```bash
sha256_file() { shasum -a 256 "$1" | awk '{print $1}'; }
bytes_file() { wc -c < "$1" | tr -d '[:space:]'; }
normalized_text_sha256() { perl -pe 's/\r\n?/\n/g' "$1" | shasum -a 256 | awk '{print $1}'; }
canonical_json_sha256() { jq -S . "$1" | shasum -a 256 | awk '{print $1}'; }
```

O validador deve carregar os 12 IDs de `catalog/live-parity.yaml`, rejeitar snapshot duplicado ou faltante, exigir a mesma data para todos os 12, verificar `repository_path` sem `..`, calcular cada hash/byte e comparar com a evidência. Para Actions, usar `canonical_json_sha256`; para `actions: []`, exigir `actions_policy: none`. Ao encontrar exceção, exigir no snapshot `exception_id`, `approved_by` e `reason`, e verificar que a mesma `exception_id` existe no registro central.

- [ ] **Step 4: Rodar as suítes de validação**

Run: `bash academia-contadores-agent-catalog/tests/validate-live-parity.test.sh && bash academia-contadores-agent-catalog/tests/validate-catalog.test.sh`

Expected: ambas encerram com código 0; as fixtures negativas são rejeitadas internamente.

- [ ] **Step 5: Documentar o comando de auditoria**

Adicionar ao README do catálogo:

```bash
bash scripts/validate-live-parity.sh --snapshot snapshots/2026-08-22
```

Documentar que código 0 significa somente `MATCH` e exceções aprovadas; não significa que o Builder tenha sido modificado.

- [ ] **Step 6: Commit**

```bash
git -C academia-contadores-agent-catalog add \
  scripts/validate-live-parity.sh tests/validate-live-parity.test.sh README.md
git -C academia-contadores-agent-catalog commit -m "feat: validate live GPT parity"
```

### Task 4: Capturar os 12 GPTs oficiais e registrar cada evidência

**Files:**
- Create: `academia-contadores-agent-catalog/snapshots/2026-08-22/ac.captacao-clientes.yaml`
- Create: `academia-contadores-agent-catalog/snapshots/2026-08-22/ac.contabil.yaml`
- Create: `academia-contadores-agent-catalog/snapshots/2026-08-22/ac.dp.yaml`
- Create: `academia-contadores-agent-catalog/snapshots/2026-08-22/ac.entrada-clientes.yaml`
- Create: `academia-contadores-agent-catalog/snapshots/2026-08-22/ac.estrategista-conteudo-dai.yaml`
- Create: `academia-contadores-agent-catalog/snapshots/2026-08-22/ac.fiscal.yaml`
- Create: `academia-contadores-agent-catalog/snapshots/2026-08-22/ac.guia-operacao.yaml`
- Create: `academia-contadores-agent-catalog/snapshots/2026-08-22/ac.processos-escritorio.yaml`
- Create: `academia-contadores-agent-catalog/snapshots/2026-08-22/ac.reforma-tributaria-rag.yaml`
- Create: `academia-contadores-agent-catalog/snapshots/2026-08-22/ac.reforma-tributaria-sem-surto.yaml`
- Create: `academia-contadores-agent-catalog/snapshots/2026-08-22/ac.reforma-tributaria.yaml`
- Create: `academia-contadores-agent-catalog/snapshots/2026-08-22/ac.societario.yaml`
- Modify: repositórios canônicos afetados somente quando a evidência detectar `LIVE_ONLY` ou `DIFFERENT`.

**Interfaces:**
- Consumes: URLs de `catalog/live-parity.yaml` e o checklist em `tools/live-parity/README.md`.
- Produces: 12 arquivos de evidência preenchidos, arquivos baixados e hashes para cada anexo vivo.

- [ ] **Step 1: Capturar metadados e instruções de cada editor oficial**

Para cada entrada de `catalog/live-parity.yaml`, abrir a URL no navegador interno autenticado, copiar exatamente os campos descritos na Task 2 e salvar o texto de instruções em arquivo UTF-8 temporário. Registrar o hash com:

```bash
perl -pe 's/\r\n?/\n/g' /caminho/para/instructions-live.md | shasum -a 256
```

O arquivo temporário deve ser movido para o `instruction_path` do repositório somente se o hash for diferente do Git; se igual, ele é descartado fora do repositório.

- [ ] **Step 2: Baixar e comparar cada anexo de Conhecimento**

Dar duplo clique em cada anexo no Builder. Para cada download, calcular e registrar:

```bash
file_name='nome-exato-do-builder.ext'
download_path="/Users/levy/Downloads/$file_name"
printf '%s | %s | %s\n' \
  "$file_name" "$(wc -c < "$download_path" | tr -d '[:space:]')" \
  "$(shasum -a 256 "$download_path" | awk '{print $1}')"
```

Copiar para `knowledge/live-2026-08-22/` somente arquivos `LIVE_ONLY` ou `DIFFERENT`; atualizar ou criar `MANIFEST.md` com nome, bytes, SHA-256, URL e data. Um arquivo que exista somente no Git deve ser marcado `GIT_ONLY`; não pode ser apagado nesta etapa.

- [ ] **Step 3: Capturar e comparar Actions**

Para cada Action visível, copiar o schema para `openapi.live-2026-08-22.json` no diretório da Action, validar JSON e registrar o hash semântico:

```bash
jq empty openapi.live-2026-08-22.json
jq -S . openapi.live-2026-08-22.json | shasum -a 256
```

Para GPTs sem Action, registrar `actions: []`; não inferir ausência se o painel não puder ser carregado, pois esse caso é `BLOCKED`.

- [ ] **Step 4: Tratar divergências conforme a fonte de verdade**

Para `LIVE_ONLY` ou `DIFFERENT`, versionar no repositório do agente o conteúdo exatamente como baixado/copiado e atualizar `agent.yaml` para apontar para a nova captura. Para `GIT_ONLY`, não excluir arquivo: abrir uma entrada de exceção no snapshot e aguardar decisão do usuário. Para `ac.processos-escritorio`, registrar a exceção conhecida `processos-empty-live-knowledge` com os quatro backups históricos e o estado ao vivo vazio.

- [ ] **Step 5: Rodar a auditoria completa**

Run: `bash academia-contadores-agent-catalog/scripts/validate-live-parity.sh --snapshot academia-contadores-agent-catalog/snapshots/2026-08-22`

Expected: 12 blocos de resultado; nenhum `BLOCKED`, `LIVE_ONLY`, `GIT_ONLY` ou `DIFFERENT`. O único caso fora de `MATCH` permitido é `INTENTIONAL_DIVERGENCE` aprovado de Processos.

- [ ] **Step 6: Commit por repositório afetado**

Usar um commit por agente alterado, nunca misturar agentes. Exemplo para o RAG:

```bash
git -C agent-repos/ac-agente-reforma-tributaria-rag add \
  agent.yaml instructions knowledge connectors/actions evaluations
git -C agent-repos/ac-agente-reforma-tributaria-rag commit \
  -m "docs: sync live RAG capture 2026-08-22"
```

### Task 5: Gerar relatório final, publicar e comprovar o estado remoto

**Files:**
- Create: `academia-contadores-agent-catalog/reports/live-parity-2026-08-22.md`
- Modify: `academia-contadores-agent-catalog/reports/live-editor-audit-2026-08-22.md`
- Modify: `academia-contadores-agent-catalog/snapshots/2026-08-22/*.yaml` somente para adicionar o SHA de commit após publicação.

**Interfaces:**
- Consumes: saída aprovada de `validate-live-parity.sh`, arquivos de snapshot e `git rev-parse HEAD` de cada repositório alterado.
- Produces: relatório de decisão e confirmação de `origin/main` por SHA.

- [ ] **Step 1: Escrever o relatório de paridade**

Usar uma linha por agente com as colunas `Agente`, `Instruções`, `Conhecimento`, `Actions`, `Metadados`, `Resultado`, `Exceção` e `Commit`. O relatório deve apontar para cada manifesto/arquivo de evidência e declarar separadamente o caso de Processos. Não usar termos como “sincronizado” se houver `BLOCKED`, `LIVE_ONLY`, `GIT_ONLY` ou `DIFFERENT`.

- [ ] **Step 2: Executar todas as validações locais**

Run:

```bash
bash academia-contadores-agent-catalog/tests/validate-catalog.test.sh
bash academia-contadores-agent-catalog/tests/validate-live-parity.test.sh
bash academia-contadores-agent-catalog/scripts/validate-live-parity.sh \
  --snapshot academia-contadores-agent-catalog/snapshots/2026-08-22
```

Expected: três comandos retornam código 0.

- [ ] **Step 3: Verificar remotos antes do push**

Para cada repositório alterado, executar:

```bash
git -C "$repo" fetch origin --prune
git -C "$repo" rev-list --left-right --count '@{u}...HEAD'
```

Expected: o primeiro número é `0`; se não for, rebasear somente após revisar os commits remotos. Nunca usar `push --force`.

- [ ] **Step 4: Publicar commits e comprovar SHA remoto**

```bash
git -C "$repo" push origin main
local_sha=$(git -C "$repo" rev-parse HEAD)
remote_sha=$(git -C "$repo" ls-remote origin refs/heads/main | awk '{print $1}')
test "$local_sha" = "$remote_sha"
```

Executar para cada repositório afetado e registrar os SHAs no relatório. O catálogo central é publicado por último, pois ele referencia os commits dos agentes.

- [ ] **Step 5: Commit e publicar o catálogo por último**

```bash
git -C academia-contadores-agent-catalog add \
  catalog/live-parity.yaml snapshots/2026-08-22 \
  reports/live-parity-2026-08-22.md reports/live-editor-audit-2026-08-22.md
git -C academia-contadores-agent-catalog commit -m "docs: publish GPT parity audit 2026-08-22"
git -C academia-contadores-agent-catalog push origin main
```

## Self-Review

**Cobertura:** o plano verifica os 12 canônicos, trata aliases sem criar repositórios, cobre metadados, instruções, knowledge, Actions e estado remoto do GitHub. Também trata explicitamente o único gap conhecido de Processos e evita confundir backups históricos com configuração viva.

**Sem placeholders:** caminhos, comandos, estados, schema e critérios de saída são definidos. Valores coletados do Builder são evidência operacional, não campos indefinidos de implementação.

**Consistência:** o contrato é sempre `catalog/live-parity.yaml`; a evidência é sempre `snapshots/YYYY-MM-DD/<agent-id>.yaml`; o único comando de validação de paridade é `scripts/validate-live-parity.sh --snapshot <diretório>`.

## Execution Handoff

Plan complete and saved to `docs/superpowers/plans/2026-08-22-gpt-github-parity.md`. Two execution options:

1. **Subagent-Driven (recommended)** — dispatch a fresh subagent per task, review between tasks, fast iteration.

2. **Inline Execution** — execute tasks in this session using executing-plans, batch execution with checkpoints.

Which approach?
