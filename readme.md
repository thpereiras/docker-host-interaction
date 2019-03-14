# Resumo
Consiste em uma receita de Dockerfile para criação de um container a partir de uma imagem `debian:satble-slim`. O repositório possui dois scripts que quando executados dentro do container docker mostram os containers da máquina host.

# Arquivos
| Arquivo | Descrição |
| ------ | ------ |
| Dockerfile | Receita para criação da imagem baseada no debian slim |
| containers_to_file.sh | Grava a lista de containers do host em um arquivo chamados results.txt |
| containers_to_shell.sh | Mostra no shell a lista de containers da máquina host |
| readme.md | Descrição do projeto |

# Instalação e configuração

Download do repositório:
```sh
git clone https://github.com/thpereiras/docker-host-interaction.git
```

Acesso ao diretório:
```sh
cd ./docker-host-interaction
```

Criação da imagem:
```sh
docker build -t debian-slim-img-dhi .
```

Criação e execução do container:
```sh
docker run -it -d -v /var/run/docker.sock:/var/run/docker.sock \
-v $(pwd):/tmp --name deb1 debian-slim-img-dhi
```

Permissão de execução nos scripts:
```sh
chmod a+x ./*.sh
```

# Execução

Os scripts podem ser executados no container via execução externa ou interna. Na execução interna é preciso acessar o container. Foram construídos dois scripts, um que irá mostrar no shell a lista de containers da máquina host e outro irá gerar um arquivo `results.txt` com a lista.

O script organiza os containers em grupos através dos seguintes estados: `running, exited, dead, paused`.

* ### Executar o script no *container* através do *shell* do *host*

Mostrar containers da máquina host no shell:
```sh
docker exec -it deb1 /tmp/containers_to_shell.sh
```

Mostrar containers da máquina host em arquivo (results.txt):
```sh
docker exec -it deb1 /tmp/containers_to_file.sh
```

* ### Entrar no *container* e executar o script

Entrar no container:
```sh
docker exec -it deb1 bash
```

Mostrar containers no shell:
```sh
/tmp/containers_to_shell.sh
```

Mostrar containers da máquina host em arquivo (results.txt):
```sh
/tmp/containers_to_file.sh
```

# Remover container e imagens utilizadas no projeto

```sh
docker stop deb1;
docker rm deb1;
docker rmi debian-slim-img-dhi;
docker rmi docker rmi debian:stable-slim;
```
