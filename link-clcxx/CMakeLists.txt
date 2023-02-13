cmake_minimum_required(VERSION 3.0)
project(AbletonLink)

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/lib)

include(modules/link/AbletonLinkConfig.cmake)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

add_library(AbletonLink SHARED ${CMAKE_CURRENT_SOURCE_DIR}/src/link-clcxx.cpp)

target_link_libraries(AbletonLink PRIVATE Ableton::Link)


