DOWNLOAD E INSTALAÇÃO:

Ao executar o comando abaixo, vai aparecer um menu para fazer a instalaçao automática.
Para instalar digite 1 e enter
Vai solicitar que seja definido uma senha padrão, que será utilizada nas próximas instalações.

```bash
sudo apt install -y git && git clone https://github.com/leandrosroc/manager.git instalador && sudo chmod -R 777 ./instalador && cd ./instalador && sudo ./install
```

FAZENDO DEPLOY DO LNETPLUS CHAT:

Inicie o gerenciador pela primeira vez utilizando:
```bash
source /root/.bashrc && cd && cd ./instalador && sudo ./menu
```

Para as próximas vezes:

```
menu
```

Insira os dados conforme solicitado:

1. Usuário MySQL

2. Senha mysql

3. Nome da empresa (em minúsculo), esse nome é para diferenciar as instalações e os recursos isolados via Docker.

4. Número máximo de conexões WhatsApp que essa instalação poderá usar

5. Número máximo de atendentes para essa instalação

6. Domínio do frontend, geralmente app.seusite.com.br

7. Domínio do backend, geralmente api.seusite.com.br

8. Porta do frontend, geralmente para a primeira instalação 3000, e a seguintes instalações que tiverem, 3001, 3002...

9. Porta do backend, geralmente para a primeira instalação 4000, e a seguintes instalações que tiverem, 4001, 4002...

10. Porta do phpmyadmin, geralmente para a primeira instalação 8000, e a seguintes instalações que tiverem, 8001, 8002...
    O acesso ao phpmyadmin é feito por IP do servidor, exemplo: http://0.0.0.0:8000

11. Porta do MYSQL, geralmente para a primeira instalação 3306, e a seguintes instalações que tiverem, 3307, 3308...

Seguindo todos os passos acima é só aguardar o gerenciador concluir a instalação.
