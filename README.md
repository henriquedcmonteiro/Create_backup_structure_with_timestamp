<h2 p align="center" > Backup em estruturas. </h2></p>

## Passo 1 - Declarando shebang.

<p> - Declaramos o <b>shebang bash</b> como padrão para a execução do script.</p>

    - #!/bin/bash

## Passo 2 - Saindo do código após um erro.

<p> - Utilizamos o argumento <b>"set -u -e"</b> Quando a execução do script encontrar um erro, tanto em uma pipeline ou de uma variavel unset o script para com o exit referente.</p>

    - set -u -e

## Passo 3 - Constante.

<p> - Criamos uma constante (apenas leitura), com um valor determinado para a saída da função encerrar que falaremos abaixo. </p>

    - readonly NAO_PASSAR_ARGUMENTOS=150

## Passo 4 - Função encerrar e encapsulamento.

<p> - Criaremos uma função que vai encerrar o script caso o gatilho da condição seja atendido. </p>

![Passo 1](imgs/Imagem_1.png)

<p> - A função é simples, ela vai encerrar o script caso a condicional abaixo seja atendida, nesse caso usaremos essa função caso passe-se qualquer argumento após a execução do script no terminal. </p>

<p> - De forma um pouco mais detalhada, ela vai pegar o valor inputado e vai armazenar na variavel <b>msg</b> depois ela vai concatenar o echo "ERRO:" com a string que colocaremos após a função e vai jogar o valor inputado em uma stderr que podera ser consultado depois caso se direcione a saída do script. E por último ele encerra o script com o valor da nossa constante declarada acima. </p>

    - encerrar() {
	- msg=${1}
	- echo "ERRO: ${msg}" >&2
	- exit ${NAO_PASSAR_ARGUMENTOS}
    }

<p> - Depois apenas envolvemos a nossa estrutura em um if-else, onde caso se passe qualquer argumento após a execução do script no terminal evoca-se a função encerrar encerrando o script com a mensagem determinada e podemos puxar o valor de saída com o $? que vai levar o valor da constante determinada como stderr da função encerrar. </p>
