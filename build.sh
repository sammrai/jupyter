#!/bin/bash

function build_image(){
    imgname=$1
    docker build --tag=$imgname -f Docker/Dockerfile.latest Docker/
    docker push $imgname
}

tag=`git rev-parse --short HEAD`
build_image sammrai/jupyter:$tag
build_image sammrai/jupyter:latest