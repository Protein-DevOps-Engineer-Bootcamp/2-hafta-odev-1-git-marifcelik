#!/bin/bash

ins="npm install"
cmd=npm

brnc=$(git branch | grep '*' | awk '{ print $2 }')
name==${PWD##*/}

build() {
    if [[ $1 == "main" || $1 == "master" ]]; then
        echo -n 'şu anda master ya da main branchindesiniz, build almak istiyor musunuz [y/n] : '
        read confirm
        if [[ $confirm == [nN] ]]; then
            exit 0;
        fi
    fi
    git checkout $1
    $ins
    $cmd script.js
    compress
}

usage() {
    echo 'Usage:'
    echo -e '\t-b  <branch name>\t Branch name'
    echo -e '\t-n  <new branch>\t Create new branch'
    echo -e '\t-f  <zip|tar>\t\t Compress format'
    echo -e '\t-p  <artifact path>\t Copy artifact to spesific path'
    echo -e '\t-d  <>\t\t\t Debug mode'
}

if [ "$1" == "--help" ]; then
  usage
  exit 0
fi

while getopts :b:nf:p:d arg
do
    case "$arg" in
        d)  cmd="${cmd} --inspect";;
        b)  branchname=${OPTARG}
            build $branchname     
            ;;
        n)  name=${OPTARG}
            git checkout -b $name
            
            ;;
        f)  typ=${OPTARG}
            if [[ $typ == "zip" ]]; then
                zip -q ${brnc}_${name} *
            elif [[ $typ == "tar" ]]; then
                tar -czf ./${brnc}_${name} * 2>/dev/null
            else
                exit 1;
            fi
            ;;
        p)  art_path=${OPTARG}
            mv ${brnc}_${name}* $art_path
            ;;
        ?)  echo 'hatalı argüman'
            usage
            ;;
    esac
done

