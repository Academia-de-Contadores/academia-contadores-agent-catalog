# Provisionamento dos repositórios canônicos

## Resultado

Foram provisionados exatamente os 12 repositórios canônicos privados da organização
`Academia-de-Contadores`, a partir de
`Academia-de-Contadores/academia-contadores-agent-template`. Não foi criado
repositório para alias, cópia, rascunho ou item temporário.

Antes de cada criação foi feita uma consulta de existência remota. Os 12 destinos
estavam ausentes e, portanto, não houve conflito de `agent.id` nem sobrescrita.

## Evidência por agente

| ID | Nome canônico | Repositório | Privado | ID remoto | Validação | Commit publicado |
| --- | --- | --- | --- | --- | --- | --- |
| `ac.processos-escritorio` | Processos do Escritório Autogerenciável | `ac-agente-processos-escritorio` | sim | `R_kgDOTwOM8w` | passou | `49deb5d188e8aff68681954c6925999e98eba153` |
| `ac.fiscal` | Agente Fiscal Oficial | `ac-agente-fiscal` | sim | `R_kgDOTwONUQ` | passou | `92e6f04cb3ff9e6b1caa1542afd31ce8c2f4ee94` |
| `ac.dp` | Agente DP Oficial | `ac-agente-dp` | sim | `R_kgDOTwONuw` | passou | `f3af65260ea09873f2b940c3e0dd762627774d75` |
| `ac.societario` | Agente Societário Oficial | `ac-agente-societario` | sim | `R_kgDOTwOOBw` | passou | `8b0c38cc986d88c3db7e12bfdcc8b33a38cf0085` |
| `ac.estrategista-conteudo-dai` | Estrategista de Conteúdo D.A.I. Oficial | `ac-agente-estrategista-conteudo-dai` | sim | `R_kgDOTwOOUQ` | passou | `44c9a9170a3a9fa02f5d2c71832aa488b0f441ee` |
| `ac.reforma-tributaria` | Agente da Reforma Tributária Oficial | `ac-agente-reforma-tributaria` | sim | `R_kgDOTwOOpQ` | passou | `39c70682011547431600867c380f1df7d78dfbb4` |
| `ac.contabil` | Agente Contábil Oficial | `ac-agente-contabil` | sim | `R_kgDOTwOO8w` | passou | `85a1aca5f7349f38660e1610a132bf2719dc6217` |
| `ac.entrada-clientes` | Agente de Entrada de Clientes CEO | `ac-agente-entrada-clientes` | sim | `R_kgDOTwOPTg` | passou | `69855038fff8d811a09d1f15ab5ecec774c06c63` |
| `ac.captacao-clientes` | Agente de Captação de Clientes CEO | `ac-agente-captacao-clientes` | sim | `R_kgDOTwOPlg` | passou | `bf7c59820c31153a7360050f6cff4205d95a3c5a` |
| `ac.guia-operacao` | Agente Guia da Operação CEO | `ac-agente-guia-operacao` | sim | `R_kgDOTwOP4Q` | passou | `c496c8fa1199d4713bcd154f44f0c806dfd5d964` |
| `ac.reforma-tributaria-rag` | Reforma Tributária Day — Consulta RAG | `ac-agente-reforma-tributaria-rag` | sim | `R_kgDOTwOQNA` | passou | `5aff31e57bcc554e1df2613f0d2f7da833677e95` |
| `ac.reforma-tributaria-sem-surto` | Day Agente da Reforma Tributária Sem Surto | `ac-agente-reforma-tributaria-sem-surto` | sim | `R_kgDOTwOQkg` | passou | `8056b4c261d45e4a6eece57bf3925860d051292a` |

## Conteúdo mínimo canônico

Cada `agent.yaml` agora registra o ID do catálogo, nome humano canônico,
`owners: [Academia-de-Contadores]`, versão `0.1.0`, ciclo
`source-capture` e URL explícita do catálogo:
`https://github.com/Academia-de-Contadores/academia-contadores-agent-catalog`.

Os manifestos não apontam para componentes `example-*` do template. Foi
mantido apenas um placeholder estrutural neutro de avaliação,
`evaluations/source-capture.md`, que não introduz instruções ou comportamento
dos GPTs; a captura comportamental pertence à task posterior.

Fiscal, DP, Societário e Contábil têm somente o perfil
`profiles/public-safe/profile.yaml`, ligado a `canonical_agent_version:
0.1.0`, sem redefinir `agent.id`. Ele proíbe cálculo/apuração final,
assinatura/protocolo/transmissão e decisão individual/regulatória definitiva.

O repositório RAG contém somente `connectors/rag/README.md` como conector
declarado. O arquivo referencia o runtime externo
`Academia-de-Contadores/agente-ia-reforma-com-rag`; nenhum runtime, corpus,
índice, log, endpoint privado ou credencial foi copiado, e esse repositório
externo não foi alterado.

## Validações

- `bash scripts/validate-agent-repo.sh` passou em cada um dos 12 clones.
- As checagens de metadados confirmaram versão, lifecycle, owner e URL do
  catálogo em todos os manifests.
- Os quatro perfis foram confirmados na versão `0.1.0`, com três restrições e
  sem campo `agent`.
- Foi verificado que só o clone RAG possui `connectors/rag` e que nele há
  exclusivamente o README externo.
- Após as validações e a publicação dos clones, as 12 entradas de
  `catalog/agents.yaml` foram atualizadas de `migration` para
  `source-capture`.

## Concerns

Nenhum conflito ou falha de criação/validação. A captura de instruções e as
avaliações comportamentais permanecem intencionalmente fora deste
provisionamento.

