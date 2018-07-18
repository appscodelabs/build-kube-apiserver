#!/bin/bash
set -x

DOCKER_REGISTRY=${DOCKER_REGISTRY:-kubedbci}

dir=`pwd`
pushd ~/go/src/k8s.io/kubernetes
git_tag=$(git describe --exact-match --abbrev=0 2>/dev/null || echo '')
make kube-apiserver
cp _output/bin/kube-apiserver $dir/kube-apiserver
popd

chmod +x kube-apiserver
docker build -t $DOCKER_REGISTRY/kube-apiserver-amd64:$git_tag .
docker push $DOCKER_REGISTRY/kube-apiserver-amd64:$git_tag
# load image directly into minikube
docker save $DOCKER_REGISTRY/kube-apiserver-amd64:v1.11.0 | (eval "$(minikube docker-env)" && docker load)
rm -rf kube-apiserver
