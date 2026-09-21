# Validação da skill Fiscal — 2026-09-21

## Resultado

O catálogo registra `ac.fiscal` na versão `0.2.0`, com lifecycle `validated`,
perfis `canonical` e `public-safe`, skill `$ac-fiscal` e commit-fonte
`e656327b3e74ebf4dbd7b74bec69461ccf2338f9`.

O GPT principal permanece
`g-6a72595c828c8191aec02f7931d9c626`. Os seis casos locais qualificam, com
65/72 pontos: P1 11/12, P2 10/12, P3 10/12, P4 12/12, P5 11/12 e P6 11/12.
P4 foi a única resposta rerodada após a correção; os demais resultados foram
preservados da rodada integral anterior. A skill foi corrigida sem alterar o
GPT online.

A baseline online congelada qualificou 2/6 casos sob a rubrica mais rígida da
skill. Isso não é gate de release: o GPT é a fonte preservada de identidade e a
skill deve ser mais útil e mais explícita nos gates de fonte, evidência e
aprovação, sem fabricar conclusões.

## Evidências

- comparação funcional inicial:
  `evaluations/parity/gpt-comparison-2026-09-21.md`;
- corretiva e comparação final de P4:
  `evaluations/parity/gpt-comparison-2026-09-21-r2.md`;
- respostas locais e composição final:
  `evaluations/parity/local-results-2026-09-21-r2.md`;
- respostas reais congeladas do GPT:
  `evaluations/parity/gpt-outputs-2026-09-21.md`;
- auditoria do editor e das fontes:
  `evaluations/live-editor-audit-2026-09-21.md`;
- instalação e gate de release:
  `evaluations/parity/release-validation-2026-09-21.md`.

Os caminhos acima são relativos ao repositório
`https://github.com/Academia-de-Contadores/ac-agente-fiscal.git`. O artefato
operacional durável é a versão `0.2.0` em `main` ou a tag `v0.2.0` que aponte
para o mesmo conteúdo; o catálogo fixa o commit exato da preparação.

## Instalação

- Caminho validado: `/Users/levy/.codex/skills/ac-fiscal`.
- Inventário: 23 arquivos regulares, dez arquivos de Knowledge, zero symlinks
  e zero `.gitkeep`.
- Igualdade origem × instalação: PASS 23/23 por caminho e bytes.
- SHA-256 reproduzível do inventário:
  `1dbaf695e412120a7dab360b34cdd636fd19c363c323560a2890e3dd0a0446b0`.
- O mesmo hash foi reproduzido em um pacote temporário montado somente com a
  allowlist; `quick_validate.py` passou na origem e na instalação.

## Integridade do catálogo

As 12 famílias canônicas e os 37 aliases permanecem registrados. Os quatro
registros de `catalog/aliases.yaml` que apontam para `ac.fiscal` — temporário,
rascunho temporário, cópia oficial em rascunho e guia de rotinas superseded —
continuam com `repository_created: false`. Nenhum repositório ou skill
duplicada foi criado. As outras 11 entradas canônicas permanecem inalteradas
em relação à base `f3f5c79`.

## Paridade e limites

- As instruções do editor e o corpo canônico local coincidem byte a byte:
  4.461 bytes, 134 linhas e SHA-256
  `12775f4f9fbf7b0b3fa62a06c6837f920944cbd0a49f1d7ab2eb90453787893b`.
- Os dez nomes de Knowledge foram reconfirmados no editor, mas os bytes online
  atuais não foram obtidos; a paridade binária atual permanece `GAP`.
- Nove arquivos históricos em `knowledge/original/` contêm material de DP e
  são excluídos da allowlist. A skill usa somente o índice Fiscal e os nove
  arquivos da captura de 2026-08-22.
- A interface mostra `Thinking 5.6` no seletor e `GPT-5.6 Sol` na prévia; não há
  base para inferir um único identificador interno.
- Os primários internos citados pelo Knowledge continuam ausentes. A curadoria
  não é apresentada como fonte oficial vigente.

## Rulings

1. A captura de 2026-08-22 permanece baseline documental provisória por ser a
   última geração Fiscal com bytes e hashes comprovados. Uma substituição exige
   nova versão e repetição dos gates de integridade, comportamento e instalação.
2. O gap dos bytes online atuais não bloqueia a release porque a skill exige
   fonte oficial competente antes de concluir regra, classificação, cálculo ou
   guia.
3. O gate de release é 6/6 local. A baseline online preserva identidade e não
   precisa satisfazer os gates adicionais que tornam a skill mais útil e segura.
