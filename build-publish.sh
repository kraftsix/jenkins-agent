#!/bin/bash

cat << EOF
██╗░░██╗██████╗░░█████╗░███████╗████████╗░██████╗██╗██╗░░██╗
██║░██╔╝██╔══██╗██╔══██╗██╔════╝╚══██╔══╝██╔════╝██║╚██╗██╔╝
█████═╝░██████╔╝███████║█████╗░░░░░██║░░░╚█████╗░██║░╚███╔╝░
██╔═██╗░██╔══██╗██╔══██║██╔══╝░░░░░██║░░░░╚═══██╗██║░██╔██╗░
██║░╚██╗██║░░██║██║░░██║██║░░░░░░░░██║░░░██████╔╝██║██╔╝╚██╗
╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░░░░░░╚═╝░░░╚═════╝░╚═╝╚═╝░░╚═╝
EOF

# do not continue if version tag is not provided

if [ -z "$1" ]
  then
    echo "::::VERSION IS REQUIRED:::"
    exit 1
fi

dockerfile="Dockerfile"

TAG="latest"
VERSION_TAG=$1

IMAGE_NAME="kraftsix/jenkins-agent"

REPOSITORY="$IMAGE_NAME:$TAG"
REPOSITORY_VERSION="$IMAGE_NAME:$VERSION_TAG"

# build the docker image
docker build --no-cache -t $REPOSITORY -f $dockerfile .
docker build --no-cache -t $REPOSITORY_VERSION -f $dockerfile .


if [ "$2" == "upload" ]
    then
    echo "::::BUILD COMPLETE PUSHING TO REPOSITORY:::"
    docker login
    docker push $REPOSITORY
    docker push $REPOSITORY_VERSION
    echo "::::DOCKER PUSH COMPLETE EXITING:::"
fi


echo "::::BUILD COMPLETE::::"