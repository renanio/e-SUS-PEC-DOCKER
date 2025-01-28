#!/bin/sh

# Verifica se o arquivo .env existe
if [ ! -f .env ]; then
    echo "Erro: Arquivo .env não encontrado. Certifique-se de que o .env está no mesmo diretório que este script."
    exit 1
fi

# Carrega as variáveis do arquivo .env
export $(grep -v '^#' .env | xargs)

# Variáveis
CONTAINER_NAME="${CONTAINER_NAME}"
JAR_FILE="./eSUS-AB-PEC-Linux64.jar"
CONTAINER_DIR="/opt"
DB_HOST="${ESUS_DB_HOST}"
DB_NAME="${ESUS_DB_NAME}"
DB_USER="${ESUS_DB_USER}"
DB_PASS="${ESUS_DB_PASS}"

# Transfere o arquivo JAR para o container no diretório especificado
docker cp "$JAR_FILE" "$CONTAINER_NAME":"$CONTAINER_DIR/"

# Executa o comando de instalação dentro do container e, se bem-sucedido, remove o arquivo JAR
docker exec -it "$CONTAINER_NAME" sh -c "cd $CONTAINER_DIR && echo 'S' | java -jar ./eSUS-AB-PEC-Linux64.jar -console -url=\"jdbc:postgresql://$DB_HOST:5432/$DB_NAME\" -username=\"$DB_USER\" -password=\"$DB_PASS\"" && \
docker exec -it "$CONTAINER_NAME" rm "$CONTAINER_DIR/eSUS-AB-PEC-Linux64.jar"

echo "Instalação concluída."
