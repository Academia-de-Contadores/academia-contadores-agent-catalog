# Relatório da Task 3 — publicação do catálogo

Data: 2026-08-06

## Resultado

- Remoto: https://github.com/Academia-de-Contadores/academia-contadores-agent-catalog
- Visibilidade: privada.
- Repositório-template: não.
- Branch padrão: `main`.
- Push inicial: commit `abca62b` (`docs: add task 1 report`).

## Validação local anterior à publicação

A invocação literal prevista no plano, a partir do diretório pai,

```bash
bash academia-contadores-agent-catalog/scripts/validate-catalog.sh
```

retornou exit code `1` porque o script procura `catalog/agents.yaml` no diretório
de trabalho do chamador. Sem alterar o validador, ele foi executado novamente a
partir da raiz do catálogo:

```bash
cd academia-contadores-agent-catalog
bash scripts/validate-catalog.sh
```

Resultado: exit code `0`, confirmando 12 agentes, 12 IDs distintos, 12 nomes de
repositório distintos e pelo menos um alias.

## Publicação

```bash
gh repo create Academia-de-Contadores/academia-contadores-agent-catalog \
  --private --source academia-contadores-agent-catalog --remote origin --push
```

O GitHub confirmou `private: true`, `is_template: false` e
`default_branch: main`.

## Ruleset e segurança

A consulta à API de rulesets retornou HTTP 403:

> Upgrade to GitHub Pro or make this repository public to enable this feature.

Por isso não foi possível criar um ruleset para `main`. Branch protection
também não está disponível para este repositório privado no plano atual.
Portanto, `main` permanece sem proteção e não há gate de merge remoto. O
repositório não foi tornado público e a limitação não foi contornada.

A tentativa de ativar `secret_scanning` e
`secret_scanning_push_protection` retornou HTTP 422:

> Secret scanning is not available for this repository.

A validação local de `scripts/validate-catalog.sh` é o controle preventivo
ativo antes da publicação; não há workflow ou configuração remota que bloqueie
merge ou push direto para `main`. O catálogo contém somente metadados
canônicos e aliases; segredos, conversas, dados de clientes, logs e artefatos
operacionais continuam proibidos pela política documentada do projeto.
