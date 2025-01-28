# Sistema e-SUS em Containers

Este projeto tem como objetivo explicar como subir o sistema do **e-SUS** utilizando containers Docker. Abaixo, você encontra um guia detalhado para realizar o processo de instalação e execução do sistema.

---

## Pré-requisitos

Antes de iniciar, certifique-se de que seu ambiente atende aos seguintes requisitos:

1. **Docker** instalado.
   - [Guia de Instalação](https://www.docker.com/get-started)

2. **Docker Compose** instalado.
   - [Guia de Instalação](https://docs.docker.com/compose/install/)

Para verificar as versões instaladas, execute:

```bash
docker --version
docker-compose --version
```

3. **Arquivo `docker-compose.yml`**
   - Certifique-se de que você possui o arquivo de configuração `docker-compose.yml` correto para o sistema e-SUS.

---

## Como Usar

Siga os passos abaixo para subir o sistema e-SUS em containers:

### 1. Parar e Remover Contêineres Existentes

Antes de iniciar ou reconstruir o sistema, certifique-se de parar qualquer contêiner em execução:

```bash
docker-compose down
```

Este comando:
- Para todos os contêineres definidos no arquivo `docker-compose.yml`.
- Remove redes e volumes associados, se configurado.

---

### 2. Construir as Imagens Docker

Para garantir que o sistema esteja atualizado, reconstrua as imagens do Docker:

```bash
docker-compose build
```

Este comando:
- Recria as imagens do Docker definidas no arquivo `docker-compose.yml`.
- Deve ser executado após alterações no código ou no Dockerfile.

**Observação:** Antes de construir as imagens, revise o arquivo `Dockerfile` e altere senhas e portas padrão para valores personalizados. Isso melhora a segurança e evita conflitos de porta.

---

### 3. Iniciar os Contêineres em Segundo Plano

Para iniciar o sistema e-SUS, execute o comando abaixo:

```bash
docker-compose up -d
```

Este comando:
- Inicia os contêineres em modo "detached" (segundo plano).
- Permite que o sistema funcione sem bloquear o terminal.

---

### 4. Executar o Script de Instalação

Após a criação dos contêineres, é necessário executar o script de instalação para configurar o sistema e-SUS corretamente:

```bash
./install_esus.sh
```

Este comando:
- Realiza a configuração inicial do sistema e-SUS.
- Deve ser executado apenas após a criação dos contêineres.

---

### 5. Verificar os Logs do Sistema

Caso encontre problemas, verifique os logs com o comando:

```bash
docker-compose logs
```

---

## Fluxo Completo

1. Parar os contêineres existentes:
   ```bash
   docker-compose down
   ```

2. Construir as imagens:
   ```bash
   docker-compose build
   ```

3. Iniciar os contêineres:
   ```bash
   docker-compose up -d
   ```

4. Executar o script de instalação:
   ```bash
   ./install_esus.sh
   ```

5. Verificar os logs (se necessário):
   ```bash
   docker-compose logs
   ```

---

## Estrutura do Projeto

A estrutura do projeto é a seguinte:

```
/
├── docker-compose.yml   # Arquivo de configuração do Docker Compose
├── .env                 # Variáveis de ambiente (opcional)
├── Dockerfile           # Configurações de build das imagens Docker
├── eSUS-AB-PEC-Linux64.jar # Arquivo executável principal do sistema e-SUS
├── install_esus.sh      # Script de instalação adicional
└── README.md            # Documentação do projeto
```

---

## Solução de Problemas

### Erros de Conexão
Certifique-se de que as portas necessárias estão liberadas no seu firewall e que não há conflitos de porta.

### Forçar Reconstrução
Se alterações não forem refletidas, force a reconstrução utilizando:

```bash
docker-compose build --no-cache
```

---

## Licença

Este projeto é distribuído sob a licença MIT. Consulte o arquivo `LICENSE` para mais informações.

---

## Contribuições

Contribuições são bem-vindas! Caso encontre algum problema ou tenha sugestões, abra uma *issue* ou envie um *pull request*.

---

## Referências

- [Documentação Oficial do Docker](https://docs.docker.com/)
- [Documentação Oficial do Docker Compose](https://docs.docker.com/compose/)

