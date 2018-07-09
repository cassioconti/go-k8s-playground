# Cassio Test K8S Golang Service

### Acknowledgement

First of all, thanks to Elena Grahovac for her awesome tutorial.

<https://blog.gopheracademy.com/advent-2017/kubernetes-ready-service>
<https://github.com/rumyantseva/advent-2017>

### Config

You can update the `Makefile` if you want to change the PORT where the server will run, currently set to `8000`.

### Build

If you want to only build a docker image, run:

`make build`

### Run

The following command builds and run a docker image:

`make run`

### Deploy

To deploy, you first need to be connected to your cluster with `kubectl`, something like:

`gcloud container clusters get-credentials my-cluster-1 --zone us-central1-a --project my-gcloud-project`

Then you can run:

`make deploy`

### Cleanup

If you want to remove the binary generated, run:

`make clean`

### Run unit tests

`make test`