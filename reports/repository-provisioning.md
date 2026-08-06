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
| `ac.processos-escritorio` | Processos do Escritório Autogerenciável | `ac-agente-processos-escritorio` | sim | `R_kgDOTwOM8w` | passou | `e4025b1535b0bb8d4a040d9e430a1e969fe3cc9f` |
| `ac.fiscal` | Agente Fiscal Oficial | `ac-agente-fiscal` | sim | `R_kgDOTwONUQ` | passou | `9e9711db9544e4999fbe35e5ac291823eb9884e3` |
| `ac.dp` | Agente DP Oficial | `ac-agente-dp` | sim | `R_kgDOTwONuw` | passou | `7d5ee9f81606ced5a8bff79730edd01b5fa6d278` |
| `ac.societario` | Agente Societário Oficial | `ac-agente-societario` | sim | `R_kgDOTwOOBw` | passou | `ac50cf276c3e0f96a5c0613ecb20e1a13c44992d` |
| `ac.estrategista-conteudo-dai` | Estrategista de Conteúdo D.A.I. Oficial | `ac-agente-estrategista-conteudo-dai` | sim | `R_kgDOTwOOUQ` | passou | `eba1ac1e88d7ce85ac94d56061399a863a355b0d` |
| `ac.reforma-tributaria` | Agente da Reforma Tributária Oficial | `ac-agente-reforma-tributaria` | sim | `R_kgDOTwOOpQ` | passou | `9c1e6face47aae7c3510e5dd9e07e28706804cb2` |
| `ac.contabil` | Agente Contábil Oficial | `ac-agente-contabil` | sim | `R_kgDOTwOO8w` | passou | `4c0a5d1077cbb9ddbd1ab0d89db935721df39284` |
| `ac.entrada-clientes` | Agente de Entrada de Clientes CEO | `ac-agente-entrada-clientes` | sim | `R_kgDOTwOPTg` | passou | `53317fe70b7925bfd0d9269374a7c61cee80cd2b` |
| `ac.captacao-clientes` | Agente de Captação de Clientes CEO | `ac-agente-captacao-clientes` | sim | `R_kgDOTwOPlg` | passou | `0a06f8290930f85b2f7f014037dd508341c35b51` |
| `ac.guia-operacao` | Agente Guia da Operação CEO | `ac-agente-guia-operacao` | sim | `R_kgDOTwOP4Q` | passou | `c9181d801361540762c83184d0fea2cd6bdb3646` |
| `ac.reforma-tributaria-rag` | Reforma Tributária Day — Consulta RAG | `ac-agente-reforma-tributaria-rag` | sim | `R_kgDOTwOQNA` | passou | `8381c1b8d8281b6a016a5c29df467a71e4549d01` |
| `ac.reforma-tributaria-sem-surto` | Day Agente da Reforma Tributária Sem Surto | `ac-agente-reforma-tributaria-sem-surto` | sim | `R_kgDOTwOQkg` | passou | `b6a4a29db43c6d10ab081556021032015e3356a9` |

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

- A suíte `bash tests/validate-agent-repo.test.sh && bash scripts/validate-agent-repo.sh` passou em cada um dos 12 clones após a correção dos fixtures neutros; cada HEAD local foi confirmado igual a `origin/main`.
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
