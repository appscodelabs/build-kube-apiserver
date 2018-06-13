FROM alpine

RUN set -x \
  && apk add --update --no-cache ca-certificates curl

COPY kube-apiserver /usr/local/bin/kube-apiserver

ENTRYPOINT ["kube-apiserver"]
