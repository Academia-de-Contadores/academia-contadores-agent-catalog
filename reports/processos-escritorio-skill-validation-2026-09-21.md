# Validação da skill Processos do Escritório — 2026-09-21

## Resultado

O catálogo registra `ac.processos-escritorio` na versão `0.2.0`, com lifecycle
`validated`, perfil `canonical`, skill `$ac-processos-escritorio` e
commit-fonte `b892b553fadd92aa33c0927f5862c8748d353be0`.

O GPT principal permanece
`g-6a725900102c8191bdcb028b9ab4f21a`. Os seis casos foram executados localmente
e comparados com as seis respostas reais congeladas do GPT online. O resultado
consolidado local é PASS em 6/6, com 71/72 pontos: P1 a P5 atingiram 12/12 e P6
atingiu 11/12; todos preservaram os quatro gates obrigatórios. As correções
foram feitas apenas na skill, sem alteração do GPT online.

## Evidências

- comparação funcional consolidada:
  `evaluations/parity/gpt-comparison-2026-09-21-r3.md`;
- confronto com originais:
  `evaluations/parity/original-source-verification-2026-09-21.md`;
- respostas locais iniciais:
  `evaluations/parity/local-results-2026-09-21.md`;
- respostas locais da correção de P1:
  `evaluations/parity/local-results-2026-09-21-r2.md`;
- respostas locais da correção final de P2:
  `evaluations/parity/local-results-2026-09-21-r3.md`;
- respostas reais congeladas do GPT:
  `evaluations/parity/gpt-outputs-2026-09-21.md`;
- instalação e gate de release:
  `evaluations/parity/release-validation-2026-09-21.md`.

Os caminhos acima são relativos ao repositório
`https://github.com/Academia-de-Contadores/ac-agente-processos-escritorio.git`.
O artefato operacional durável é a versão `0.2.0` em `main` ou a tag `v0.2.0`
que aponte para o mesmo conteúdo; o catálogo fixa o commit exato da preparação.

## Instalação

- Caminho validado: `/Users/levy/.codex/skills/ac-processos-escritorio`.
- Inventário: 17 arquivos regulares, quatro arquivos de Knowledge, zero
  symlinks e zero `.gitkeep`.
- Igualdade origem × instalação: PASS 17/17 por caminho e bytes.
- SHA-256 reproduzível do inventário:
  `aefecda60fec08f59ddca76c537c7ddb51c76d1711559ea71ff199fe3efe1de7`.
- O mesmo hash foi reproduzido em um pacote temporário montado somente com a
  allowlist; `quick_validate.py` passou na instalação e no pacote temporário.

## Integridade do catálogo

As 12 famílias canônicas e os 37 aliases permanecem registrados. Os dois
registros de `catalog/aliases.yaml` que apontam para
`ac.processos-escritorio` — o rascunho canônico e a variante publicada
`copy` — continuam com `repository_created: false`: nenhum repositório nem
skill duplicada foi criado. As outras 11 entradas canônicas permanecem
inalteradas em relação à base `3954043`.

## Limites

- Os quatro nomes de Knowledge foram reconfirmados no editor, mas os bytes
  online atuais não foram obtidos. A captura comprovada de 2026-08-07 continua
  como baseline reversível; a paridade binária atual permanece `GAP`.
- O pack é material interno e não comprova lei, prazo oficial, prática atual do
  escritório ou fonte externa anterior.
- A privacidade atual do rascunho canônico não foi exposta no editor e permanece
  uma lacuna de configuração, sem inferência.
- P2 valida a resposta diante de artefato-fonte ausente; não comprova extração
  de um rascunho real nem correção técnica trabalhista.

## Rulings

1. A captura binária de 2026-08-07 permanece como baseline por ser a última com
   bytes e hashes comprovados. Uma substituição exige repetir integridade,
   instalação, comportamento e paridade.
2. O gap dos bytes online atuais não bloqueia a release porque a skill trata o
   pack como método interno e exige fonte aplicável antes de afirmar regra,
   prazo ou obrigação.
3. P6 com 11/12 foi aceito porque supera o limiar de 10/12 e preserva os quatro
   gates obrigatórios. Uma mudança futura nesse contrato exige nova avaliação.
