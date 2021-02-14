cmake_minimum_required(VERSION 3.16)

project(EngineE)


set(CMAKE_EXPORT_COMPILE_COMMANDS ON)





add_library(EngineE)
#add_executable(EngineE)
target_sources(EngineE PUBLIC 
            src/EngineE.cpp 
            src/DebugE.cpp        
            src/CoreE.cpp
            )
target_compile_features(EngineE PRIVATE cxx_std_20)
target_compile_options(EngineE PRIVATE -g -O0)
target_include_directories(EngineE PUBLIC includes ${CMAKE_CURRENT_SOURCE_DIR})




#-fno-exceptions