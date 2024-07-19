# 베이스 이미지 선택
FROM pytorch/pytorch:2.3.1-cuda12.1-cudnn8-devel

# 환경 변수 설정
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV CONDA_ENV_NAME=myenv
ENV PYTHON_VERSION=3.8

# 우분투 패키지 설치
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    ccache \
    cmake \
    curl \
    git \
    libfreetype6-dev \
    libhdf5-serial-dev \
    libzmq3-dev \
    libjpeg-dev \
    libpng-dev \
    libsm6 \
    libxext6 \
    libxrender-dev \
    pkg-config \
    software-properties-common \
    ssh \
    sudo \
    unzip \
    wget && \
    rm -rf /var/lib/apt/lists/*

# Miniconda 설치
RUN curl -o /tmp/miniconda.sh -sSL http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -bfp /usr/local && \
    rm /tmp/miniconda.sh

# Conda 경로 설정 및 업데이트
ENV PATH=/usr/local/conda/bin:$PATH
RUN conda update -y conda

# Conda 초기화 및 가상환경 생성
# RUN /bin/bash -c "source /usr/local/conda/etc/profile.d/conda.sh && conda init bash && conda create -n ${CONDA_ENV_NAME} python=${PYTHON_VERSION} && echo 'conda activate ${CONDA_ENV_NAME}' >> ~/.bashrc"

# Jupyter Lab 설치
# RUN /bin/bash -c "source /usr/local/conda/etc/profile.d/conda.sh && conda activate ${CONDA_ENV_NAME} && conda install -c conda-forge jupyterlab && jupyter serverextension enable --py jupyterlab --sys-prefix"

# 일반 유저 생성 및 권한 설정
ARG UID=1000
ARG USER_NAME=myuser
RUN adduser $USER_NAME -u $UID --quiet --gecos "" --disabled-password && \
    echo "$USER_NAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USER_NAME && \
    chmod 0440 /etc/sudoers.d/$USER_NAME
USER $USER_NAME
SHELL ["/bin/bash", "-c"]

# 작업 디렉토리 설정
WORKDIR /workspace
COPY . /workspace

# Jupyter Notebook 실행
CMD ["bash", "-c", "source /usr/local/conda/etc/profile.d/conda.sh && conda activate ${CONDA_ENV_NAME} && jupyter notebook --allow-root --ip=0.0.0.0 --no-browser --port=8888"]

