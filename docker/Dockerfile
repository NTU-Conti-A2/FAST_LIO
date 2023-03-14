FROM ros:noetic-perception
ARG DEBIAN_FRONTEND=noninteractive

# Install basic apt packages
RUN apt update && apt upgrade -y && \
    apt install -y sudo vim wget curl zsh git python3-pip python3-rosdep python3-catkin-tools && \
    apt autoremove && apt clean

# Create user account
RUN adduser --disabled-password --gecos '' --shell /bin/zsh user && \
    echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-user

# Switch to user
USER user

# Install oh-my-zsh
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.2/zsh-in-docker.sh)" -- \
    -t ys \
    -p git \
	-p z \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-syntax-highlighting

SHELL ["/bin/zsh", "-c"]

RUN . /opt/ros/$ROS_DISTRO/setup.zsh && \
    mkdir -p /home/user/catkin_ws/src && \
    cd /home/user/catkin_ws/src && git clone https://github.com/hku-mars/FAST_LIO.git && \
    git clone https://github.com/Livox-SDK/livox_ros_driver.git && \
    cd FAST_LIO && git submodule init && git submodule update && \
    cd /home/user/catkin_ws && catkin init && rosdep update && rosdep install --from-paths src --ignore-src -y -r && \
    catkin build --start-with livox_ros_driver

COPY docker/ros_entrypoint.sh /

RUN rm -rf /home/user/catkin_ws/src/FAST_LIO && \
    sudo echo "source /opt/ros/$ROS_DISTRO/setup.zsh" >> ~/.zshrc && sudo echo "source /home/user/catkin_ws/devel/setup.zsh" >> ~/.zshrc && \
    sudo echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc && sudo echo "source /home/user/catkin_ws/devel/setup.bash" >> ~/.bashrc && \
    sudo apt clean -y && \
    sudo chmod +x /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["/bin/zsh"]