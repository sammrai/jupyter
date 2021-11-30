#!/bin/bash

if [ -z "$(git status --porcelain)" ]; then
  echo "ビルドを開始します。"
else
  git status
  echo "ビルドするためには変更点をコミットする必要があります。"
  exit 1
fi

function build_image(){
    imgname=$1
    docker build --tag=$imgname -f Docker/Dockerfile.latest Docker/
    docker push $imgname
}

tag=`git rev-parse --short HEAD`
build_image sammrai/jupyter:$tag
build_image sammrai/jupyter:latest