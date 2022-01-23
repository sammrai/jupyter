#!/bin/bash

dockerbuildcmd="ionice -c 3 docker build"
function build_image(){
    imgname=$1
    $dockerbuildcmd --tag=$imgname -f Docker/Dockerfile.latest Docker/
    docker push $imgname
}

function err(){
  echo "#ERROR"
  exit
}

if [ "$1" = "test" ];then
  imgname=sammrai/jupyter:test
  $dockerbuildcmd --tag=$imgname -f Docker/Dockerfile.latest Docker/ && \
  docker run --rm --gpus all -v $(pwd):/work -w /work/Docker $imgname python test.py || err
  docker run --rm -e PYTHONPATH=$HOME/jupyter/data/mltlib -v $HOME:$HOME sammrai/jupyter:test python $HOME/jupyter/data/mltlib/agg/telegraf_fetch_ohlcv.py || err
  docker run --rm -e PYTHONPATH=$HOME/jupyter/data/mltlib -v $HOME:$HOME sammrai/jupyter:test python $HOME/jupyter/data/mltlib/agg/telegraf_make_dollbar.py || err
  docker run --rm -e PYTHONPATH=$HOME/jupyter/data/mltlib -v $HOME:$HOME sammrai/jupyter:test python $HOME/jupyter/data/mltlib/agg/telegraf_fetch_balance.py || err
  docker run --rm -e PYTHONPATH=$HOME/jupyter/data/mltlib -v $HOME:$HOME sammrai/jupyter:test python $HOME/jupyter/data/mltlib/agg/telegraf_fetch_trades.py || err
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