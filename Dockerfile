FROM python:3.12-slim

# Liga o pacote do GHCR a este repositorio.
LABEL org.opencontainers.image.source="https://github.com/henrique117/minha-aplicacao"

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ ./app

# A versao derivada pela pipeline fica gravada na imagem (exposta em /health).
ARG VERSAO=dev
ENV APP_VERSION=${VERSAO}

EXPOSE 8080

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]
