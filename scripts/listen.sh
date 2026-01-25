#!/bin/bash

while true; do
    find . -name '*.ms' -o -name "*.m" | entr -d -r make
done
