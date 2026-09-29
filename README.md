# minha-aplicacao

Aplicação FastAPI com um endpoint `GET /hello`, containerizada com Docker e publicada no Docker Hub via GitHub Actions.

## Executar localmente

```bash
docker build -t minha-aplicacao:1.0 .
docker run -p 8080:8080 minha-aplicacao:1.0
curl http://localhost:8080/hello
```

## Pipeline

A cada push na branch `main`, o workflow `.github/workflows/docker.yml`:

1. baixa o código;
2. lê a versão do arquivo `VERSION` e define a tag da imagem;
3. faz o build da imagem e testa o endpoint dentro do runner;
4. autentica no Docker Hub com os secrets `REGISTRY_USERNAME` e `REGISTRY_TOKEN`;
5. publica a imagem `usuario/minha-aplicacao:<versão>`.

## Usar a imagem publicada

```bash
docker pull usuario/minha-aplicacao:1.0
docker run -p 8080:8080 usuario/minha-aplicacao:1.0
curl http://localhost:8080/hello
```

## Versões

| Tag | Resposta de `/hello` |
|-----|----------------------|
| 1.0 | Hello World          |
| 2.0 | Hello World 2        |
