#!/bin/bash
PROGNAME=$0

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

usage() {
  cat << EOF >&2
Usage: $PROGNAME prod|beta|alpha|prep|dev

Invalididates the cloud front associated with this spa

EOF
  exit 1
}

if [ -z "$1" ] || [[ ! $1 =~ ^prod$|^beta$|^alpha$|^prep$|^dev$ ]]
then
  printf "${RED} Enter a stage prod|dev ${NC} \n"
  echo usage
  exit
fi

stage=$1

if [ $stage = "prod" ] || [ $stage = "beta" ] && [ ! $AWS_VAULT = "prod-invalidator" ]
then
  printf "${RED}For production deploys you must assume the prod-invalidator role ${NC} \n"
  usage
  exit
fi

if [ $stage = "dev" ] || [ $stage = "alpha" ] || [ $stage = "prep" ] && [ ! $AWS_VAULT = "testlib" ]
then
  printf "${RED}For testlib deploys you must assume the testlibnd role ${NC} \n"
  usage
  exit
fi

if [ $stage = "prod" ]
then
  cloudfrontid="EE14BFPF6TQIK"
elif [ $stage = "dev" ]
then
  cloudfrontid="E874ZZB7ZEYT3"
fi

aws cloudfront create-invalidation --distribution-id $cloudfrontid --paths "/*"

printf "${GREEN}Success${NC} \n"
