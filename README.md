# Cassio Test K8S Golang Service

## Acknowledgement

First of all, thanks to Elena Grahovac for her awesome tutorial.

<https://blog.gopheracademy.com/advent-2017/kubernetes-ready-service>
<https://github.com/rumyantseva/advent-2017>

## Config

You can update the `Makefile` if you want to change the PORT where the server will run, currently set to `8000`.

## Run

The following command builds and run:

`make run`

### Build

If you want to only build, run:

`make build`

### Cleanup

If you want to remove the binary generated, run:

`make clean`

## Run unit tests

`make test`