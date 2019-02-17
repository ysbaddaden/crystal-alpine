FROM alpine:3.9

# build dependencies (will eventually be removed):
RUN apk add --no-cache --virtual .build-deps \
        build-base curl crystal \
        gc-dev libevent-dev libunwind-dev llvm5-dev pcre-dev yaml-dev

# crystal runtime required dependencies + make (usually useful):
RUN apk add --no-cache --virtual .crystal-deps \
        gcc gc libc-dev libevent libunwind llvm5-libs make pcre

# shards runtime required dependencies
RUN apk add --no-cache --virtual .shards-deps \
        gc libevent libunwind pcre yaml

# build crystal:
ARG CRYSTAL_VERSION=0.27.2
ARG CRYSTAL_SOURCE=https://github.com/crystal-lang/crystal/archive/${CRYSTAL_VERSION}.tar.gz
RUN curl -sL ${CRYSTAL_SOURCE} | tar xz -C /tmp
RUN cd /tmp/crystal-${CRYSTAL_VERSION} && make release=1 stats=1

# build shards:
ARG SHARDS_VERSION=0.8.1
ARG SHARDS_SOURCE=https://github.com/crystal-lang/shards/archive/v${SHARDS_VERSION}.tar.gz
RUN curl -sL ${SHARDS_SOURCE} | tar xz -C /tmp
RUN cd /tmp/shards-${SHARDS_VERSION} && make CRFLAGS="--release --stats"

# install:
RUN set -eux; \
    mkdir -p /opt/crystal/bin; \
    mv /tmp/crystal-${CRYSTAL_VERSION}/src /opt/crystal/; \
    mv /tmp/crystal-${CRYSTAL_VERSION}/.build/crystal /opt/crystal/bin/; \
    mv /tmp/shards-${SHARDS_VERSION}/bin/shards /usr/local/bin/

# copy some static libraries to reduce the image size:
RUN set -eux; \
    mkdir -p /opt/crystal/embedded/lib; \
    cp /usr/lib/libgc.a /opt/crystal/embedded/lib/; \
    cp /usr/lib/libevent*.a /opt/crystal/embedded/lib/; \
    cp /usr/lib/libunwind*.a /opt/crystal/embedded/lib/; \
    cp /usr/lib/libpcre*.a /opt/crystal/embedded/lib/

# cleanup:
RUN rm -rf /tmp/crystal-${CRYSTAL_VERSION} /tmp/shards-${SHARDS_VERSION}
RUN rm -rf /root/.cache
RUN apk del .build-deps

# add wrapper script:
COPY crystal.sh /usr/local/bin/crystal
RUN chmod +x /usr/local/bin/crystal
