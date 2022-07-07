#!/bin/bash

BLUE='\033[1;34m'
NC='\033[0m'
GREEN='\033[1;32m'

echo -e "${BLUE}Installing Mobileye and Radar drivers${NC}"

sudo apt update && sudo apt install apt-transport-https
sudo sh -c 'echo "deb [trusted=yes] https://s3.amazonaws.com/autonomoustuff-repo/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/autonomoustuff-public.list'
sudo apt update
sudo apt install ros-$ROS_DISTRO-delphi-esr ros-$ROS_DISTRO-mobileye-560-660

echo -e "${BLUE}Installing Socketcan${NC}"

sudo apt-get install can-utils

echo -e "${BLUE}Installing Ouster Lidar dependencies${NC}"

sudo apt install build-essential cmake
sudo apt install build-essential cmake libglfw3-dev libglew-dev libeigen3-dev \
     libjsoncpp-dev libtclap-dev

echo -e "${BLUE}Creating workspace and cloning ros drivers${NC}"

mkdir -p ~/eeav_ws/src
cd ~/eeav_ws/src && \
   echo -e "${GREEN}Cloning Swiftnav drivers${NC}" &&
   git clone https://github.com/ethz-asl/ethz_piksi_ros && \
   echo -e "${GREEN}Cloning Ouster Lidar drivers${NC}" &&
   git clone https://github.com/ouster-lidar/ouster_example && \
   echo -e "${GREEN}Cloning roscco driver${NC}" &&
   git clone --recursive https://github.com/PolySync/roscco.git && \
   echo -e "${GREEN}Cloning Socketcan bridge driver${NC}" &&
   git clone https://github.com/ros-industrial/ros_canopen && \
   cd ros_canopen && \
   rm -rf canopen_motor_node && \
   cd ../ethz_piksi_ros && \
   rm -rf ethz_piksi_ros/ libsbp_ros_msgs/ piksi_multi_cpp/ piksi_multi_interface/ \
     piksi_pps_sync/ piksi_rtk_kml/ piksi_v2_rtk_ros/ rqt_gps_rtk_plugin/ \
     utils/ && \
   cd piksi_multi_rtk_ros/install/ && \
   ./install_piksi_multi.sh && \
   cd ../../../.. && \
   catkin_make -DKIA_NIRO=ON

echo -e "${BLUE}Done${NC}"
