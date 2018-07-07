# Cassio Test K8S Golang Service

## Config

Set environment variable PORT to the desired port number:

`$env:PORT=8000`

To remove a environment variable, you can run:

`Remove-Item Env:PORT`

## Run

`go run main.go`

## Run unit tests

`go test -v ./...`