#!/bin/bash

while true; do
    find . -name '*.ms' | entr -d -r make
done
