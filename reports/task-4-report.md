# Task 4 report — Provisionamento de repositórios

## Resultado

Foram criados e publicados exatamente 12 repositórios privados canônicos em
`Academia-de-Contadores`, derivados do template
`academia-contadores-agent-template`. As consultas de existência anteriores às
criações indicaram todos os 12 destinos ausentes; não houve conflito de ID,
sobrescrita, nem criação para alias, cópia, rascunho ou item temporário.

| ID | Repositório | Privado | ID remoto | Validação | Commit |
| --- | --- | --- | --- | --- | --- |
| `ac.processos-escritorio` | `ac-agente-processos-escritorio` | sim | `R_kgDOTwOM8w` | passou | `e4025b1535b0bb8d4a040d9e430a1e969fe3cc9f` |
| `ac.fiscal` | `ac-agente-fiscal` | sim | `R_kgDOTwONUQ` | passou | `9e9711db9544e4999fbe35e5ac291823eb9884e3` |
| `ac.dp` | `ac-agente-dp` | sim | `R_kgDOTwONuw` | passou | `7d5ee9f81606ced5a8bff79730edd01b5fa6d278` |
| `ac.societario` | `ac-agente-societario` | sim | `R_kgDOTwOOBw` | passou | `ac50cf276c3e0f96a5c0613ecb20e1a13c44992d` |
| `ac.estrategista-conteudo-dai` | `ac-agente-estrategista-conteudo-dai` | sim | `R_kgDOTwOOUQ` | passou | `eba1ac1e88d7ce85ac94d56061399a863a355b0d` |
| `ac.reforma-tributaria` | `ac-agente-reforma-tributaria` | sim | `R_kgDOTwOOpQ` | passou | `9c1e6face47aae7c3510e5dd9e07e28706804cb2` |
| `ac.contabil` | `ac-agente-contabil` | sim | `R_kgDOTwOO8w` | passou | `4c0a5d1077cbb9ddbd1ab0d89db935721df39284` |
| `ac.entrada-clientes` | `ac-agente-entrada-clientes` | sim | `R_kgDOTwOPTg` | passou | `53317fe70b7925bfd0d9269374a7c61cee80cd2b` |
| `ac.captacao-clientes` | `ac-agente-captacao-clientes` | sim | `R_kgDOTwOPlg` | passou | `0a06f8290930f85b2f7f014037dd508341c35b51` |
| `ac.guia-operacao` | `ac-agente-guia-operacao` | sim | `R_kgDOTwOP4Q` | passou | `c9181d801361540762c83184d0fea2cd6bdb3646` |
| `ac.reforma-tributaria-rag` | `ac-agente-reforma-tributaria-rag` | sim | `R_kgDOTwOQNA` | passou | `8381c1b8d8281b6a016a5c29df467a71e4549d01` |
| `ac.reforma-tributaria-sem-surto` | `ac-agente-reforma-tributaria-sem-surto` | sim | `R_kgDOTwOQkg` | passou | `b6a4a29db43c6d10ab081556021032015e3356a9` |

Todos os manifests usam os nomes humanos do inventário, `owners` igual a
`Academia-de-Contadores`, versão `0.1.0`, lifecycle `source-capture` e a URL
explícita do catálogo. Os componentes `example-*` foram removidos. Foi usado
somente o placeholder estrutural neutro `evaluations/source-capture.md`, sem
instruções ou avaliação comportamental da Task 5.

Fiscal, DP, Societário e Contábil têm exclusivamente o perfil `public-safe`,
ligado à versão `0.1.0`, sem `agent.id`, e com as proibições de cálculo/apuração
final, assinatura/protocolo/transmissão e decisão individual/regulatória
definitiva. No RAG, somente `connectors/rag/README.md` aponta para o runtime
externo `Academia-de-Contadores/agente-ia-reforma-com-rag`; runtime, corpus e
índices não foram copiados, e o repositório externo não foi editado.

## Validações

- A suíte `bash tests/validate-agent-repo.test.sh && bash scripts/validate-agent-repo.sh` passou nos 12 clones após a correção dos fixtures neutros; em cada clone, HEAD local foi confirmado igual a `origin/main`.
- Metadados, perfis e escopo RAG foram conferidos localmente.
- `bash scripts/validate-catalog.sh` passou tanto da raiz do catálogo quanto do diretório pai.
- `bash tests/validate-catalog.test.sh` passou; a saída `unknown canonical_agent_id: ac.missing` é o cenário negativo esperado do teste.
- O catálogo foi publicado no commit `aaab203f4a7c58d7b5f3a98c9fcc616eb631105e`.

## Concerns

Nenhum. A captura de instruções e avaliações comportamentais foi deliberadamente adiada para a Task 5.
