FROM php:8.3.9-fpm-alpine3.20

# Definir o diretório de trabalho
WORKDIR /var/www/html

# Definir argumentos para UID e GID (vindos do docker-compose.yml)
ARG USER_ID
ARG GROUP_ID

# Instalar pacotes necessários para manipulação de usuários
RUN apk add --no-cache shadow

# Criar grupo e usuário dentro do contêiner com os mesmos IDs do host
RUN groupadd -g $GROUP_ID appgroup && \
    useradd -m -u $USER_ID -g appgroup -s /bin/bash appuser

# Instalar extensões necessárias
RUN docker-php-ext-install pdo pdo_mysql mysqli

# Copiar o Composer da imagem oficial
COPY --from=composer:2.8.5 /usr/bin/composer /usr/local/bin/composer

# Copiar os arquivos do projeto
COPY . /var/www/html

# Ajustar permissões para garantir que o usuário possa acessar os arquivos
RUN chown -R appuser:appgroup /var/www/html

# Expor a porta para PHP-FPM
EXPOSE 9000

# Iniciar PHP-FPM
CMD ["php-fpm"]