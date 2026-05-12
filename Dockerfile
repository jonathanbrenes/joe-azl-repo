FROM mcr.microsoft.com/azurelinux/base/core:4.0

RUN tdnf -y install \
        build-essential \
        ca-certificates \
        createrepo_c \
        git \
        golang \
        mock \
        mock-rpmautospec \
        openssl \
        python3 \
        shadow-utils \
        sudo \
    && tdnf clean all

RUN GOBIN=/usr/local/bin go install \
        github.com/microsoft/azure-linux-dev-tools/cmd/azldev@main \
    && rm -rf /root/go /root/.cache

ARG UID=1001
RUN useradd -u "${UID}" -G mock -m builduser

WORKDIR /workdir
USER builduser
