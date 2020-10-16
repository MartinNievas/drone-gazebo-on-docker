#!/bin/bash
IMAGE_NAME="drone-gazebo-docker:latest" # nombre y tag con el que se creara la imagen
CONTAINER_NAME="drone-test"             # nombre con el que se creara el contenedor

list_images="docker images --format={{.Repository}}:{{.Tag}}"
list_containers="docker ps --format '{{.Names}}' -a"

echo "Corroborando si existe la imagen"
if [[ $( $list_images | grep -w $IMAGE_NAME ) ]]; then
    echo "La imagen $IMAGE_NAME existe."
else
    echo "No existe la imagen $IMAGE_NAME, se procede a buildear."
    echo "Running -> docker build -t $IMAGE_NAME -f Dockerfile ."
    docker build -t $IMAGE_NAME -f Dockerfile .
fi

echo "Corroborando si existe un contenedor con el mismo nombre"
if [[ $( $list_containers | grep -w $CONTAINER_NAME ) ]]; then
    echo "Existe un contenedor con el mismo nombre, se procede a eliminarlo.."
    docker rm --force $CONTAINER_NAME
fi

echo "Procediendo a construir y ejecutar el contenedor"
echo "Para cerrar el contenedor y eliminarlo presionar CTRL+D"
docker  run -it --rm \
        --env="DISPLAY=unix$DISPLAY" \
        --volume="/tmp/.X11-unix:/tmp/.X11-unix" \
        --volume="$(pwd)/Firmware:/home/Firmware" \
        --name $CONTAINER_NAME \
        $IMAGE_NAME