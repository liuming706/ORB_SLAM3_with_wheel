echo "Configuring and building Thirdparty/DBoW2 ..."

cd Thirdparty/DBoW2
mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j

cd ../../g2o

echo "Configuring and building Thirdparty/g2o ..."

mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j

# cd ../../Pangolin

# echo "Configuring and building Thirdparty/Pangolin ..."

# mkdir -p build
# cd build
# cmake .. -DCMAKE_BUILD_TYPE=Release
# make -j
# sudo make install

cd ../../Sophus

echo "Configuring and building Thirdparty/Sophus ..."

mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j

cd ../../../

echo "Uncompress vocabulary ..." 

cd Vocabulary
tar -xf ORBvoc.txt.tar.gz
cd ..

echo "Configuring and building ORB_SLAM3 ..."

mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=Yes
make -j

echo "Building ROS nodes"
cd ..
source /opt/ros/noetic/setup.bash
export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:`pwd`/Examples/ROS
cd Examples/ROS/ORB_SLAM3
mkdir -p build
cd build
cmake .. -DROS_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=Yes
make -j
cd ../../../

