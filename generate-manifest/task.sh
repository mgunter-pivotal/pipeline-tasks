#!/bin/bash
#
# All UPERCASE variables are provided externally from this yml

set -eu
set -o pipefail

cd task-output

# Build the yaml create script
yml=
[ "${CF_APP_NAME:-}" ] && yml+="applications[0].name: $CF_APP_NAME\n"
[ "${CF_APP_BUILDPACK:-}" ] && yml+="applications[0].buildpack: $CF_APP_BUILDPACK\n"
[ "${CF_APP_COMMAND:-}" ] && yml+="applications[0].command: $CF_APP_COMMAND\n"
[ "${CF_APP_DISK_QUOTA:-}" ] && yml+="applications[0].disk_quota: $CF_APP_DISK_QUOTA\n"
[ "${CF_APP_DOMAIN:-}" ] && yml+="applications[0].domain: $CF_APP_DOMAIN\n"
[ "${CF_APP_DOMAINS:-}" ] && yml+="applications[0].domains: $CF_APP_DOMAINS\n"
[ "${CF_APP_HEALTH_CHECK_HTTP_ENDPOINT:-}" ] && yml+="applications[0].health-check-http-endpoint: $CF_APP_HEALTH_CHECK_HTTP_ENDPOINT\n"
[ "${CF_APP_HEALTH_CHECK_TYPE:-}" ] && yml+="applications[0].health-check-type: $CF_APP_HEALTH_CHECK_TYPE\n"
[ "${CF_APP_HOST:-}" ] && yml+="applications[0].host: $CF_APP_HOST\n"
[ "${CF_APP_HOSTS:-}" ] && yml+="applications[0].hosts: $CF_APP_HOSTS\n"
[ "${CF_APP_INSTANCES:-}" ] && yml+="applications[0].instances: $CF_APP_INSTANCES\n"
[ "${CF_APP_MEMORY:-}" ] && yml+="applications[0].memory: $CF_APP_MEMORY\n"
[ "${CF_APP_NO_HOSTNAME:-}" ] && yml+="applications[0].no-hostname: $CF_APP_NO_HOSTNAME\n"
[ "${CF_APP_NO_ROUTE:-}" ] && yml+="applications[0].no-route: $CF_APP_NO_ROUTE\n"
[ "${CF_APP_PATH:-}" ] && yml+="applications[0].path: $CF_APP_PATH\n"
[ "${CF_APP_RANDOM_ROUTE:-}" ] && yml+="applications[0].random_route: $CF_APP_RANDOM_ROUTE\n"
[ "${CF_APP_ROUTES:-}" ] && yml+="applications[0].routes: $CF_APP_ROUTES\n"
[ "${CF_APP_STACK:-}" ] && yml+="applications[0].stack: $CF_APP_STACK\n"
[ "${CF_APP_TIMEOUT:-}" ] && yml+="applications[0].timeout: $CF_APP_TIMEOUT\n"
[ "${CF_APP_ENV:-}" ] && yml+="applications[0].env: $CF_APP_ENV\n"
[ "${CF_APP_SERVICES:-}" ] && yml+="applications[0].services: $CF_APP_SERVICES\n"

if [ -n "$yml" ]; then
  echo -e "---\n$(echo -e $yml | yaml n -s -)" > manifest.yml
  echo 'Generated manifest:'
  cat manifest.yml
else
  echo 'No manifest options specified: nothing to generate!'
fi

cd ..
