# minha-aplicacao

Aplicação FastAPI com os endpoints `GET /hello` e `GET /health`, entregue por uma esteira de entrega contínua no GitHub Actions (Checkpoint 1 — DevOps na Prática, UFLA).

## Esteira

Um `git push` na `main` executa `.github/workflows/pipeline.yml`, sem nenhum passo manual:

| # | Job | O que faz |
|---|-----|-----------|
| 1 | `gate` | `ruff` (lint), `pytest` e cobertura mínima de 80%, em matriz Python 3.11 e 3.12 |
| 2 | `publicar` | deriva a versão dos Conventional Commits (`paulhatch/semantic-version`) |
| 3 | `publicar` | constrói a imagem **uma vez** e publica no GHCR com as tags `X.Y.Z` e `sha-<commit>` |
| 4 | `release` | cria a tag `vX.Y.Z` e o release no GitHub com notas geradas |
| 5 | `staging` | implanta a mesma imagem via `docker compose`; o healthcheck confirma que subiu |

Em Pull Requests para a `main`, roda apenas o `gate`.

### Versionamento (Conventional Commits)

| Commit | Incremento | Exemplo |
|--------|------------|---------|
| `feat!:` ou `BREAKING CHANGE` no corpo | major | 2.1.0 → 3.0.0 |
| `feat:` | minor | 2.1.0 → 2.2.0 |
| qualquer outro (`fix:`, `docs:`, `ci:`...) | patch | 2.1.0 → 2.1.1 |

### Tags imutáveis

Antes do push, a esteira verifica se a versão já existe no GHCR e falha se existir: uma tag publicada nunca é sobrescrita. Não há tag `latest`.

## Implantar e voltar atrás

```bash
./scripts/deploy.sh 2.1.1   # implanta a versão 2.1.1 em staging
./scripts/deploy.sh 2.1.0   # rollback: o mesmo comando, com a versão anterior
curl http://localhost:8080/health   # {"status":"ok","versao":"2.1.0"}
```

O rollback também pode ser demonstrado pelo workflow manual **Rollback (demonstracao)** (aba Actions → Run workflow), que sobe a versão atual, volta para a anterior e confirma pelo `/health`.

## Desenvolvimento local

```bash
pip install -r requirements-dev.txt
ruff check .
pytest
```

## Imagens

- GHCR: `ghcr.io/henrique117/minha-aplicacao`
- Versões anteriores (atividade de Docker): `iccy11706/minha-aplicacao:1.0` e `:2.0` no Docker Hub

Linha teste para rollback.
