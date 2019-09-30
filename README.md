# TensorFlow-gpu Dockerfile on ubuntu18.04(LTS)

This repository lets you make tesnroflow-gpu-docker-enviroment.
Plase make sure you should check the nvidia-docker [github](https://github.com/NVIDIA/nvidia-docker).
## 1. Install the Nvidia-Driver
```bash
$ sudo ubuntu-drivers autoinstall
$ sudo reboot
```
or (recommend)
```bash
$ sudo add-apt-repository ppa:graphics-drivers/ppa
$ sudo apt update
$ apt-cache search nvidia-driver
$ sudo apt-get -y install ubuntu-drivers-common
$ sudo ubuntu-drivers autoinstall
$ sudo reboot
```

## 2. Install the Dcoker
```bash
$ sudo apt-get update
$ sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable test edge"
$ sudo apt-get update
$ sudo apt-get install -y docker-ce
```
If you want to give authority to docker, please command as follow:
```bash
$ sudo usermod -aG docker $USER
$ sudo reboot
```
You can run docker commands without sudo, then.

## 3. Install the Nvidia-docker2
```bash
$ curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
$ distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
$ curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
$ sudo apt-get update
$ sudo apt-get install -y nvidia-docker2
$ sudo pkill -SIGHUP dockerd
```
## 4. Build docker image
```bash
$ sudo docker build -t tensorflow .
```

## 5. Run docker container
You can run the image to make the container as follow:
```bash
$ bash run_docker.sh
```
## 6. Have a enjoy programming!
./src in the host machine is mounted to ./src in the docker-container.
You can create some code in "./src".
## Note:
- How to change tensorflow version?
A. Change "Dockerfile" as follow:
```Dockerfile
Before: ARG TENSORFLOW_VERSION=latest-gpu-py3
After : ARG TENSORFLOW_VERSION=2.0.0a0-gpu-py3
```
- How to link another directory to the directory in ./src on your host machine?
```bash
$ ln -s ORIGIN_OF_LINK DESTINATION_OF_LINK
```
