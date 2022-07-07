# Sensor Driver Download for Linux OS (Ubuntu 18.04)

<p align="center">
<img src="images/kia_niro.jpg">
</p>

This repository possesses a bash script that creates a ROS workspace with all the drivers for WMU's research vehicle. This bash script was tested in a Ubuntu 18.04 machine that has ROS melodic installed. This may workspace may not currently work with ROS noetic due to package incompabilities. Information on the sensors installed on the research vehicle and some configurations needed to make this workspace fully operational are described below. More information about the instrumentation of the Kia Niro at our Labs website under publications, wmich.edu/autonomous-vehicles.

## Installation requirements

* Ubuntu 18.04 
   * If installed on Ubuntu 20.04, Aptive ESR: radar_msgs depreciated; Moved to ros-perception as of ROS Noetic and ROS2.
* ROS melodic

## Hardware requirements

The Energy Efficient Autonomous Vehicle Lab (EEAV) at Western Michigan University possesses a hybrid 2018 Kia Niro with the following sensors:

* OS1 Ouster Lidar
  * This will work with models as well (OS0, OS1, and OS2)
* Aptive ESR
* Mobileye 660
* SwiftNav Multi Duro
  * This will work for the Piski Multi as a subsitute for the Duro 
* Polysync Drive-by-Wire

## Configurations

The drivers used to communicate with the Aptive ESR and the Mobileye are from AutonomouStuff. These drivers interface either with Linuxcan or Socketcan. Since the drive-by-wire already uses Socketcan, we decided to use Socketcan as a common framework. The AutonomouStuff drivers use a package called socketcan_bridge to interface with the sensors through socketcan. The drivers developed by AutonomouStuff subscribe and publish to the topics "can_tx" and "can_rx", but the socketcan_bridge package when cloned does not publish and subscribes can data to these topics. Therefore, the topics in the scripts "socketcan_to_topic.cpp" and "topic_to_socketcan.cpp" have to be changed and compile the workspace again.

The launch files of the GPS sensors have to be configured in order for them to use tcp and listen to 192.168.0.222 and 192.168.0.223. To obtain heading from the GPS sensors and perform the proper configurations, please follow the documentation from SwiftNav. SwiftNavs Skylark cloud subscription was used to get centimeter accuracy from Real-time kinematics (RTK). Make sure to configure the GNSS/IMU sensor to fuse the data together to increase the accuacy of its positioning. 

(https://support.swiftnav.com/support/solutions/articles/44001907898-rtk-heading-gnss-compass-configuration)

## Instructions

The bash script in this repository can be downloaded an run from the home directory of the user. 

Execute the bash file using, 

./av_drivers.bash

If you have executable permission and then do:

chmod +x ./av_drivers.bash

then, 

./av_drivers.bash

## Limitations

The drive-by-wire package was developed in ROS kinetic; therefore, when git cloned in a workspace with other packages, ROS doesn't find the executable.
