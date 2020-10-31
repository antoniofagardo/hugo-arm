# This Dockerfile adds a non-root user with sudo access
ARG ALPINE_VARIANT=3.12

FROM alpine:${ALPINE_VARIANT}
ARG HUGO_VERSION=0.77.0

RUN echo "$(uname -m)" \
    && if [[ "$(uname -m)" == "aarch64" ]]; then CONTAINER_ARCH="64"; else CONTAINER_ARCH=""; fi \
    && echo "CONTAINER_ARCH=ARM$CONTAINER_ARCH" \
    && wget -c https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-ARM${CONTAINER_ARCH}.tar.gz -O - | tar -xz -C /tmp \
    && mkdir -p /usr/local/bin \
    && mv /tmp/hugo /usr/local/bin/hugo \
    && echo "$PATH" \
    && hugo version

CMD ["hugo", "version"]