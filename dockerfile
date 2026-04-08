# 使用官方的 Miniconda3 作为基础镜像
FROM continuumio/miniconda3:latest

# 维护者信息（可选）
LABEL maintainer="your_email@example.com"
LABEL description="Docker image for Macrel (Metagenomic AMPs Classification and RetrievaL)"

# 配置 Conda 镜像通道，严格按照 Bioconda 的官方推荐顺序
RUN conda config --add channels defaults && \
    conda config --add channels bioconda && \
    conda config --add channels conda-forge && \
    conda config --set channel_priority strict

# 通过 Bioconda 安装 macrel 及其所有底层依赖
# 清理缓存以减小镜像体积
RUN conda install -y macrel && \
    conda clean -a -y

# 创建一个工作目录
WORKDIR /data

# 设置容器启动时的默认执行命令为 macrel
ENTRYPOINT ["macrel"]

# 如果没有提供额外参数，默认输出帮助文档
CMD ["--help"]