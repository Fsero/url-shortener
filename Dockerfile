ARG BINARY
ARG CONT_IMG_VER
FROM alpine:3.5
# Stress Version can be found on offcial website of stress
# https://people.seas.harvard.edu/~apw/stress/
ENV STRESS_VERSION=1.0.4 \
    SHELL=/bin/bash

RUN \
  apk add --update bash g++ make curl && \
  curl -o /tmp/stress-${STRESS_VERSION}.tgz https://people.seas.harvard.edu/~apw/stress/stress-${STRESS_VERSION}.tar.gz && \
  cd /tmp && tar xvf stress-${STRESS_VERSION}.tgz && rm /tmp/stress-${STRESS_VERSION}.tgz && \
  cd /tmp/stress-${STRESS_VERSION} && \
  ./configure && make && make install && \
  apk del g++ make curl && \
  rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*
RUN apk add --update --no-cache ca-certificates
EXPOSE 8080
ADD $BINARY /
ENTRYPOINT [ "/bin/urlshortener" ]
CMD [""]