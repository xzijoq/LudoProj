#!/bin/bash

echo $1
#scan_build use to scan




cmake_b(){
    echo "cmake --build and copy lib"
    cmake --build build -j8 #-v 
    cp ./build/compile_commands.json ./compile_commands.json 
    cp ./build/libludo_engine.so ./ludo/bin/libludo_engine.so
    echo ""
}
cmake_bArm8(){
    echo "cmake --build and copy lib"
    cmake --build buildArm8 -j8 #-v 
    #cp ./buildArm8/compile_commands.json ./compile_commands.json 
    cp ./buildArm8/libludo_engine.so ./ludo/bin/libludo_engineArm8.so
    echo ""
}

Arm8Rebuild(){
    echo "Arm8 --ANDROID--- rebuilding"
    Arm8Clang='/home/babayaga/Android/Sdk/ndk/21.3.6528147/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android30-clang++'
    rm -r buildArm8
    cmake -S./ -B buildArm8 -DCMAKE_BUILD_TYPE=Debug -DIsAndroid=true -DCMAKE_CXX_COMPILER=${Arm8Clang} -G "Ninja"  
        
}

if [[ $1 = android ]]
then
    
    if [[ $2 = af ]]
    then
        Arm8Rebuild
        cmake_bArm8
    else
        echo "Arm8 --NOrebuild"
    fi
    cmake_bArm8
  
fi

if [[ $1 = gg ]]
then
    echo "not rebuilding"
    cmake_b
    #cp ./build/compile_commands.json ./compile_commands.json 
    #cmake --build build

fi

if [[ $1 = s ]]
then
    echo "running: camke --build build and runnning Scene: $2"
    cmake_b
    
    cd ludo

    if [[ $2 = "" ]]
    then
    	/home/babayaga/godot/godotb -d ./scenes/GameDisplay.tscn	
    else       
	    /home/babayaga/godot/godotb -d ./scenes/$2.tscn
    fi
    
fi
if [[ $1 = "" ]]
then
    echo "running: camke --build build and copy"
    cmake_b
    #cmake_bArm8


fi

if [[ $1  = f  || $2 = f ]]
then
    echo "LINUX64 rebuilding"
    rm -r build
    cmake -S./ -B build -DIsAndroid=false -DCMAKE_BUILD_TYPE=Debug -G "Ninja"  
    #Arm8Rebuild
   # cmake -E copy_directory src/engine/includes includes/Engine

    cmake_b
    #cmake_bArm8
fi

if [[ $1 = git ]]
then
    ./run.sh clean
    git add .
    if [[ $2 = "" ]]
    then
        git commit -m "test"
    else
        git commit -m "${2}"
    fi
    git push origin main
fi

if [[ $1 = copy ]]
then
    sudo ../copy.sh
fi


CleanEmacsTemp(){
    rm -r \#*
    rm -r *~
    rm -r .*~
}
if [[ $1 = clean ]]
then
    rm -r ./ludo/bin/libludo_engine.so
    rm -r ./ludo/bin/libludo_engineArm8.so
    ./src/engine/run.sh clean
    rm -r build
    rm -r buildArm8
    CleanEmacsTemp
    cd src
    CleanEmacsTemp
    cd ..
    cd includes
    CleanEmacsTemp
    cd ..
    cd ludo
    cd bin
    rm -r libludo_engine.so
    rm -r .mono
    cd ..
    cd ..
fi



