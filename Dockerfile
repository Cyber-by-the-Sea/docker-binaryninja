ARG IMAGE_NAME=devtty1er/binaryninja
FROM $IMAGE_NAME:latest as binaryninja

ARG TRAVIS_BRANCH="not_specified"
ENV TRAVIS_BRANCH=$TRAVIS_BRANCH

RUN  python3 -c '\
import binaryninja; \
import os; \
version = binaryninja.UpdateChannel[os.environ["TRAVIS_BRANCH"]].versions[0]; \
print(f"Updating from {binaryninja.core_version()} to {version}..."); \
version.update(); \
binaryninja.update.install_pending_update()'; \
     python3 -c 'import binaryninja; print(f"Updated to {binaryninja.core_version()}")'

FROM ubuntu:latest

COPY --from=binaryninja /opt/binaryninja/ /opt/binaryninja/
COPY --from=binaryninja /root/.binaryninja/license.dat /root/.binaryninja/license.dat

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
      ca-certificates \
      python3 \
    && echo "/opt/binaryninja/python" > $(python3 -c 'import site; print(site.getsitepackages()[0] + "/binaryninja.pth")') \
    && ln -s /opt/binaryninja/binaryninja /usr/local/bin/binaryninja \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives /tmp/* /var/tmp/*
