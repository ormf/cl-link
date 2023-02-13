cmake_minimum_required(VERSION 3.0)
project(AbletonLink)

function(configure_link_audio_sources target)
  if(APPLE)
    target_link_libraries(${target} "-framework AudioUnit")
    target_compile_definitions(${target} PRIVATE
      -DLINKHUT_AUDIO_PLATFORM_COREAUDIO=1
    )
  elseif(CMAKE_SYSTEM_NAME MATCHES "Linux|kFreeBSD|GNU")
    if(LINK_BUILD_JACK)
      target_link_libraries(${target} jack)
      target_compile_definitions(${target} PRIVATE
        -DLINKHUT_AUDIO_PLATFORM_JACK=1
      )
    else()
      target_link_libraries(${target} asound portaudio)
      target_compile_definitions(${target} PRIVATE
        -DLINKHUT_AUDIO_PLATFORM_PORTAUDIO=1
      )
    endif()
  elseif(WIN32)
    if(LINK_BUILD_ASIO)
      # ASIO uses lots of old-school string APIs from the C stdlib
      add_definitions("/D_CRT_SECURE_NO_WARNINGS")
      target_compile_definitions(${target} PRIVATE
        -DLINKHUT_AUDIO_PLATFORM_ASIO=1
      )
    else()
      target_compile_definitions(${target} PRIVATE
        -DLINKHUT_AUDIO_PLATFORM_WASAPI=1
      )
      endif()

    target_link_libraries(${target} winmm)
  endif()

endfunction()



set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/lib)

include(modules/link/AbletonLinkConfig.cmake)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/modules/linkaudio)

set(AbletonLink_HEADERS
  ${CMAKE_CURRENT_SOURCE_DIR}/modules/linkaudio/AudioEngine.hpp
  ${CMAKE_CURRENT_SOURCE_DIR}/modules/linkaudio/AudioPlatform.hpp
)

set(AbletonLink_SOURCES
  ${CMAKE_CURRENT_SOURCE_DIR}/modules/linkaudio/AudioEngine.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/src/link-clcxx.cpp
)

# add_executable(LinkHut
#   ${linkhut_HEADERS}
#   ${linkhut_SOURCES}
#   ${linkhut_audio_SOURCES}
# )
# configure_linkhut_audio_sources(LinkHut)
# configure_linkhut_executable(LinkHut)
# source_group("LinkHut" FILES ${linkhut_HEADERS} ${linkhut_SOURCES})


# add_library(AbletonLink SHARED ${CMAKE_CURRENT_SOURCE_DIR}/src/link-clcxx.cpp)

add_library(AbletonLink SHARED ${AbletonLink_HEADERS} ${AbletonLink_SOURCES})
# add_library(AbletonLink SHARED ${CMAKE_CURRENT_SOURCE_DIR}/src/test.cpp)

target_link_libraries(AbletonLink PRIVATE Ableton::Link)


