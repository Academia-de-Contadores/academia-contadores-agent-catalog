# Relatório da Task 5 — captura de fontes e avaliações

Data: 2026-08-06

## Resultado

As configurações dos 12 agentes canônicos foram acessadas em modo somente
leitura pelos editores/cópias autenticados. Não houve bloqueio de autenticação
nem configuração integralmente indisponível.

- configurações acessíveis: **12**
- configurações indisponíveis: **0**
- rascunhos privados observados: **10**
- fontes publicadas observadas: **2**
- repositórios mantidos em `lifecycle: source-capture`: **12**
- versões mantidas em `0.1.0`: **12**
- tags `v1.0.0` criadas: **0**
- entradas promovidas para `active`: **0**

A promoção foi deliberadamente bloqueada até que uma pessoa revise a
fidelidade entre as configurações capturadas e o núcleo canônico.

## Evidência por agente

| ID | Repositório | URL exata do editor/fonte | Distribuição observada | Instruções | Knowledge | Avaliações | Commit publicado |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `ac.processos-escritorio` | `ac-agente-processos-escritorio` | https://chatgpt.com/gpts/editor/g-6a725900102c8191bdcb028b9ab4f21a | rascunho privado | acessíveis | 4 nomes | 5 + 3 + 3 | `e4c904e1ac9dda1e9c094c0d28f573ce296bedff` |
| `ac.fiscal` | `ac-agente-fiscal` | https://chatgpt.com/gpts/editor/g-6a72595c828c8191aec02f7931d9c626 | rascunho privado | acessíveis | 10 nomes | 5 + 3 + 3 | `98a31430057c190b743b83d6522f305e521911ea` |
| `ac.dp` | `ac-agente-dp` | https://chatgpt.com/gpts/editor/g-6a725829fc9c8191a652858f5980d4f4 | rascunho privado | acessíveis | 16 nomes | 5 + 3 + 3 | `9e1bcdcdb55eef24438e7f7192062a323a37c504` |
| `ac.societario` | `ac-agente-societario` | https://chatgpt.com/gpts/editor/g-6a725963258081919e7c1824531b1b6d | rascunho privado | acessíveis | 10 nomes | 5 + 3 + 3 | `a11174f5572d3bda4912c20052e545cd3435ea1b` |
| `ac.estrategista-conteudo-dai` | `ac-agente-estrategista-conteudo-dai` | https://chatgpt.com/gpts/editor/g-6a7259c849d4819194844f4d99c1213d | rascunho privado | acessíveis | 11 nomes | 5 + 3 + 3 | `fcbb62a3393acfd395b51085d6adb9659001e8aa` |
| `ac.reforma-tributaria` | `ac-agente-reforma-tributaria` | https://chatgpt.com/gpts/editor/g-6a7259cd04a48191a3bb1c2833b0ca2f | publicado por link | acessíveis | 8 nomes | 5 + 3 + 3 + conector | `7ad3474bc8325df4c0da4df61f5b4159235769bf` |
| `ac.contabil` | `ac-agente-contabil` | https://chatgpt.com/gpts/editor/g-6a725977a3648191af38146c635b4c86 | publicado por link | acessíveis | 10 nomes | 5 + 3 + 3 | `5495c1e437e0f8ba96ad76db289ef91f9f3a6c1e` |
| `ac.entrada-clientes` | `ac-agente-entrada-clientes` | https://chatgpt.com/gpts/editor/g-6a725998eaac81919fc16fc528de36ef | rascunho privado | acessíveis | 10 nomes | 5 + 3 + 3 | `204f3686f88cc1c66b194e97e9b519bcc9ea9870` |
| `ac.captacao-clientes` | `ac-agente-captacao-clientes` | https://chatgpt.com/gpts/editor/g-6a72599d1e28819181c68d513fc6cc09 | rascunho privado | acessíveis | 14 nomes | 5 + 3 + 3 | `939f57fcdbee117fa55bd24edceef782f686a1a0` |
| `ac.guia-operacao` | `ac-agente-guia-operacao` | https://chatgpt.com/gpts/editor/g-6a7259a1ec9c81918486ffda9824af6e | rascunho privado | acessíveis | 16 nomes | 5 + 3 + 3 | `5fe375e09182e0e013016a3f1c8452e402c80745` |
| `ac.reforma-tributaria-rag` | `ac-agente-reforma-tributaria-rag` | https://chatgpt.com/gpts/editor/g-6a7259edf2688191b44cec56ff3b7221 | rascunho privado | acessíveis | 8 nomes | 5 + 3 + 3 + conector | `c6cf195cb1adf857cc5e917bc6dd9c1f7ad49e89` |
| `ac.reforma-tributaria-sem-surto` | `ac-agente-reforma-tributaria-sem-surto` | https://chatgpt.com/gpts/editor/g-6a725a3feec081919ba9131c9f475341 | rascunho privado | acessíveis | 6 nomes | 5 + 3 + 3 | `dea06c5823269bae24eeddd16755f7ce24aeabba` |

