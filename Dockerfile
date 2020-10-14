# Dockerfile
## Creo la imagen a partir de la de ROS melodic
FROM ros:melodic

ENV DISPLAY=unix$DISPLAY

## Instalar ROS/Gazebo
RUN apt-get update && \
    apt-get install ros-melodic-desktop-full -y

## Install rosinstall and other dependencies
RUN apt-get install python-rosinstall python-rosinstall-generator python-wstool build-essential -y

# Instalacion MAVROS https://dev.px4.io/en/ros/mavros_installation.html
    ## Instalar dependencias
RUN apt-get install python-catkin-tools python-rosinstall-generator -y && \
    ## Crear catkin workspace
    mkdir -p /home/catkin_ws/src && cd /home/catkin_ws && catkin init && wstool init src && \ 
    ## Install MAVLink
    rosinstall_generator --rosdistro kinetic mavlink | tee /tmp/mavros.rosinstall && \
    ## Build MAVROS - Get source (upstream - released)
    rosinstall_generator --upstream mavros | tee -a /tmp/mavros.rosinstall && \
    ## Build MAVROS - Setup workspace 
    wstool merge -t src /tmp/mavros.rosinstall && wstool update -t src && \
    ## Build MAVROS - Install deps
    rosdep install --from-paths src --ignore-src -y && \
    ## Install geographiclib
    /home/catkin_ws/src/mavros/mavros/scripts/install_geographiclib_datasets.sh 
    ## Build!
    #catkin build
# Fin MAVROS

## Setup environment variables
RUN echo "source /opt/ros/melodic/setup.bash" >> /.bashrc  && \
    echo "source /home/catkin_ws/devel/setup.bash" >> /.bashrc