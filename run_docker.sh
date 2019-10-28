#!/bin/bash
sudo docker run -it --rm \
	--runtime nvidia \
	-u $(id -u):$(id -g) \
	-v ${PWD}/src:/src \
	tensorflow

#-p 8888:8888 \
