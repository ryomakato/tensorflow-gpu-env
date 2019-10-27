#!/bin/bash
sudo docker run -it --rm \
--runtime nvidia \
-v $(pwd)/src:/src \
tensorflow

#-p 8888:8888 \
