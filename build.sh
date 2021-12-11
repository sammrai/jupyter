#!/bin/bash


function build_image(){
    imgname=$1
    docker build --tag=$imgname -f Docker/Dockerfile.latest Docker/
    docker push $imgname
}

if [ "$1" = "test" ];then
  imgname=sammrai/jupyter:test
  docker build --tag=$imgname -f Docker/Dockerfile.latest Docker/ && \
  docker run --rm --gpus all -v $(pwd):/work -w /work/Docker $imgname python test.py
  exit
fi

if [ -z "$(git status --porcelain)" ]; then
  echo "ビルドを開始します。"
else
  git status
  echo "ビルドするためには変更点をコミットする必要があります。"
  exit 1
fi

tag=`git rev-parse --short HEAD`
build_image sammrai/jupyter:$tag
build_image sammrai/jupyter:latest