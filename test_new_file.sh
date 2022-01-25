#!/usr/bin/env bash

FILE=./src/Makefile
if test -f "$FILE"; then
    echo "$FILE exists. Task 2 completed successfully!"
else
    echo "$FILE does not exist. You failed to add the $FILE to revision control..."
    exit 1
fi
