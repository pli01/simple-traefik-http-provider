#!/bin/bash
#
# quick docker deploy
#
# optional dockerhub login

export DOCKERHUB_LOGIN="${DOCKERHUB_LOGIN:-}"
export DOCKERHUB_TOKEN="${DOCKERHUB_TOKEN:-}"

export APP_NAME="${APP_NAME:-simple-traefik-http-provider}"
export APP_BRANCH="${APP_BRANCH:-main}"
export APP_URL="https://github.com/pli01/${APP_NAME}/archive/refs/heads/${APP_BRANCH}.tar.gz"

# if authenticated repo
if [ -n "${GITHUB_TOKEN}" ] ; then
  curl_args=" -H \"Authorization: token ${GITHUB_TOKEN}\" "
fi

# if APP_ROLE defined use make up-${APP_ROLE}
if [ -n "$APP_ROLE" ] ;then
 app_role="-${APP_ROLE}"
fi

# download install repo
mkdir -p ${APP_NAME}
eval curl -kL -s $curl_args ${APP_URL} | \
   tar -zxvf - --strip-components=1 -C ${APP_NAME}
# install app (role)
( cd ${APP_NAME}
  [ -n "$DOCKERHUB_TOKEN" -a -n "$DOCKERHUB_LOGIN" ] &&  echo $DOCKERHUB_TOKEN | \
      docker login --username $DOCKERHUB_LOGIN --password-stdin

  make down$app_role || true
  make up$app_role

  if [ -n "$DOCKERHUB_TOKEN" -a -n "$DOCKERHUB_LOGIN" ] ;then docker logout ; fi
) || exit $?
exit 0
