FROM alpine:3.22.1

ARG USER=ureeves
ARG GROUP=ureeves
ARG UID=1000
ARG GID=1000
ARG LLVM_VERSION="20.1.8"

ENV USER_HOME=/home/${USER}
ENV LLVMBOX_REPO=${USER_HOME}/llvmbox
ENV LLVMBOX_BUILD_DIR=${LLVMBOX_REPO}/build

RUN apk add --no-cache                                  \
              build-base musl-dev bash cmake make ninja \
              patch python3 rsync wget xz linux-headers \
              git

RUN addgroup -g ${GID} ${GROUP} && \
    adduser  -s /bin/ash           \
             -h ${USER_HOME}       \
             -S -D                 \
             -G ${GROUP}           \
             -u ${UID}  ${USER}

USER    ${USER}
WORKDIR ${USER_HOME}

VOLUME     ${LLVMBOX_REPO}
ENTRYPOINT ["/bin/ash", "-c", "$LLVMBOX_REPO/build.sh"]
