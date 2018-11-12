#!/bin/bash

input=$1
IFS=. read name ext <<< $input
python -m readme2tex --output $name.md $input
