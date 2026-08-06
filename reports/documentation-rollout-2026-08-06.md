# Rollout dos manuais operacionais — 2026-08-06

## Resultado

O contrato documental foi publicado e auditado no template e nos doze repositórios canônicos. A conferência remota consultou a API do GitHub para a visibilidade e a árvore de cada commit de `main`, e comparou o SHA de `refs/heads/main` com `origin/main`.

Os quatro documentos obrigatórios são `README.md`, `HOW-TO-USE.md`, `docs/REPOSITORY-STRUCTURE.md` e `governance/CONTRIBUTING.md`.

| Repositório | URL privada | Commit publicado em `main` | 4 documentos remotos | Testes e validador | `HEAD == origin/main` | `private` |
| --- | --- | --- | --- | --- | --- | --- |
| Template | [academia-contadores-agent-template](https://github.com/Academia-de-Contadores/academia-contadores-agent-template) | `5bd77dc90ef092ca8c6e3dabd36a23b6283f4b21` | SIM | PASS (reexecutado) | SIM | `true` |
| Processos de escritório | [ac-agente-processos-escritorio](https://github.com/Academia-de-Contadores/ac-agente-processos-escritorio) | `d881521ed5686a400525e72caaab035f46128ee9` | SIM | PASS (Task 3) | SIM | `true` |
| Fiscal | [ac-agente-fiscal](https://github.com/Academia-de-Contadores/ac-agente-fiscal) | `4960171096aa662fa8d338f72196e956075ba5a6` | SIM | PASS (Task 3) | SIM | `true` |
| DP | [ac-agente-dp](https://github.com/Academia-de-Contadores/ac-agente-dp) | `1d58b2f821763305799f570e90fa3b34a85290cb` | SIM | PASS (Task 3) | SIM | `true` |
| Societário | [ac-agente-societario](https://github.com/Academia-de-Contadores/ac-agente-societario) | `1da0bdcbcdbf3b9d745f1ad7491b4046fcfdb930` | SIM | PASS (Task 3) | SIM | `true` |
| Estrategista de Conteúdo DAI | [ac-agente-estrategista-conteudo-dai](https://github.com/Academia-de-Contadores/ac-agente-estrategista-conteudo-dai) | `b4ac9d6887fa62dc155effdb44464fa0324b404d` | SIM | PASS (Task 3) | SIM | `true` |
| Reforma Tributária | [ac-agente-reforma-tributaria](https://github.com/Academia-de-Contadores/ac-agente-reforma-tributaria) | `06f0d52702232ce954f8f18fb78205d2921834c9` | SIM | PASS (Task 3) | SIM | `true` |
| Contábil | [ac-agente-contabil](https://github.com/Academia-de-Contadores/ac-agente-contabil) | `a01e23ffa39f2f3693f83d31bca0dccf64e21a1e` | SIM | PASS (Task 3) | SIM | `true` |
| Entrada de clientes | [ac-agente-entrada-clientes](https://github.com/Academia-de-Contadores/ac-agente-entrada-clientes) | `1ca3a8f0cb54c4d5b04e8cc33681329221c32e76` | SIM | PASS (Task 3) | SIM | `true` |
| Captação de clientes | [ac-agente-captacao-clientes](https://github.com/Academia-de-Contadores/ac-agente-captacao-clientes) | `e3d524859f9ad10bf7bb053eee81c5ee0706c7e2` | SIM | PASS (Task 3) | SIM | `true` |
| Guia de operação | [ac-agente-guia-operacao](https://github.com/Academia-de-Contadores/ac-agente-guia-operacao) | `097fa231ed46f0828978f3c5e8b74968b1a8aae` | SIM | PASS (Task 3) | SIM | `true` |
| Reforma Tributária RAG | [ac-agente-reforma-tributaria-rag](https://github.com/Academia-de-Contadores/ac-agente-reforma-tributaria-rag) | `6cf5b5d0a7c42612ce1e35043b78c5e700f56f7d` | SIM | PASS (Task 3) | SIM | `true` |
| Reforma Tributária sem surto | [ac-agente-reforma-tributaria-sem-surto](https://github.com/Academia-de-Contadores/ac-agente-reforma-tributaria-sem-surto) | `f149b76c01574b340965339465e8c634bc164537` | SIM | PASS (Task 3) | SIM | `true` |

O resultado de Task 3 inclui, por agente, `bash tests/validate-agent-repo.test.sh`, `bash scripts/validate-agent-repo.sh` e `git diff --check`, todos aprovados. Os validadores exigem os quatro caminhos acima e as seções obrigatórias da referência estrutural; por isso a evidência abrange a explicação das pastas e relações, não somente a existência dos arquivos.

## Validação do catálogo e auditoria remota

No catálogo, antes de registrar este relatório, foram aprovados:

```bash
cd academia-contadores-agent-catalog
bash tests/validate-catalog.test.sh
bash scripts/validate-catalog.sh
git diff --check
```

O teste imprimiu `unknown canonical_agent_id: ac.missing`: este é o caso negativo esperado, e os três comandos terminaram com exit code `0`.

A API do GitHub confirmou `private: true` e `default_branch: main` para o template, catálogo e os 12 agentes. A auditoria pós-publicação confirmou worktrees limpas e igualdade entre `HEAD` e `origin/main` nos 14 repositórios. O catálogo passou a incluir este relatório em `main` após o push dos commits `3459ba7c9581efaf11783d643b4d4541c90a042a` e deste ajuste.

Para repetir a auditoria em clones limpos, execute o bloco abaixo para o template, catálogo e os 12 agentes. Ele falha se qualquer worktree tiver alteração, se o `HEAD` local divergir de `origin/main`, ou se a API não retornar um repositório privado.

```bash
repos=(
  academia-contadores-agent-template academia-contadores-agent-catalog
  ac-agente-processos-escritorio ac-agente-fiscal ac-agente-dp
  ac-agente-societario ac-agente-estrategista-conteudo-dai
  ac-agente-reforma-tributaria ac-agente-contabil ac-agente-entrada-clientes
  ac-agente-captacao-clientes ac-agente-guia-operacao
  ac-agente-reforma-tributaria-rag ac-agente-reforma-tributaria-sem-surto
)
audit_dir=$(mktemp -d)
for repo in "${repos[@]}"; do
  git clone --quiet "https://github.com/Academia-de-Contadores/${repo}.git" "$audit_dir/$repo"
  (
    cd "$audit_dir/$repo"
    test -z "$(git status --porcelain)"
    local_head=$(git rev-parse HEAD)
    remote_head=$(git ls-remote origin refs/heads/main | awk '{print $1}')
    test "$local_head" = "$remote_head"
  )
  test "$(gh api "repos/Academia-de-Contadores/$repo" --jq .private)" = true
done
```

Resultado registrado: os 14 comandos `git status --porcelain` não produziram saída; as 14 comparações de SHA foram iguais; e as 14 consultas retornaram `true`.

## Critérios de aceite

| Critério | Evidência | Resultado |
| --- | --- | --- |
| Os 13 repositórios têm os quatro documentos | Consulta remota da árvore de `main` para todos os caminhos obrigatórios | 13/13 |
| Pastas e relações explicadas | `docs/REPOSITORY-STRUCTURE.md`, validado no template e nos agentes | 13/13 |
| Knowledge `.md`, `.pdf` e demais formatos documentados | `README.md` e `HOW-TO-USE.md` do contrato propagado | 13/13 |
| Restauração, contribuição, testes e publicação documentados | `HOW-TO-USE.md` e `governance/CONTRIBUTING.md` | 13/13 |
| Ausência de novos documentos é rejeitada | Casos negativos da suíte do template propagados aos 12 agentes | 13/13 |
| Testes e validação aprovados | Evidência de Task 3; reexecução no template; validação do catálogo | 13/13 |
| Sincronizados e privados | API GitHub e referências `main` auditadas | 13/13 |

## Revisão humana final solicitada

Antes de declarar este padrão aprovado para uso organizacional, revisar o [relatório central](https://github.com/Academia-de-Contadores/academia-contadores-agent-catalog/blob/main/reports/documentation-rollout-2026-08-06.md) e, no template, o [README](https://github.com/Academia-de-Contadores/academia-contadores-agent-template/blob/main/README.md), o [HOW-TO-USE](https://github.com/Academia-de-Contadores/academia-contadores-agent-template/blob/main/HOW-TO-USE.md) e a [referência estrutural](https://github.com/Academia-de-Contadores/academia-contadores-agent-template/blob/main/docs/REPOSITORY-STRUCTURE.md). Os links exigem acesso à organização, pois todos os repositórios permanecem privados.

## Privacidade

O rollout não adiciona segredos, dados de clientes, conversas, logs, corpus, índices RAG nem credenciais. A auditoria confirma que todos os repositórios consultados continuam privados; a revisão humana deve preservar essa condição em alterações futuras.
