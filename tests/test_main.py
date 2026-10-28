from fastapi.testclient import TestClient

from app.main import app

client = TestClient(app)


def test_hello_responde_texto_esperado():
    resposta = client.get("/hello")
    assert resposta.status_code == 200
    assert resposta.text == "Hello World 2"


def test_health_indica_status_e_versao():
    resposta = client.get("/health")
    assert resposta.status_code == 200
    corpo = resposta.json()
    assert corpo["status"] == "ok"
    assert "versao" in corpo
