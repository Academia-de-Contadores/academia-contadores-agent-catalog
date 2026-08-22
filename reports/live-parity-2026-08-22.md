# Paridade GPT Builder ↔ GitHub — 2026-08-22

## Escopo e método

Foram auditados os 12 editores canônicos definidos em
`catalog/live-parity.yaml`, usando o GPT Builder autenticado como fonte de
verdade. A coleta foi somente leitura; cada anexo de Knowledge foi baixado e
comparado por SHA-256 e tamanho em bytes.

A evidência estruturada está em
`snapshots/2026-08-22/builder-evidence.json`. Ela registra nome, descrição,
iniciadores, recursos, instruções, Action, lista de Knowledge e o arquivo
local que representa cada anexo ativo.

## Resultado

| Critério | Resultado |
| --- | --- |
| Editores canônicos auditados | 12/12 |
| Instruções idênticas ao Builder | 12/12 |
| Anexos baixados e comparados | 115/115 |
| Anexos já idênticos ao histórico | 61 |
| Anexos atualizados em snapshot `live-2026-08-22` | 54 |
| Anexos ativos no GPT `ac.reforma-tributaria` | 0 |
| Action RAG com schema local validado | 1/1 |
| Bloqueios de coleta | 0 |

O schema OpenAPI da Action RAG também foi comparado semanticamente com o
Builder: SHA-256 `eb8334171902c9c6471e1079c5e1098334c8b23b426e983c16fe88440899f7d5`.
O verificador recalcula esse hash a partir do arquivo versionado.

Os 54 arquivos que mudaram foram preservados em snapshots separados nos
repositórios de Captação, Contábil, Entrada, Conteúdo, Fiscal e Societário.
Os arquivos em `knowledge/original/` continuam como registros históricos de
2026-08-07 e não foram sobrescritos.

## Deltas resolvidos

- `ac.contabil`: a instrução atual contém o título `# Contabil - Prompt v3
  Beta GPT Builder`; a nova captura aponta para
  `instructions/current-live-2026-08-22.md`.
- `ac.reforma-tributaria`: o GPT ao vivo está em modo de acesso temporário
  encerrado, sem Knowledge e sem recursos. A instrução atual e o manifesto
  vazio foram preservados; a configuração técnica anterior permanece
  explicitamente histórica.
- `ac.captacao-clientes`, `ac.contabil`, `ac.entrada-clientes`,
  `ac.estrategista-conteudo-dai`, `ac.fiscal` e `ac.societario`: os nomes dos
  anexos coincidem com o histórico, mas nove arquivos de cada agente tinham
  conteúdo novo. Os hashes atuais estão nos manifestos `live-2026-08-22`.

## Processos: editor canônico versus variante pública

O editor canônico de `ac.processos-escritorio`,
`g-6a725900102c8191bdcb028b9ab4f21a`, está em rascunho e possui os quatro
anexos versionados; todos foram confirmados por hash. A observação anterior de
zero anexos refere-se ao GPT público distinto `g-6a6ea5f0985c8191971aa805e5ad759f`.
Ele não substitui o editor canônico no inventário de paridade e continua sendo
uma variante a registrar separadamente.

## Comando de verificação

```bash
bash scripts/validate-live-parity.sh snapshots/2026-08-22/builder-evidence.json
```

O comando retorna sucesso apenas quando todos os arquivos e instruções locais
continuam com os hashes registrados da captura do Builder.
