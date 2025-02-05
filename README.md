<br>
:bulb: <u>Digitar no terminal do host:</u>

```bash
1. echo "UID=$(id -u)" >> .env

2. echo "GID=$(id -g)" >> .env
````

>*Esses valores são usados para garantir que os arquivos criados dentro do contêiner tenham as mesmas permissões do usuário no host, evitando problemas de acesso.*

```bash
UID=1000
``` 
>*Define o User ID que o contêiner usará.*

```bash
GID=1000 
````

>*Define o Group ID que o contêiner usará.*

<br><hr><br>

:bulb: <u>Para rodar o container do NODE de forma correta:</u>

```bash
1. docker compose run --service-ports --rm node npm run dev
2. docker compose run --rm -p 5173:5173 node npm run dev
```

>*Com --service-ports, o Docker mantém as portas definidas no docker-compose.yml, garantindo que o Vite fique acessível.*

<br><hr><br>

:bulb: <u>Configurar no vite.config.js:</u>

```javascript
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
```

>*Permite acessos externos à aplicação e define a porta onde o Vite será executado*

<br><hr><br>

:bulb: <u>Criar um link simbólico apontando para o diretório public do projeto:</u>

```bash
ln -s src/public public
```

>*Cria um link simbólico chamado "public" que aponta para "src/public"*

