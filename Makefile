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


clean:
	rm -f ${APP}

build: clean
	# ldflags "<flags>": The <flags> are passed to Go linker
	# -X folder.package.parameter=value: Sets "value" to the "parameter", which is part of the "package" inside "folder".
	# -o <output>: The generated binary is writen with the name <output>
	go build \
		-ldflags "-s -w -X ${PROJECT}/version.Release=${RELEASE} \
		-X ${PROJECT}/version.Commit=${COMMIT} -X ${PROJECT}/version.BuildTime=${BUILD_TIME}" \
		-o ${APP}

run: build
	PORT=${PORT} ./${APP}

test:
	go test -v -race ./...