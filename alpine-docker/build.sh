#!/bin/bash

set -euxo pipefail

rm -rf output && mkdir output

docker build -t porty/alpinebase .

docker run --rm -it -v $(pwd)/output:/output porty/alpinebase 
