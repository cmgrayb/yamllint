FROM alpine:3.21 AS builder

RUN set -eux \
	&& apk add --no-cache \
		bc \
		py3-pip \
		python3

ARG VERSION="latest"
RUN set -eux \
	&& if [ "${VERSION}" = "latest" ]; then \
		apk add yamllint; \
	else \
		NEXT="$( echo "${VERSION}+1" | bc )"; \
		apk add "yamllint>=${VERSION},<${NEXT}"; \
	fi \
	&& find /usr/lib/ -name '__pycache__' -print0 | xargs -0 -n1 rm -rf \
	&& find /usr/lib/ -name '*.pyc' -print0 | xargs -0 -n1 rm -rf


FROM alpine:3.21 AS production
ARG VERSION="latest"
LABEL "org.opencontainers.image.licenses"="MIT"
LABEL "org.opencontainers.image.ref.name"="Yamllint ${VERSION}"
LABEL "org.opencontainers.image.title"="Yamllint ${VERSION}"
LABEL "org.opencontainers.image.description"="Yamllint ${VERSION}"

RUN set -eux \
	&& apk add --no-cache python3 \
	&& ln -sf /usr/bin/python3 /usr/bin/python \
	&& find /usr/lib/ -name '__pycache__' -print0 | xargs -0 -n1 rm -rf \
	&& find /usr/lib/ -name '*.pyc' -print0 | xargs -0 -n1 rm -rf

COPY --from=builder /usr/lib/python3.12/site-packages/ /usr/lib/python3.12/site-packages/
COPY --from=builder /usr/bin/yamllint /usr/bin/yamllint

WORKDIR /data
ENTRYPOINT ["yamllint"]
CMD ["--help"]
