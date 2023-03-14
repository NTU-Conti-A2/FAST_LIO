#!/bin/sh
docker run -it --rm \
    --name fast_lio \
    --network=host \
    -u $(id -u):$(id -g) \
    -v $HOME/repo/FAST_LIO:/home/user/catkin_ws/src/FAST_LIO \
    fast-lio:noetic /bin/zsh -c "roslaunch fast_lio mapping_corriere.launch"
