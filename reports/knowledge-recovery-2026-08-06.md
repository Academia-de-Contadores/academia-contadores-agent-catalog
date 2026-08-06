# Recuperação de Knowledge e Actions — 2026-08-06

## Resultado publicado

Os prompts/instructions já estavam preservados nos 12 repositórios. Nesta etapa foram incorporados, sem modificar o conteúdo:

| Agente | Artefato recuperado | Commit |
| --- | --- | --- |
| Fiscal | `01-REGRAS-DE-USO-E-LIMITES.md` | `432ece5` |
| DP | `01-REGRAS-DE-USO-E-LIMITES.md` | `f83d23b` |
| Societário | `01-REGRAS-DE-USO-E-LIMITES.md` | `83e907b` |
| Contábil | `01-REGRAS-DE-USO-E-LIMITES.md` | `a3e5e9d` |
| Reforma Tributária | pacote-fonte RAG de 20 arquivos e OpenAPI de `searchDayRagCorpus` | `b664832` |
| Reforma Tributária RAG | pacote-fonte RAG de 20 arquivos e OpenAPI de `searchDayRagCorpus` | `c4dab64` |

Todos foram comparados byte a byte à fonte local antes da publicação. Os hashes e a origem constam no `knowledge/MANIFEST.md` de cada repositório; a Action contém também `connectors/actions/searchDayRagCorpus/README.md`.

## Limite comprovado

Nos editores autenticados do ChatGPT, o painel Knowledge exibiu os nomes dos anexos e o botão de remover, mas não ofereceu uma ação de download. A tentativa por interface não expôs o corpo dos arquivos. Por isso não é correto afirmar que os demais anexos foram recuperados.

Permanecem pendentes os arquivos cujos nomes estão em `evaluations/source-capture.md`: 9 de Fiscal, 15 de DP, 9 de Societário, 9 de Contábil e todos os anexos dos outros seis agentes sem fonte local correspondente. Para o RAG, o pacote local completo foi preservado, mas a correspondência individual com os oito nomes exibidos pelo editor que diferem de nome ainda precisa de confirmação.

Nenhuma credencial, token, configuração de autenticação ou índice/corpus foi versionado. A varredura dos novos artefatos não encontrou marcadores de segredo.
