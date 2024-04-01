#!/bin/sh
# docker run -it --rm \
docker run -itd \
    --name fast_lio \
    --network=host \
    -u $(id -u):$(id -g) \
    -e ROS_MASTER_URI=http://10.0.0.41:11311/\
    -e ROS_MASTER_PORT=11311\
    -e ROS_IP=10.0.0.41\
    -v $HOME/bumblebee_ZLN/FAST_LIO:/home/user/catkin_ws/src/FAST_LIO \
    fast-lio:noetic /bin/zsh
