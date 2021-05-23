#!/bin/bash
IMAGE_NAME="drone-gazebo-docker:latest" # nombre y tag con el que se creara la imagen
CONTAINER_NAME="drone-test"             # nombre con el que se creara el contenedor
FIRMWARE_DIR_HOST="$(pwd)/Firmware"
FIRMWARE_DIR_CONTAINER="/home/Firmware"

list_containers="docker ps --format '{{.Names}}' -a"

# Corroborando que se haya pasado un argumento
if [[ "$#" -ne 1 ]]; then
    echo "Falta un argumento"
    echo "Utilizacion: bash start-container.sh <nombre_simulacion>"
    echo "Ejemplo: bash start-container.sh gazebo_plane"
    exit 1
fi

echo "Corroborando si existe un contenedor con el mismo nombre"
if ( echo "$list_containers" | fgrep -q $CONTAINER_NAME ); then
    echo " -> Existe un contenedor con el mismo nombre, se procede a eliminarlo"
    docker rm --force $CONTAINER_NAME
else
    echo " -> No existe un contenedor con el mismo nombre"
fi

echo "Corriendo xhost +local:docker"
xhost +local:docker #Permite GUIs en docker

echo "Procediendo a construir y ejecutar el contenedor"
docker  run -d -i \
        --env="DISPLAY=unix$DISPLAY" \
        --volume="/tmp/.X11-unix:/tmp/.X11-unix" \
        --volume="$FIRMWARE_DIR_HOST:$FIRMWARE_DIR_CONTAINER" \
        --name $CONTAINER_NAME \
        $IMAGE_NAME

echo "Ejecutando simulacion CTRL+C para finalizar"
docker exec -ti -w $FIRMWARE_DIR_CONTAINER $CONTAINER_NAME make px4_sitl_default $1
echo "Deteniendo y eliminando contenedor..."
docker rm --force $CONTAINER_NAME
