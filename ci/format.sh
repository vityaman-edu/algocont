#!/bin/sh

set -e

cd "$(dirname "$0")"

cd ..

MODE=$1

if [ -z "$MODE" ]; then
    MODE="check"
fi

if [ "$MODE" != "fix" ] && [ "$MODE" != "check" ]; then
    echo "Invalid argument. MODE must be either 'fix' or 'check'."
    exit 1
fi

SOURCES=$(find contest -iname '*.cpp')

if [ "$MODE" = "fix" ]; then
    echo "$SOURCES" | xargs clang-format -i --fallback-style=Google --verbose
else
    echo "$SOURCES" | xargs clang-format -Werror --dry-run --fallback-style=Google --verbose
fi
