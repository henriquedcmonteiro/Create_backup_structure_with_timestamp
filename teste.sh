#!/bin/bash

set -u

ano=$(date -u +"%Y")
mes=$(date | cut -d " " -f 2)
dia=$(date -u +"%d")

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

criar_arquivo() {
	mkdir $(date -u +"%Y-%m-%dT%H:%M:%SZ")
	path=$_
	git clone "https://github.com/henriquedcmonteiro/special_shell_variables" 
	mv $(basename "https://github.com/henriquedcmonteiro/special_shell_variables") ${path}
}

criar_arquivo




