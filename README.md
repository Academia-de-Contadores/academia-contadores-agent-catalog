# Catálogo canônico de agentes

Este catálogo indexa as fontes canônicas dos agentes personalizados da Academia de Contadores. Cada `agent.id` aponta para um único repositório canônico.

Aliases registram apenas nome, URL e relação com a fonte canônica; eles não carregam instruções e não recebem repositórios próprios.

## Validação

```bash
bash scripts/validate-catalog.sh
```

## Paridade com o GPT Builder

`catalog/live-parity.yaml` define os 12 editores canônicos. A captura
versionada em `snapshots/2026-08-22/builder-evidence.json` registra os campos
visíveis no Builder e o SHA-256 de cada anexo baixado. Para confirmar que os
arquivos locais ainda correspondem a essa evidência, execute:

```bash
bash scripts/validate-live-parity.sh snapshots/2026-08-22/builder-evidence.json
```

O comando só retorna sucesso quando instruções, arquivos de Knowledge, bytes,
hashes e a Action RAG registrada no snapshot ainda são idênticos à captura do
Builder. Ele não altera o GPT nem baixa arquivos.

## Proteções no GitHub

O repositório remoto é privado. No plano atual da organização, a API do GitHub
não disponibiliza rulesets para este repositório privado (HTTP 403) nem secret
scanning/push protection (HTTP 422). Rulesets e branch protection não estão
disponíveis para repositórios privados no plano atual; portanto, `main`
permanece sem proteção e não há gate de merge remoto. A validação local do
catálogo é o controle preventivo ativo antes de cada publicação. Consulte
`reports/task-3-report.md` para a evidência e os limites exatos.
