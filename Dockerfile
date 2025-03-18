ARG FLUENTD_REPOSITORY=docker.io/bitnami/fluentd
ARG FLUENTD_TAG=1.18.0-debian-12-r11

FROM ${FLUENTD_REPOSITORY}:${FLUENTD_TAG} AS builder

USER root

RUN apt-get update && \
    apt-get install -y build-essential

RUN echo "gem: --no-document" > ~/.gemrc && \
    fluent-gem install \
    fluent-plugin-kinesis:3.5.0 \
    fluent-plugin-opensearch:1.1.5

FROM ${FLUENTD_REPOSITORY}:${FLUENTD_TAG}

COPY --chmod=775 --from=builder /opt/bitnami/fluentd/gems /opt/bitnami/fluentd/gems
COPY --chmod=775 --from=builder /opt/bitnami/fluentd/extensions /opt/bitnami/fluentd/extensions
COPY --chmod=775 --from=builder /opt/bitnami/fluentd/specifications /opt/bitnami/fluentd/specifications
