#!/bin/sh

set -e

cd "$(dirname "$0")"

usage() {
    echo "Usage: build.sh <task> <mode>?"
    exit 1
}

OUT=out

CXX=$(which clang++)
CXXFLAGS="-std=c++20 -Wall -Wextra -Wpedantic -Werror -g"
CXXFLAGS_RELEASE="$CXXFLAGS -O3 -DNDEBUG"
CXXFLAGS_ASAN="$CXXFLAGS -fsanitize=address,undefined,leak"

TASK=$1
MODE=$2

if [ -z "$TASK" ]; then
    echo "Invalid argument: TASK must be set."
    usage
fi

echo "Got TASK: $TASK"

if [ "$MODE" = "Release" ]; then
    CXXFLAGS_TOTAL="$CXXFLAGS_RELEASE"
elif [ "$MODE" = "Asan" ]; then
    CXXFLAGS_TOTAL="$CXXFLAGS_ASAN"
else
    echo "Invalid argument: MODE must be either 'Release' or 'Asan'."
    usage
fi

echo "Got MODE: $MODE"

mkdir -p ../$OUT/$TASK
"$CXX" $CXXFLAGS_TOTAL "../$TASK/Main.cpp" -o "../$OUT/$TASK/App$MODE"
