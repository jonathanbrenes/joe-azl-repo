FROM registry.fedoraproject.org/fedora:43

RUN dnf -y install \
        createrepo_c \
        gcc \
        git \
        golang \
        make \
        mock \
        rpm-build \
    && dnf clean all

RUN GOBIN=/usr/local/bin go install \
        github.com/microsoft/azure-linux-dev-tools/cmd/azldev@main \
    && rm -rf /root/go /root/.cache

ARG UID=1001
RUN useradd -u "${UID}" -G mock -m builduser

WORKDIR /workdir
USER builduser
