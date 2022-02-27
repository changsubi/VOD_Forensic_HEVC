cmake_minimum_required(VERSION 3.16)
project(WKforensic)

set(CMAKE_CXX_STANDARD 14)

set(PROJECT_HEADERS
        CABAC_ArithmeticDecoder.h
        CABAC_ArithmeticEncoder.h
        CABAC_BitstreamFile.h
        CABAC_CommonDef.h
        CABAC_ContextModel.h
        MarkGenerate.h
        sha256.h
        stdafx.h
        )
set(PROJECT_SOURCES
        main.cpp
        CABAC_ArithmeticDecoder.cpp
        CABAC_ArithmeticEncoder.cpp
        CABAC_BitstreamFile.cpp
        CABAC_ContextModel.cpp
        MarkGenerate.cpp
        sha256.cpp
        stdafx.cpp
        )

include_directories(/usr/include)
include_directories(/usr/include/cppconn)
link_directories(/usr/lib)

add_executable(WKforensic ${PROJECT_SOURCES} ${PROJECT_HEADERS})

target_link_libraries(WKforensic curl mysqlcppconn)
target_compile_features(WKforensic PRIVATE cxx_range_for)