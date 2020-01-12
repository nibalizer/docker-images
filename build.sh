#!/bin/bash

echo "Building images"

for dir in *;
do
    if [ ! -d ${dir} ];then
        continue
    fi
    pushd ${dir}
    docker build --no-cache -t quay.io/nibalizer/${dir} .
    popd
done

if [ -z $1 ]; then
    echo "Cowardly refusing to push images"
else
    echo "Pushing images"

    for dir in *;
    do
        if [ ! -d ${dir} ];then
            continue
        fi
        docker push quay.io/nibalizer/${dir}
    done
fi
