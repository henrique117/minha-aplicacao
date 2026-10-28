#!/usr/bin/env bash
# Implanta uma versao da imagem em staging com docker compose.
#   Uso:      ./scripts/deploy.sh <versao>        ex.: ./scripts/deploy.sh 2.1.0
#   Rollback: o mesmo comando, passando a versao anterior.
set -euo pipefail

VERSAO="${1:?uso: $0 <versao>  (ex.: 2.1.0)}"
export VERSAO
cd "$(dirname "$0")/.."

echo ">> Implantando ${IMAGEM:-ghcr.io/henrique117/minha-aplicacao}:${VERSAO} em staging"
docker compose pull

# --wait so retorna quando o healthcheck do compose declarar o container saudavel.
if ! docker compose up -d --wait --wait-timeout 60; then
  echo "!! Healthcheck falhou. Logs do container:"
  docker compose logs
  exit 1
fi

echo ">> Container saudavel. Versao no ar:"
curl -fsS http://localhost:8080/health
echo
curl -fsS http://localhost:8080/hello
echo
