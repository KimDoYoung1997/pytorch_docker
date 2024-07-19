#!/bin/bash

# Docker 이미지 이름과 태그 설정
IMAGE_NAME="my_pytorch_image"
IMAGE_TAG="latest"
# CONTAINER_NAME="my_pytorch_container"

# 현재 경로에 workspace 폴더가 있는지 확인하고 없으면 생성
WORKSPACE_DIR=$(pwd)/workspace
if [ ! -d "$WORKSPACE_DIR" ]; then
  echo "Creating workspace directory..."
  mkdir -p $WORKSPACE_DIR
fi

# Docker 이미지 빌드
echo "Building Docker image..."
docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .

# Docker 컨테이너 실행
# echo "Running Docker container..."
# docker run -d --name ${CONTAINER_NAME} -p 8888:8888 -v $WORKSPACE_DIR:/workspace ${IMAGE_NAME}:${IMAGE_TAG}

# 실행 중인 컨테이너 확인
# echo "Docker container is running:"
# docker ps -a | grep ${CONTAINER_NAME}

