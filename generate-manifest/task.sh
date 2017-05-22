#!/bin/bash
#
# All UPERCASE variables are provided externally from this yml

set -eu
set -o pipefail

cd task-output

# Build the yaml create script
yml=
[ "${CF_APP_NAME:-}" ] && yml+="applications[0].name: $MF_NAME\n"
[ "${CF_APP_BUILDPACK:-}" ] && yml+="applications[0].buildpack: $MF_BUILDPACK\n"
[ "${CF_APP_COMMAND:-}" ] && yml+="applications[0].command: $MF_COMMAND\n"
[ "${CF_APP_DISK_QUOTA:-}" ] && yml+="applications[0].disk_quota: $MF_DISK_QUOTA\n"
[ "${CF_APP_DOMAIN:-}" ] && yml+="applications[0].domain: $MF_DOMAIN\n"
[ "${CF_APP_DOMAINS:-}" ] && yml+="applications[0].domains: $MF_DOMAINS\n"
[ "${CF_APP_HEALTH_CHECK_HTTP_ENDPOINT:-}" ] && yml+="applications[0].health-check-http-endpoint: $MF_HEALTH_CHECK_HTTP_ENDPOINT\n"
[ "${CF_APP_HEALTH_CHECK_TYPE:-}" ] && yml+="applications[0].health-check-type: $MF_HEALTH_CHECK_TYPE\n"
[ "${CF_APP_HOST:-}" ] && yml+="applications[0].host: $MF_HOST\n"
[ "${CF_APP_HOSTS:-}" ] && yml+="applications[0].hosts: $MF_HOSTS\n"
[ "${CF_APP_INSTANCES:-}" ] && yml+="applications[0].instances: $MF_INSTANCES\n"
[ "${CF_APP_MEMORY:-}" ] && yml+="applications[0].memory: $MF_MEMORY\n"
[ "${CF_APP_NO_HOSTNAME:-}" ] && yml+="applications[0].no-hostname: $MF_NO_HOSTNAME\n"
[ "${CF_APP_NO_ROUTE:-}" ] && yml+="applications[0].no-route: $MF_NO_ROUTE\n"
[ "${CF_APP_PATH:-}" ] && yml+="applications[0].path: $MF_PATH\n"
[ "${CF_APP_RANDOM_ROUTE:-}" ] && yml+="applications[0].random_route: $MF_RANDOM_ROUTE\n"
[ "${CF_APP_ROUTES:-}" ] && yml+="applications[0].routes: $MF_ROUTES\n"
[ "${CF_APP_STACK:-}" ] && yml+="applications[0].stack: $MF_STACK\n"
[ "${CF_APP_TIMEOUT:-}" ] && yml+="applications[0].timeout: $MF_TIMEOUT\n"
[ "${CF_APP_ENV:-}" ] && yml+="applications[0].env: $MF_ENV\n"
[ "${CF_APP_SERVICES:-}" ] && yml+="applications[0].services: $MF_SERVICES\n"

if [ -n "$yml" ]; then
  echo -e "---\n$(echo -e $yml | yaml n -s -)" > manifest.yml
  echo 'Generated manifest:'
  cat manifest.yml
else
  echo 'No manifest options specified: nothing to generate!'
fi

cd ..
