FROM php:8.3.9-fpm-alpine3.20

# Definir o diretório de trabalho
WORKDIR /var/www/html

# Instalar extensões necessárias
RUN docker-php-ext-install pdo pdo_mysql mysqli

# Copiar os arquivos do projeto
COPY . /var/www/html

# Expor a porta para PHP-FPM
EXPOSE 9000

# Iniciar PHP-FPM
CMD ["php-fpm"]
