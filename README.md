# Drone simulation with Gazebo on Docker container

## Configuracion

### Buildear imagen
Primero ir al directorio de este repositorio
```bash
cd /path/to/this/repo
```
 y correr el script
```bash
bash build-enviroment.sh
```
Si es la primera vez se contruira la imagen lo que puede llevar bastante.

### Crear el contenedor y lanzar una simulacion
En el directorio de este repositorio
```bash
cd /path/to/this/repo
```
correr el script
```bash
bash start-container.sh <nombre-simulacion>
```
Por ejemplo
```bash
bash start-container.sh gazebo_plane
```
Esto hara que se cree el contenedor y dentro de el se ejecute la simulacion que se paso por parametro