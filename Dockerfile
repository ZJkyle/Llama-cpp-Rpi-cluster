FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

# 更新並安裝必要工具
RUN apt update && apt upgrade -y && \
    apt-get install -y --no-install-recommends \
    build-essential gfortran make cmake wget zip unzip \
    python3-pip python3-dev gfortran liblapack-dev pkg-config \
    libopenblas-dev autoconf python-is-python3 vim git openssh-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 編譯 MPICH
WORKDIR /tmp
RUN wget https://www.mpich.org/static/downloads/4.1.2/mpich-4.1.2.tar.gz && \
    tar xf mpich-4.1.2.tar.gz && \
    cd mpich-4.1.2 && ./configure --prefix=/usr && make -j $(nproc) && make install && \
    cd / && rm -rf /tmp/mpich-4.1.2* 

# 編譯 llama.cpp
WORKDIR /
RUN git clone https://github.com/ggerganov/llama.cpp.git && \
    cd llama.cpp && make CC=mpicc CXX=mpicxx LLAMA_MPI=1 LLAMA_OPENBLAS=1 && \
    python3 -m pip install -r requirements.txt

# 安裝並配置 SSH
RUN mkdir -p /var/run/sshd

# 添加 llama.cpp 到 PATH
ENV PATH=/llama.cpp:$PATH
