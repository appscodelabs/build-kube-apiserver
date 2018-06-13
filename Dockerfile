FROM alpine
RUN set -x \
  && apk add --update --no-cache ca-certificates curl
COPY guard /usr/bin/guard
ENTRYPOINT ["kube-apiserver"]


