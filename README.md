<h2 p align="center" > Backup em estruturas. </h2></p>

## Passo 1 - Declarando shebang.

<p> - Declaramos o <b>shebang bash</b> como padrão para a execução do script.</p>

    - #!/bin/bash

## Passo 2 - Saindo do código após um erro.

<p> - Utilizamos o argumento <b>"set -u -e"</b>. Quando a execução do script encontrar um erro, tanto em uma pipeline ou de uma variavel unset o script para com o exit referente.</p>

    - set -u -e

## Passo 3 - Constante.

<p> - Criamos uma constante (apenas leitura), com um valor determinado para a saída da função encerrar que falaremos abaixo. </p>

    - readonly NAO_PASSAR_ARGUMENTOS=150

## Passo 4 - Função encerrar e encapsulamento.

<p> - Criaremos uma função que vai encerrar o script caso o gatilho da condição seja atendido. </p>

![Passo 1](imgs/Imagem_1.png)

<p> - A função é simples, ela vai encerrar o script caso a condicional abaixo seja atendida, nesse caso usaremos essa função caso se passe qualquer argumento após a execução do script. </p>

<p> - De forma um pouco mais detalhada, ela vai pegar o valor <i>inputado</i> e vai armazenar na variavel <b>msg</b> depois ela vai concatenar o echo "ERRO:" com a string que colocaremos após a evocação da função encerrar, jogando o valor <i>inputado</i> em uma stderr que podera ser consultado depois caso se direcione a saída do script com <b>"2>"</b>.  </p>

<p> - E por último ele encerra o script com o valor da nossa constante declarada acima. </p>

<p> - Depois apenas envolvemos a nossa estrutura em um <b>if-else</b>, onde caso se passe qualquer argumento após a execução do script no terminal evoca-se a função encerrar encerrando o script com a mensagem determinada e podemos puxar o valor de saída com o <b>$?</b> que vai levar o valor da constante determinada como stderr da função encerrar. </p>

![Passo 2](imgs/Imagem_2.png)

## Passo 5 - Estrutura de criação de diretórios.

![Passo 3](imgs/Imagem_3.png)

<p> - Primeiro declaramos a variavel neste exemplo $ano, que vai receber o valor do ano do formato date. </p>

<p> - A segunda variavel $mes vai armazenar o valor da segunda fileira do binario date, que estamos procurando a sigla de cada mês, como por exemplo jan, feb, mar e sucessivamente. </p>

<p> - A terceira variavel neste exemplo $dia, que vai receber o valor do dia do formato date. </p>

    ano=$(date +"%Y")
    mes=$(date | cut -d " " -f 2)
    dia=$(date +"%d")

![Passo 3](imgs/Imagem_3.png)

<p> A estrutura é bem simples e segue a mesma lógica em cascata. Ela vai pegar o valor das variaveis em questão e vai perguntar se o diretório não existe, caso não exista crie-se um diretório com o valor da variavel e depois entra neste mesmo diretório, caso o diretório já exista ele apenas entra no diretório. </p>

<p> A lógica segue-se na estrutura que queremos, de ano, mês e dia até chegarmos no destino final que é uma pasta com o valor do dia e entrando neste diretório. </p>

<p> Podemos pensar na estrtura de navegação da seguinte forma: ../"ano"/"mês"/"dia"/.. </p>

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

## Passo 6 - Função de backup.

<p> A função tem uma lógica interessante que falarei por partes. </p>

[Passo 4](imgs/Imagem_4.png)

<p> Em primeiro momento criaremos um novo diretório estando dentro de toda aquela estrutura citada acima. Este novo diretório sera criado com o nome partindo da evocação do binario date seguindo a formatação escolhida <b>%Y-%m-%dT%H:%M:%S</b> que respectitivamente é ANO-MÊS-DIA-(T é apenas um caracter que usei para dar mais visibilidade na separação de data para horário)HORA:MINUTOS:SEGUNDOS terminando com a string _backup. </p>

<p> Na segunda instrução nós vamos armazenar o valor do command substitution que vai ser nosso ultimo comando executado dentro da variavel que criamos com o nome de path utilizando a variavel especial "$_".</p>

<p> Então dentro dessa variavel vai estar o resultado de "$(date+"%Y-%m-%dT%H:%M:%S_backup")". </p>

<p> A terceira instrução apenas clonei outro repositório meu que farei de backup, ainda fora da pasta que acabamos de criar com o mkdir $(date +"%Y-%m-%dT%H:%M:%S_backup"). </p>

<p> Por último vamos pegar o basename do link que clonamos, jogando pro binario mv, movendo esta pasta que no caso seria "special_shell_variables" para dentro do diretório criado anteriormente que esta armazenado na variavel $path, passando a variavel no final da instrução. </p>

<p> ## Passo 7 - Evocar e final.

<p> Agora apenas evocamos a função e criamos o nosso arquivo de backup dentro da pasta referente ao ano, mês e dia, também marcando nessa pasta a hora, minuto e segundo de sua criação. </p>

