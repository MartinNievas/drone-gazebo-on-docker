# Drone simulation with Gazebo on Docker container

## Configuracion

### Buildear imagen
Primero ir al directorio de este repositorio y correr el script
```bash
cd /path/to/this/repo
bash build-and-start-container.sh
```
Si es la primera vez se contruira la imagen y luego se correra el contenedor.
Una vez finalizado deberia mostrar lo siguiente
```bash
user@equipment: /path/to/this/repo$ bash build-and-start-container.sh 
Corroborando si existe la imagen
No existe la imagen drone-gazebo-docker:latest, se procede a buildear.
.
. (Buildeo)
.
Successfully built ac797ada5b04
Successfully tagged drone-gazebo-docker:latest
Corroborando si existe un contenedor con el mismo nombre
Procediendo a construir y ejecutar el contenedor
Para cerrar el contenedor y eliminarlo presionar CTRL+D
root@fff5f5ca6a68:/# 
```

### Compilar los archivos de PX4
Una vez dentro del contenedor vamos al directorio Firmware
```bash
cd /home/Firmware
no_sim=1 make px4_sitl_default gazebo
```
Si todo va bien deberia hacer
```bash
[100%] Built target sitl_gazebo
SITL ARGS
sitl_bin: /home/Firmware/build/px4_sitl_default/bin/px4
debugger: none
program: gazebo
model: none
world: none
src_path: /home/Firmware
build_path: /home/Firmware/build/px4_sitl_default
empty model, setting iris as default
SITL COMMAND: "/home/Firmware/build/px4_sitl_default/bin/px4" "/home/Firmware/build/px4_sitl_default"/etc -s etc/init.d-posix/rcS -t "/home/Firmware"/test_data
INFO  [px4] Creating symlink /home/Firmware/build/px4_sitl_default/etc -> /home/Firmware/build/px4_sitl_default/tmp/rootfs/etc

______  __   __    ___ 
| ___ \ \ \ / /   /   |
| |_/ /  \ V /   / /| |
|  __/   /   \  / /_| |
| |     / /^\ \ \___  |
\_|     \/   \/     |_/

px4 starting.

INFO  [px4] Calling startup script: /bin/sh etc/init.d-posix/rcS 0
Info: found model autostart file as SYS_AUTOSTART=10016
INFO  [param] selected parameter default file eeprom/parameters_10016
[param] Loaded: eeprom/parameters_10016
INFO  [dataman] Unknown restart, data manager file './dataman' size is 11798680 bytes
INFO  [simulator] Waiting for simulator to accept connection on TCP port 4560
```


