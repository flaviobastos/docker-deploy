# 1. O comando deve ser rodado no terminal do host.

echo "UID=$(id -u)" >> .env
echo "GID=$(id -g)" >> .env

# Esses valores são usados para garantir que os arquivos criados dentro do contêiner 
# tenham as mesmas permissões do usuário no host, evitando problemas de acesso.

# Define o User ID que o contêiner usará.
UID=1000 
# Define o Group ID que o contêiner usará.
GID=1000 

# 2. Com --service-ports, o Docker mantém as portas definidas no docker-compose.yml, garantindo que o Vite fique acessível.

docker compose run --service-ports --rm node npm run dev
docker compose run --rm -p 5173:5173 node npm run dev

# 3. Configurar no vite.config.js

import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';

export default defineConfig({
    plugins: [
        laravel({
            input: ['resources/css/app.css', 'resources/js/app.js'],
            refresh: true,
        }),
    ],
    server: {
        host: true,  // Permite conexões externas
        port: 5173,  // Garante que Vite rode na porta correta
    },
});

# 4. Criar um link simbólico dentro da pasta raiz apontando para src/public/

ln -s src/public public

