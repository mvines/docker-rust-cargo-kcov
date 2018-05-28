# Minimal rust image with cargo-kcov
FROM rust

RUN true \
  && echo === Install kcov dependencies === \
  && apt-get update -qq \
  && apt-get install -y --fix-missing pkg-config \
  && apt-get install -y \
    binutils-dev \
    cmake \
    cmake-data \
    g++ \
    git \
    libcurl4-openssl-dev \
    libdw-dev \
    libelf-dev \
    libiberty-dev \
    python-minimal \
    wget \
    zlib1g \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/* \
  && echo === Building kcov === \
  && git clone -b v35 https://github.com/SimonKagstrom/kcov.git /usr/src/kcov \
  && cd /usr/src/kcov \
  && mkdir build \
  && cd build \
  && cmake .. \
  && make -j $(nproc) \
  && make install \
  && cd / \
  && rm -rf /usr/src/kcov \
  && echo === Installing cargo-kcov === \
  && cargo install cargo-kcov

