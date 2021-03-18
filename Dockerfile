ARG VERSION

FROM ubuntu:${VERSION}

# Set Environment Variables
ARG DEBIAN_FRONTEND="noninteractive"
ENV HOME="/root" \
  LANGUAGE="en_GB.UTF-8" \
  LANG="en_GB.UTF-8" \
  TERM="xterm"

# hadolint ignore=DL3008
RUN \
  ## Operating System Tools
  apt-get update && \
  apt-get install --no-install-recommends -y \
    apt-transport-https \
    apt-utils \
    bash \
    ca-certificates \
    curl \
    lsb-release \
    locales \
    tzdata \
    wget && \
  ## Generate Locales
  locale-gen en_GB.UTF-8 && \
  ## Application User & Default Directories
  useradd -u 911 -U -d /config -s /bin/false xyz && \
  usermod -G users xyz && \
  mkdir -p \
    /app \
    /config \
    /defaults && \
  ## Clean
  apt-get clean && \
  rm -rf \
    /var/lib/apt/lists/* && \
  ## Generate Version File
  echo "${VERSION}" > VERSION

# Add Local Files
COPY root/ /

ENTRYPOINT ["/init"]
