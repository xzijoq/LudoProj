cmake_minimum_required(VERSION 3.16)

project(ludo)
cmake_policy(SET CMP0076 NEW)


set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

#set(CMAKE_SYSTEM_NAME  Android)
#
#set(CMAKE_SYSTEM_PROCESSOR arm)
#set(CMAKE_SYSTEM_VERSION 1)
#
#set(CMAKE_ANDROID_NDK /home/babayaga/Android/Sdk/ndk/21.3.6528147/)
#set(CMAKE_ANDROID_API 30)
#set(CMAKE_ANDROID_ARCH_AB armeabi-v7a)
#set(CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION clang)
# Compiler to build for the target
#set(CMAKE_C_COMPILER /home/babayaga/Android/Sdk/ndk/21.3.6528147/toolchains/llvm/prebuilt/linux-x86_64/bin/armv7a-linux-androideabi29-clang)
#set(CMAKE_CXX_COMPILER /home/babayaga/Android/Sdk/ndk/21.3.6528147/toolchains/llvm/prebuilt/linux-x86_64/bin/armv7a-linux-androideabi29-clang++)


set(GodotCpp ../godot-cpp)

add_library(ludo_engine SHARED)

target_compile_features(ludo_engine PRIVATE cxx_std_20 )
#target_compile_options(ludo_engine PRIVATE -Wall)  

add_subdirectory(src/engine)


set(SourcesI 
    src/GdRegClass.cpp
    src/GameEngine.cpp
    )
set(IncDirs 
    ${GodotCpp}/godot_headers 
    ${GodotCpp}/include 
    ${GodotCpp}/include/core 
    ${GodotCpp}/include/gen 
    ${GodotCpp}/bin 
    includes 
    )


target_include_directories(ludo_engine PUBLIC ${IncDirs} )
target_link_directories(ludo_engine PUBLIC ${GodotCpp}/bin)







target_sources(ludo_engine PUBLIC  ${SourcesI})
target_link_libraries(ludo_engine PUBLIC  libgodot-cpp.linux.debug.64.a EngineE)

#target_link_libraries(ludo_engine PUBLIC  /home/babayaga/1SyncImpLinux/OutOfSyncCloud/godotProjects/godot-cpp/bin/libgodot-cpp.android.debug.armv7.a EngineE)
