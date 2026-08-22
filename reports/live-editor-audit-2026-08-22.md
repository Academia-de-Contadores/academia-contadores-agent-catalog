# Auditoria do GPT Builder ao vivo — 2026-08-22

> **Atualização de escopo:** esta auditoria inicial identificou o GPT público
> `g-6a6ea5f0985c8191971aa805e5ad759f` de Processos sem anexos. A verificação
> integral posterior em `reports/live-parity-2026-08-22.md` confirmou que o
> editor canônico do catálogo é o rascunho
> `g-6a725900102c8191bdcb028b9ab4f21a`, que possui quatro anexos idênticos ao
> Git. Os dois IDs devem ser tratados como variantes distintas.

## Método e limite

O editor autenticado do ChatGPT foi a fonte de verdade. Foram comparados os
nomes mostrados em `Conhecimento` nos 12 GPTs canônicos com os arquivos de
`knowledge/original/` de seus repositórios. Para o RAG, o duplo clique no nome
do anexo baixou os arquivos atuais, que foram preservados com SHA-256.

## Correspondência de nomes

| Agente canônico | Anexos no Builder | Resultado de nomes |
| --- | ---: | --- |
| `ac.fiscal` | 10 | correspondem ao conjunto histórico de 10/10 |
| `ac.dp` | 16 | correspondem ao conjunto histórico de 16/16 |
| `ac.societario` | 10 | correspondem ao conjunto histórico de 10/10 |
| `ac.estrategista-conteudo-dai` | 11 | correspondem ao conjunto histórico de 11/11 |
| `ac.reforma-tributaria` | 8 | correspondem ao conjunto histórico de 8/8 |
| `ac.contabil` | 10 | correspondem ao conjunto histórico de 10/10 |
| `ac.entrada-clientes` | 10 | correspondem ao conjunto histórico de 10/10 |
| `ac.captacao-clientes` | 14 | correspondem ao conjunto histórico de 14/14 |
| `ac.guia-operacao` | 16 | correspondem ao conjunto histórico de 16/16 |
| `ac.reforma-tributaria-sem-surto` | 6 | correspondem ao conjunto histórico de 6/6 |

## Deltas que exigem controle explícito

### `ac.processos-escritorio`

O GPT publicado exibe zero anexos; o repositório preserva quatro arquivos
históricos recuperados em 2026-08-07. O manifesto do agente agora diferencia
explicitamente backup histórico de configuração ativa.

### `ac.reforma-tributaria-rag`

O GPT ao vivo, editado em 2026-08-21, exibe oito nomes novos de anexos e uma
nova instrução/Action. A configuração visível foi preservada no repositório do
agente: instrução atual, schema OpenAPI atual e os oito anexos atuais, todos
com SHA-256 em `knowledge/live-2026-08-22/MANIFEST.md`. A captura histórica foi
mantida como versão separada.

### GPT societário adicional

`Agente Societário temporario - Bianca CEO` foi encontrado no editor e
registrado em `catalog/aliases.yaml` como variante temporária de
`ac.societario`. Ele exibe os mesmos dez nomes de anexos do agente canônico;
o conteúdo permanece não comparado por hash.
