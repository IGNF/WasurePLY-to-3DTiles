export NAME_IMG_BASE="mesh23dtile"
export NAME_IMG_TAG=":latest"

if [ ! -z ${HTTP_PROXY} ] 
then
PROXY_CMD=" --build-arg HTTP_PROXY=${HTTP_PROXY} --build-arg HTTPS_PROXY=${HTTPS_PROXY} "
fi

docker build ${PROXY_CMD} --network=host --no-cache -t  ${NAME_IMG_BASE}${NAME_IMG_TAG} -f "./Dockerfile" .