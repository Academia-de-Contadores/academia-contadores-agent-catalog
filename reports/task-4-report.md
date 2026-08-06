# Task 4 report — Provisionamento de repositórios

## Resultado

Foram criados e publicados exatamente 12 repositórios privados canônicos em
`Academia-de-Contadores`, derivados do template
`academia-contadores-agent-template`. As consultas de existência anteriores às
criações indicaram todos os 12 destinos ausentes; não houve conflito de ID,
sobrescrita, nem criação para alias, cópia, rascunho ou item temporário.

| ID | Repositório | Privado | ID remoto | Validação | Commit |
| --- | --- | --- | --- | --- | --- |
| `ac.processos-escritorio` | `ac-agente-processos-escritorio` | sim | `R_kgDOTwOM8w` | passou | `49deb5d188e8aff68681954c6925999e98eba153` |
| `ac.fiscal` | `ac-agente-fiscal` | sim | `R_kgDOTwONUQ` | passou | `92e6f04cb3ff9e6b1caa1542afd31ce8c2f4ee94` |
| `ac.dp` | `ac-agente-dp` | sim | `R_kgDOTwONuw` | passou | `f3af65260ea09873f2b940c3e0dd762627774d75` |
| `ac.societario` | `ac-agente-societario` | sim | `R_kgDOTwOOBw` | passou | `8b0c38cc986d88c3db7e12bfdcc8b33a38cf0085` |
| `ac.estrategista-conteudo-dai` | `ac-agente-estrategista-conteudo-dai` | sim | `R_kgDOTwOOUQ` | passou | `44c9a9170a3a9fa02f5d2c71832aa488b0f441ee` |
| `ac.reforma-tributaria` | `ac-agente-reforma-tributaria` | sim | `R_kgDOTwOOpQ` | passou | `39c70682011547431600867c380f1df7d78dfbb4` |
| `ac.contabil` | `ac-agente-contabil` | sim | `R_kgDOTwOO8w` | passou | `85a1aca5f7349f38660e1610a132bf2719dc6217` |
| `ac.entrada-clientes` | `ac-agente-entrada-clientes` | sim | `R_kgDOTwOPTg` | passou | `69855038fff8d811a09d1f15ab5ecec774c06c63` |
| `ac.captacao-clientes` | `ac-agente-captacao-clientes` | sim | `R_kgDOTwOPlg` | passou | `bf7c59820c31153a7360050f6cff4205d95a3c5a` |
| `ac.guia-operacao` | `ac-agente-guia-operacao` | sim | `R_kgDOTwOP4Q` | passou | `c496c8fa1199d4713bcd154f44f0c806dfd5d964` |
| `ac.reforma-tributaria-rag` | `ac-agente-reforma-tributaria-rag` | sim | `R_kgDOTwOQNA` | passou | `5aff31e57bcc554e1df2613f0d2f7da833677e95` |
| `ac.reforma-tributaria-sem-surto` | `ac-agente-reforma-tributaria-sem-surto` | sim | `R_kgDOTwOQkg` | passou | `8056b4c261d45e4a6eece57bf3925860d051292a` |

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

- `bash scripts/validate-agent-repo.sh` passou nos 12 clones antes da atualização do catálogo.
- Metadados, perfis e escopo RAG foram conferidos localmente.
- `bash scripts/validate-catalog.sh` passou tanto da raiz do catálogo quanto do diretório pai.
- `bash tests/validate-catalog.test.sh` passou; a saída `unknown canonical_agent_id: ac.missing` é o cenário negativo esperado do teste.
- O catálogo foi publicado no commit `aaab203f4a7c58d7b5f3a98c9fcc616eb631105e`.

## Concerns

Nenhum. A captura de instruções e avaliações comportamentais foi deliberadamente adiada para a Task 5.
