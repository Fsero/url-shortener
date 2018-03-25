#!/usr/bin/env bash
set -x

export AWS_DEFAULT_REGION=eu-west-1

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

pushd docker
docker-compose build
docker-compose run -u ${UID} dev $@
popd
