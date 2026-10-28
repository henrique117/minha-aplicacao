import os

from fastapi import FastAPI
from fastapi.responses import PlainTextResponse

# A versao e gravada na imagem durante o build (ARG VERSAO no Dockerfile).
APP_VERSION = os.getenv("APP_VERSION", "dev")

app = FastAPI(title="minha-aplicacao", version=APP_VERSION)


@app.get("/hello", response_class=PlainTextResponse)
def hello() -> str:
    return "Hello World 2"


@app.get("/health")
def health() -> dict[str, str]:
    """Usado pelo healthcheck do docker compose e para conferir a versao no ar."""
    return {"status": "ok", "versao": APP_VERSION}
