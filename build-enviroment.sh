#!/bin/bash
IMAGE_NAME="drone-gazebo-docker:latest" # nombre y tag con el que se creara la imagen
CONTAINER_NAME="drone-test"             # nombre con el que se creara el contenedor
FIRMWARE_DIRECTORY="$(pwd)/Firmware"
PX4_FIRMWARE_REPO="https://github.com/PX4/Firmware.git"

list_images="docker images --format={{.Repository}}:{{.Tag}}"

echo "Corroborando si existe la imagen"
if [[ $( $list_images | grep -w $IMAGE_NAME ) ]]; then
    echo " -> La imagen $IMAGE_NAME ya existe."
else
    echo " -> No existe la imagen $IMAGE_NAME, se procede a buildear."
    echo " -> docker build -t $IMAGE_NAME -f Dockerfile ."
    docker build -t $IMAGE_NAME -f Dockerfile .
fi

echo "Corroborando si existe el directorio de firmware de PX4"
if [ ! -d "$FIRMWARE_DIRECTORY" ]; then
  echo " -> Clonando repositorio.."
  git clone $PX4_FIRMWARE_REPO 
else
  echo " -> El directorio ya existe"
fi

