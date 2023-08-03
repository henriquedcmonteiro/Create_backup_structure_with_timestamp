#!/bin/bash

#Evitando que o script continue caso alguma variavel esteja vazia ou algum erro na pipeline (caso tenha).
set -u -e 

#Constante com valor de 150 que usaremos como stderr padrão para a saída da nossa função encerrar.
readonly NAO_PASSAR_ARGUMENTOS=150 

#Função encerrar onde caso passe-se qualquer quantidade de argumentos o script para e aponta para o erro da constante acima.
encerrar() {
	msg=${1}
	echo "ERRO: ${msg}" >&2
	exit ${NAO_PASSAR_ARGUMENTOS}
}

#Nosso encapsulamento de segurança, onde caso passe-se algum argumento, o script evoca a função encerrar e encerrar mostrando o erro.
if [[ $# -gt 0 ]]; then
	encerrar "Não passe argumentos neste script." 
else

#Variaveis que vão pega o ano, mês e dia, nota-se que o mês estamos pegando a sigla com o comando cut.
ano=$(date +"%Y")
mes=$(date | cut -d " " -f 2)
dia=$(date +"%d")

#Condicionais onde vão criar a nossa estrtura de pasta, começando pelo ano, mês e dia.
if [[ ! -d ${ano} ]]; then
	mkdir ${ano}
	cd ${ano}
else
	cd ${ano}
fi

if [[ ! -d ${mes} ]]; then
	mkdir ${mes}
	cd ${mes}
else
	cd ${mes}
fi

if [[ ! -d ${dia} ]]; then
	mkdir ${dia}
	cd ${dia}
else
	cd ${dia}
fi

#Aqui criamos uma outra função onde criaremos um diretório dentro da arvore de pastas que estamos descrito acima.
#Em primeiro passo criamos com o mkdir a pasta com o nome de timestamp seguido de um _backup.
#Após a criação com a variável especial nos armazenamos o ultimo comando que seria o comando descrito acima na variavel path.
#Clonamos um repositório meu como exemplo dentro dessa estrutura de arvore de pastas entretanto ainda fora da pasta _backup.
#Com o comando mv utilizando o command substitution, usamos basename para pegar o nome da pasta do repositório e movemos
#para a pasta criada anteriormente direcionada pela variável $path que salvou o valor anteriormente do mkdir. 
criar_backup() {
	mkdir $(date +"%Y-%m-%dT%H:%M:%S_backup")
	path=$_
	git clone "https://github.com/henriquedcmonteiro/special_shell_variables" 
	mv $(basename "https://github.com/henriquedcmonteiro/special_shell_variables") ${path}
}

#Por ultimo executamos a função e saimos do script
criar_backup

fi

exit 0


