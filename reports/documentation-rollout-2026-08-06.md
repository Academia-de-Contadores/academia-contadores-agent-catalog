# Rollout dos manuais operacionais — 2026-08-06

## Resultado da correção final

O template e os 12 agentes receberam a correção final do contrato documental.
Os SHAs abaixo foram publicados em `origin/main` e conferidos após o push.

Os quatro documentos obrigatórios continuam sendo `README.md`,
`HOW-TO-USE.md`, `docs/REPOSITORY-STRUCTURE.md` e
`governance/CONTRIBUTING.md`. Nos agentes, o README agora descreve o agente
existente, traz metadados e propósito específicos e explica somente proteções
comprováveis pelos arquivos versionados.

| Repositório | URL | Base | Commit publicado | Teste + validador + `diff --check` |
| --- | --- | --- | --- | --- |
| Template | [academia-contadores-agent-template](https://github.com/Academia-de-Contadores/academia-contadores-agent-template) | `5bd77dc90ef092ca8c6e3dabd36a23b6283f4b21` | `340b742b9f38f3bfebcd86437ba37445e259d173` | PASS |
| Captação de clientes | [ac-agente-captacao-clientes](https://github.com/Academia-de-Contadores/ac-agente-captacao-clientes) | `e3d524859f9ad10bf7bb053eee81c5ee0706c7e2` | `74140513a05a8d82e6b81f18b14953dc0f69c312` | PASS |
| Contábil | [ac-agente-contabil](https://github.com/Academia-de-Contadores/ac-agente-contabil) | `a01e23ffa39f2f3693f83d31bca0dccf64e21a1e` | `db7a43e0ad4776abefd7b8279ba4e8decb55f792` | PASS |
| DP | [ac-agente-dp](https://github.com/Academia-de-Contadores/ac-agente-dp) | `1d58b2f821763305799f570e90fa3b34a85290cb` | `b390f769beb76f064cfbcb44aa6211e0223b902c` | PASS |
| Entrada de clientes | [ac-agente-entrada-clientes](https://github.com/Academia-de-Contadores/ac-agente-entrada-clientes) | `1ca3a8f0cb54c4d5b04e8cc33681329221c32e76` | `b40219b069e4f4ae79cad904c3fefe75b1cb1747` | PASS |
| Estrategista de Conteúdo DAI | [ac-agente-estrategista-conteudo-dai](https://github.com/Academia-de-Contadores/ac-agente-estrategista-conteudo-dai) | `b4ac9d6887fa62dc155effdb44464fa0324b404d` | `046e698b3bb44680b4ad5a54e6d4aa0a28b3e099` | PASS |
| Fiscal | [ac-agente-fiscal](https://github.com/Academia-de-Contadores/ac-agente-fiscal) | `4960171096aa662fa8d338f72196e956075ba5a6` | `58630fdf54f9f5d21033f434e900f169eb0cf6d7` | PASS |
| Guia de operação | [ac-agente-guia-operacao](https://github.com/Academia-de-Contadores/ac-agente-guia-operacao) | `097fa231ed46f0828978f3c5ce8b74968b1a8aae` | `7c5e9542ea8db305539605db7cbcb85bdfe2679a` | PASS |
| Processos de escritório | [ac-agente-processos-escritorio](https://github.com/Academia-de-Contadores/ac-agente-processos-escritorio) | `d881521ed5686a400525e72caaab035f46128ee9` | `677719985a602298b51d50261c221b61a4443e7e` | PASS |
| Reforma Tributária | [ac-agente-reforma-tributaria](https://github.com/Academia-de-Contadores/ac-agente-reforma-tributaria) | `06f0d52702232ce954f8f18fb78205d2921834c9` | `96021f42d2bc42af46319521e38fcab5d2aaaa33` | PASS |
| Reforma Tributária RAG | [ac-agente-reforma-tributaria-rag](https://github.com/Academia-de-Contadores/ac-agente-reforma-tributaria-rag) | `6cf5b5d0a7c42612ce1e35043b78c5e700f56f7d` | `25fed9f1a13a864d99699a2f2c16cd84a05a4b35` | PASS |
| Reforma Tributária sem surto | [ac-agente-reforma-tributaria-sem-surto](https://github.com/Academia-de-Contadores/ac-agente-reforma-tributaria-sem-surto) | `f149b76c01574b340965339465e8c634bc164537` | `3f8db7d4dcdb9045ec9a1c2a17c60f5e2a33cf8f` | PASS |
| Societário | [ac-agente-societario](https://github.com/Academia-de-Contadores/ac-agente-societario) | `1da0bdcbcdbf3b9d745f1ad7491b4046fcfdb930` | `38fe12e91f5107344f6fe6a959c60ab080dd4d33` | PASS |

## Escopo corrigido

- Os 12 READMEs não instruem mais criar ou substituir o agente nem afirmam que
  os repositórios são templates. Nome, ID, versão e lifecycle vêm de
  `agent.yaml`; o propósito vem de `objectives/mission.md`.
- `docs/REPOSITORY-STRUCTURE.md` passou a normatizar `agent.yaml`, `.gitignore`,
  `.github/` e os documentos raiz com definição, conteúdo permitido e proibido,
  exemplo e exigência de avaliação ou revisão.
- O validador exige as quatro novas seções, e as suítes exercitam um caso
  negativo para cada ausência.
- Os 12 agentes preservam 5 cenários T, 3 H e 3 S; os dois agentes que declaram
  RAG preservam também C1.

## Evidência de validação

Foi executado, no template e em cada agente:

```bash
bash tests/validate-agent-repo.test.sh
bash scripts/validate-agent-repo.sh
git diff --check
```

Resultado: `13/13` suítes aprovadas, `13/13` validadores aprovados e `13/13`
checagens de diff aprovadas. A mutação inicial sem `## Manifesto agent.yaml`
foi rejeitada antes da implementação; após a correção, a suíte rejeita a
ausência de cada uma das quatro novas seções.

A referência estrutural é byte a byte idêntica no template e nos 12 agentes.
`HOW-TO-USE.md` e `governance/CONTRIBUTING.md` permaneceram byte a byte
idênticos. O validador específico é byte a byte idêntico entre os 12 agentes e
mantém a cobertura adicional de cenários; o template usa a variante apropriada
ao seu fixture de exemplo.

## Validação do catálogo

Também foi executado no catálogo:

```bash
bash tests/validate-catalog.test.sh
bash scripts/validate-catalog.sh
git diff --check
```

`unknown canonical_agent_id: ac.missing` é a saída negativa esperada da suíte.

## Auditoria pós-publicação

Depois do push, a auditoria confirmou:

- **14/14** worktrees limpas;
- **14/14** repositórios com `HEAD == origin/main`;
- **14/14** repositórios privados no GitHub;
- **13/13** repositórios do rollout contendo os quatro documentos obrigatórios;
- referência estrutural idêntica nos 13 repositórios, SHA-256
  `00bb021d66fefcc8cdc7bd3657a93c2870db7c3ff563cf07302b698a4170bdda`.

O total de 14 inclui template, catálogo e 12 agentes. O total de 13 do rollout
inclui template e 12 agentes; o catálogo apenas indexa e registra as evidências.
