# CURDIR: Gets the full path of the current directory (D:/VCS/Go/src/cassio-test-k8s-ready-service)
# notdir: get the last part, which is the name of this folder alone (cassio-test-k8s-ready-service)
PROJECT?=${notdir ${CURDIR}}

# Idea: Use build number in the last group of numbers
RELEASE?=0.0.1

# Get the last commit hash
COMMIT?=${shell git rev-parse --short HEAD}

# Get the date in format "2018-12-26_15:27:42"
BUILD_TIME?=${shell date -u '+%Y-%m-%d_%H:%M:%S'}

APP?=advent
PORT?=8000
GOOS?=linux
GOARCH?=amd64
CONTAINER_IMAGE?=docker.io/cassioconti/${APP}

clean:
	rm -f ${APP}

build: clean
	# ldflags "<flags>": The <flags> are passed to Go linker
	# -X folder.package.parameter=value: Sets "value" to the "parameter", which is part of the "package" inside "folder".
	# -o <output>: The generated binary is writen with the name <output>
	CGO_ENABLED=0 GOOS=${GOOS} GOARCH=${GOARCH} go build \
		-ldflags "-s -w -X ${PROJECT}/version.Release=${RELEASE} \
		-X ${PROJECT}/version.Commit=${COMMIT} -X ${PROJECT}/version.BuildTime=${BUILD_TIME}" \
		-o ${APP}

container: build
	docker build -t ${CONTAINER_IMAGE}:${RELEASE} .

run: container
	docker stop ${APP}:${RELEASE} || true && docker rm ${APP}:${RELEASE} || true
	docker run --name ${APP} -p ${PORT}:${PORT} --rm \
		-e "PORT=${PORT}" \
		${APP}:${RELEASE}

push: container
	docker push ${CONTAINER_IMAGE}:${RELEASE}

# deploy: push
# 	for t in $(shell find ./kubernetes/ -type f -name "*.yaml"); do \
#         cat $$t | \
#         	sed -E "s/\{\{(\s*)\.Release(\s*)\}\}/$(RELEASE)/g" | \
#         	sed -E "s/\{\{(\s*)\.ServiceName(\s*)\}\}/$(APP)/g"; \
#         echo -e "\n---"; \
#     done > tmp.yaml
# 	kubectl apply -f tmp.yaml

deploy-no-ingress:
	kubectl run ${APP} --image=${CONTAINER_IMAGE}:${RELEASE} --port 8000
	kubectl expose deployment ${APP} --type=LoadBalancer --port 80 --target-port 8000
	kubectl get service

kubectl-cleanup:
	kubectl delete ingress ${APP} || true
	kubectl delete service ${APP} || true
	kubectl delete deployment ${APP} || true

test:
	go test -v -race ./...