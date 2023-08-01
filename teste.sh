#!/bin/bash 

set -u

log() {
    mkdir $(date -u +"%Y-%M-%dT%H:%M:%SZ")
    path=$_
    cp texto.txt "./${path}"    
}

log 

teste=$( ls | sort ) 
teste2=$(date -u +"%M")

for i in ${teste}; do
    if [[ "${i}" > "${teste2}" ]]; then
        echo ${i}
        cd ../
        mkdir nova_pasta
        break
    fi
    
done




