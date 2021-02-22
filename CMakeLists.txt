cmake_minimum_required(VERSION 3.16)

project(ludo)
cmake_policy(SET CMP0076 NEW)


set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

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
if("${IsAndroid}" STREQUAL "true")
    message("ANDROID ARM-8 DEBUG linking")
    target_link_libraries(ludo_engine PUBLIC  EngineE libgodot-cpp.android.debug.arm64v8.a)
else()
    message("LINUX 64 DEBUG linking")
    target_link_libraries(ludo_engine PUBLIC  libgodot-cpp.linux.debug.64.a EngineE)
endif()

