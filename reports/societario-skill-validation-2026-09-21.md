# Validação da skill Societário — 2026-09-21

## Resultado

O catálogo registra `ac.societario` na versão `0.2.0`, com lifecycle
`validated`, perfis `canonical` e `public-safe`, skill `$ac-societario` e
commit-fonte `cfc37188f405197615120de7f9007a39d5e75236`.

O GPT principal permanece
`g-6a725963258081919e7c1824531b1b6d`. A comparação funcional registra PASS
local em 6/6 e PASS online em 6/6 casos. Na rubrica de 12 pontos, P1, P2, P3,
P5 e P6 atingiram 12/12; P4 atingiu 11/12 e preservou os três gates
obrigatórios. A revisão final independente terminou com 0 Critical, 0 Important
e 0 Minor. O GPT online não foi alterado.

## Evidências

- comparação funcional: `evaluations/parity/gpt-comparison-2026-09-21.md`;
- confronto com originais: `evaluations/parity/original-source-verification-2026-09-21.md`;
- instalação: `evaluations/parity/install-validation-2026-09-21.md`;
- respostas e notas do forward test: `evaluations/parity/local-results-2026-09-21.md`;
- gate consolidado: `evaluations/parity/release-validation-2026-09-21.md`.

Os caminhos acima são relativos ao repositório
`https://github.com/Academia-de-Contadores/ac-agente-societario.git`. O artefato
operacional durável é a versão `0.2.0` em `main` ou a tag `v0.2.0` que aponte
para o mesmo conteúdo; o catálogo fixa o commit exato independentemente do nome
da branch usada na preparação.

## Instalação

- Caminho validado: `/Users/levy/.codex/skills/ac-societario`.
- Inventário: 22 arquivos regulares, dez arquivos de Knowledge, zero symlinks
  e zero `.gitkeep`.
- Igualdade origem × instalação: PASS 22/22 por caminho e bytes.
- SHA-256 reproduzível do inventário:
  `b481886fdb5efa8180f4a45156128e31e4c5561688950832c139291f7b0349b1`.
- `quick_validate.py`: PASS na origem e na instalação.

## Integridade do catálogo

As 12 famílias canônicas e os 37 aliases permanecem registrados. As outras
11 entradas de `catalog/agents.yaml` e `catalog/live-parity.yaml` permanecem
estruturalmente idênticas à base `01f0085`; `catalog/aliases.yaml` e o snapshot
de Builder não foram modificados.

## Limites

- Os dez nomes de Knowledge foram reconfirmados no editor, mas os bytes online
  atuais não foram obtidos. A paridade binária atual continua como gap
  documentado; a captura de 2026-08-22 é a baseline provisória.
- O pack cita 13 IDs distintos `CE-PROC-SOC-*`; os primários correspondentes
  continuam ausentes e não verificados. O pack é curadoria interna, não fonte
  oficial vigente.
- O GPT tem busca web; o forward test local foi isolado da internet. A skill
  identifica a fonte oficial a consultar quando a conclusão depende de regra,
  documento ou prazo local atual.

## Rulings

1. A captura binária de 2026-08-22 foi mantida por ser a última geração com
   bytes e hashes comprovados. Se estiver errada, o pacote deverá ser trocado e
   todos os gates repetidos.
2. Os gaps de bytes online e dos 13 `CE-PROC-SOC-*` não bloqueiam esta release
   porque a skill não os apresenta como fontes oficiais e exige validação antes
   de conclusão normativa, documento final ou protocolo. Se essa salvaguarda for
   insuficiente, o lifecycle deve voltar a `candidate`.
3. P4 com 11/12 foi aceito porque supera o limiar de 10/12 e tem nota 2 nos
   três gates obrigatórios. Se handoff formal completo for requisito absoluto,
   P4 precisará de correção e novo forward test.
