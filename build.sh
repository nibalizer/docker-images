#!/bin/bash

echo "Building images"

for dir in *;
do
    if [ ! -d ${dir} ];then
        continue
    fi
    pushd ${dir}
    docker build -t nibalizer/${dir} .
    popd
done

echo "Pushing images"

for dir in *;
do
    if [ ! -d ${dir} ];then
        continue
    fi
    docker push nibalizer/${dir}
done
