# 使用官方 Ubuntu 为基础镜像
FROM ubuntu:22.04

# 设置非交互式安装，防止安装过程中出现交互式对话框阻塞
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的软件包
RUN apt-get update && apt-get install -y \
    git \
    make \
    wget \
    gcc \
    g++ \
    qemu-system-riscv64 \
    qemu-utils \
    && rm -rf /var/lib/apt/lists/*

# 安装 RISC-V GNU 工具链
# 注意：这里需要找到合适的 RISC-V GNU Toolchain 的下载链接
RUN wget https://example.com/path-to-riscv-gnu-toolchain.tar.gz \
    && tar -xzvf path-to-riscv-gnu-toolchain.tar.gz \
    && cd riscv-gnu-toolchain \
    && ./configure --prefix=/opt/riscv --with-arch=rv64gc --with-abi=lp64d \
    && make \
    && make install     

# 设置环境变量以使工具链可用
ENV PATH="/opt/riscv/bin:${PATH}"

# 设置工作目录
WORKDIR /workspace

# 默认命令
CMD ["/bin/bash"]
