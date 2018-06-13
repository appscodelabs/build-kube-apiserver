#!/bin/bash
set -x

dir=`pwd`

pushd ~/go/src/k8s.io/kuberbetes
make kube-apiserver
cp _output/bin/kube-apiserver $dir/kube-apiserver
popd

chmod +x kube-apiserver
docker build -t appscode/kube-apiserver-amd64:v1.10.3 .
docker push appscode/kube-apiserver-amd64:v1.10.3
rm -rf kube-apiserver
