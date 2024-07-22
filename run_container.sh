#!/bin/bash

# Docker 이미지 이름과 태그 설정
IMAGE_NAME="my_pytorch_image"
IMAGE_TAG="latest"
CONTAINER_NAME="my_pytorch_container"

# X11 디스플레이 설정
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth_list=$(xauth nlist $DISPLAY)
if [ -n "$xauth_list" ]; then
  echo $xauth_list | xauth -f $XAUTH nmerge -
else
  touch $XAUTH
fi
chmod 777 $XAUTH

# Docker 컨테이너 실행
docker run -it \
  --name ${CONTAINER_NAME} \
  --gpus all \
  --shm-size=16g \
  -e "DISPLAY=$DISPLAY" \
  -e "QT_X11_NO_MITSHM=1" \
  -e "XAUTHORITY=$XAUTH" \
  -e NVIDIA_DRIVER_CAPABILITIES=all \
  -e NVIDIA_VISIBLE_DEVICES=all \
  -v /dev/:/dev/ \
  -v /etc/localtime:/etc/localtime:ro \
  -v /etc/timezone:/etc/timezone:ro \
  -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  -v "$(pwd)/workspace:/workspace" \
  --net=host \
  --privileged \
  --ipc=host \
  ${IMAGE_NAME}:${IMAGE_TAG} \
  bash

