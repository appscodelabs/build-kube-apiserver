#!/bin/bash
set -x

dir=`pwd`

pushd ~/go/src/k8s.io/kuberbetes
git_tag=$(git describe --exact-match --abbrev=0 2>/dev/null || echo '')
make kube-apiserver
cp _output/bin/kube-apiserver $dir/kube-apiserver
popd

chmod +x kube-apiserver
docker build -t appscode/kube-apiserver-amd64:$git_tag .
docker push appscode/kube-apiserver-amd64:$git_tag
rm -rf kube-apiserver
