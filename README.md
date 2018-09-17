# Client do Endpoint Protector
## Procedimento de instalação:
Basta baixar esses arquivos do repositório usando o seguinte comando:

    git clone https://github.com/AnselmoDBA/ClientEPP.git

Editar o arquivo options.ini, com o endereço do servidor origem, o mesmo vai vir com as seguintes informações:

    ws_server=192.168.7.128
    ws_port=443
    DepartmentCode=defdep

Sendo:
* ws_server = Endereço do servidor
* ws_port = Porta do servidor (mantenha 443)
* DepartmentCode = Coloque o departamento em que o PC vai ser usado.

Após baixado no diretório raiz existe um arquivo chamado install.sh, precisamos alterar os privilegrios para 777 e depois basta executá-lo com o usuário root comando abaixo:
    
    chmod 777 install.sh
    sh install.sh

Feito isso o agent está instalado e todas as configurações de restrição são realizadas no servidor.
    


