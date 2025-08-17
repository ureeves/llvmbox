FROM ubuntu:noble

ARG USER=ureeves
ARG GROUP=ureeves
ARG UID=1000
ARG GID=1000

ENV USER_HOME=/home/${USER}
ENV LLVMBOX_REPO=${USER_HOME}/llvmbox
ENV LLVMBOX_BUILD_DIR=${LLVMBOX_REPO}/build

RUN userdel ubuntu

RUN mkdir    -p ${USER_HOME}  && \
    groupadd -g ${GID}           \
                ${GROUP}      && \
    useradd  -g ${GID}           \
             -u ${UID}           \
             -d ${USER_HOME}     \
                ${USER}       && \
    chown       ${UID}:${GID}    \
                ${USER_HOME}

RUN apt update                               && \
    DEBIAN_FRONTEND=noninteractive              \
    apt install -y                              \
        build-essential                         \
        cmake make ninja-build patch python3    \
        rsync xz-utils linux-headers-generic    \
        libgcc-14-dev libstdc++-14-dev       && \
    apt clean

WORKDIR ${USER_HOME}
USER    ${USER}

VOLUME     ${LLVMBOX_REPO}
ENTRYPOINT ["/bin/sh", "-c", "$LLVMBOX_REPO/build.sh"]
