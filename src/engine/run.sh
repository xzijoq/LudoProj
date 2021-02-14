#!/bin/bash

echo $1
#scan_build use to scan
#clang-tidy on cpp file
#bear for other compile jason

cmake_b(){
    rm -r ./build/bin/EngineE
    cmake --build build -j8 #-v 
    cp ./build/compile_commands.json ./compile_commands.json 

    ./build/EngineE
    echo ""
}
if [[ $1 = scan ]]
then
    rm -r ./build/bin/EngineE
    echo ""
    echo "--------------building with scan-build-----------"
    scan-build cmake --build build -j8 #-v 
    cp ./build/compile_commands.json ./compile_commands.json 
    echo ""
    echo "--------------running clang-tidy----------------"
    clang-tidy src/*.cpp 
    clang-tidy includes/*.h
    echo ""
    echo "--------------ruuning executable----------------"
    ./build/bin/EngineE
    echo ""

fi

if [[ $1 = conan ]]
then
    cd conan
    
fi

if [[ $1 = gg ]]
then
    echo "not rebuilding"
    cmake_b
fi


if [[ $1 = "" ]]
then
    echo "running: camke --build build and copy"
    cmake_b

fi

if [[ $1  = f  || $2 = f ]]
then
    echo "rebuilding"
    rm -r build
    cmake -S./ -B build -DCMAKE_BUILD_TYPE=Debug -G "Ninja"
    #--trace-source="main" 
    cmake_b

fi

if [[ $1 = git ]]
then
    ./run.sh clean
    git add .
    git commit -m "test"
    git push origin master
fi




CleanEmacsTemp(){
    rm -r \#*
    rm -r *~
    rm -r .*~
}


if [[ $1 = clean ]]
then
    rm -r build
    CleanEmacsTemp
    cd src
    CleanEmacsTemp
    cd ..
    cd includes
    CleanEmacsTemp
    cd ..
    cd ludo_cpp
    cd bin
    rm -r libludo_engine.so
    rm -r .mono
    cd ..
    cd ..
fi