“5 + 3 + 3” significa cinco tarefas principais, três cenários de
limite/escalonamento e três cenários de injeção/segurança. Os dois agentes cuja
instrução exige `searchDayRagCorpus` também têm cenário de indisponibilidade
do conector.

## Conteúdo capturado e separação

Cada repositório registra em `agent.yaml` a URL, data, status e ficha de
captura. A ficha documenta campos acessíveis, distribuição, instruções,
capacidades, Knowledge, mappings, método de recuperação e dados omitidos.

O campo de instruções foi preservado fielmente, removendo apenas o wrapper que
mandava colar o texto no GPT Builder. Objetivos, identidade, guardrails,
workflow, skills, conectores e Knowledge foram mapeados sem inventar corpos de
arquivos inacessíveis. Onde não existe campo separado — principalmente Soul/tom
— o arquivo registra `source_status: unavailable`.

Os anexos de Knowledge não foram abertos nem baixados. Foram registrados somente
os nomes/tipos visíveis no editor. Nenhum corpus, índice, runtime, log, conversa,
token, credencial, endpoint privado ou dado de cliente foi copiado.

A instrução de `ac.reforma-tributaria` e
`ac.reforma-tributaria-rag` exige a Action `searchDayRagCorpus`. Ambos
referenciam somente o runtime externo
`Academia-de-Contadores/agente-ia-reforma-com-rag`; schema de plataforma,
autenticação, endpoint, corpus e índices permanecem fora dos repositórios.

## Perfis e aliases

Os perfis `public-safe` de Fiscal, DP, Societário e Contábil preservam
orientação geral, checklist, evidências, pendências, hipóteses/simulações
revisáveis e handoff humano. Continuam proibidos cálculo/apuração final,
assinatura, protocolo, transmissão e decisão individual/regulatória definitiva.

Os aliases continuam sem repositório e sem cópia de instruções. Com base no
estado visível do editor, os aliases da cópia oficial de Reforma e da cópia
oficial Contábil foram corrigidos de `draft` para `copy`, pois estavam
publicados por link durante a captura.

## Validação

Antes dos commits, em cada um dos 12 repositórios foram executados:

```bash
bash tests/validate-agent-repo.test.sh
bash scripts/validate-agent-repo.sh
git diff --check
```

Todos passaram. As contagens estruturais confirmaram, em cada repositório,
cinco cenários T, três cenários H e três cenários S. Uma varredura por padrões
de credenciais/chaves não encontrou ocorrência. O catálogo passou
`bash tests/validate-catalog.test.sh` e `bash scripts/validate-catalog.sh`;
a mensagem `unknown canonical_agent_id: ac.missing` é o teste negativo
esperado.

Os 12 commits listados acima foram enviados para `origin/main`.

## Bloqueios e preocupações

- Falta revisão humana de fidelidade; por isso não houve versão `1.0.0`, tag
  `v1.0.0`, lifecycle `active` nem `production_version`.
- O conteúdo dos anexos de Knowledge permanece inacessível por decisão de
  escopo (nenhum download); seus mappings além do nome/tipo dependem de futura
  captura autorizada.
- A configuração visível mostrou somente a opção de criar nova Action; schema,
  autenticação e endpoint não ficaram visíveis. A integração RAG foi preservada
  como contrato externo e sua indisponibilidade é testada.
- A fonte de `ac.reforma-tributaria` contém janela temporária encerrando em
  07/08/2026 às 23h59, America/Sao_Paulo. A revisão humana deve decidir se essa
  regra temporal pertence ao núcleo canônico de longo prazo.

