FROM ros:noetic
RUN apt-get update && apt-get install -y ros-noetic-desktop-full

RUN apt-get install -y \   
    python3-catkin-tools \
    ros-noetic-geographic-msgs \
    ros-noetic-foxglove-bridge \
    libarmadillo-dev \
    ros-noetic-nlopt \
    libelf-dev \
    libdw-dev 

wget http://akira.ruc.dk/~keld/research/LKH-3/LKH-3.0.6.tgz
tar xvfz LKH-3.0.6.tgz
cd LKH-3.0.6
make
sudo cp LKH /usr/local/bin

# Install NLopt for traj optimization in RACER !Exists in Noetic!
# RUN wget https://github.com/stevengj/nlopt/archive/v2.7.1.tar.gz
# RUN tar -xvf v2.7.1.tar.gz
# RUN cd nlopt-2.7.1 && mkdir build && cd build && cmake .. && sudo make install

# Generate the script that sources the ROS environment
RUN echo "source /opt/ros/\$ROS_DISTRO/setup.bash" > /source_ros.sh
COPY waitOn.sh /root/waitOn.sh
RUN chmod +x /root/waitOn.sh
