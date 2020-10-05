# ROS jaiio 2019 Dockerfile 

FROM ros:kinetic

ENV DISPLAY=unix$DISPLAY

RUN apt update && \
    apt install vim -y && \
    apt install git -y && \
    apt install wget -y && \
    apt install ros-kinetic-desktop-full -y && \
    apt install ros-kinetic-gazebo-ros-pkgs ros-kinetic-gazebo-ros-control -y && \
    sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list' && \
    wget http://packages.osrfoundation.org/gazebo.key -O - | apt-key add - && \
    apt update && \
    apt install gazebo7 -y && \
    apt install ros-kinetic-teleop-twist-keyboard -y && \
    apt install ros-kinetic-frontier-exploration ros-kinetic-navigation-stage -y && \
    apt install ros-kinetic-catkin python-catkin-tools -y

RUN git clone https://gitlab.com/martinnievas/ros-jaiio-2019.git /home/ROS-docker-jaiio2019/
RUN echo "source /opt/ros/kinetic/setup.bash" >> /.bashrc
RUN echo "source /home/ROS-docker-jaiio2019/simulation_ws/devel/setup.bash" >> /root/.bashrc
RUN echo "source /home/ROS-docker-jaiio2019/hector_slam_ws/devel/setup.bash" >> /root/.bashrc
