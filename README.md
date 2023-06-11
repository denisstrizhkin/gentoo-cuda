# gentoo stage3 image based cuda/opencl container

Build this image
```console
$ docker build -t gentoocuda:latest https://github.com/denisstrizhkin/gentoo-cuda.git#main
```

Pass gpu
```console
$ docker run --rm -it --gpus all gentoocuda:latest nvidia-smi
```
