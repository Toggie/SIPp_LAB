#!/bin/bash

USAGE="
USAGE:
[Server IP] [Client IP] [Mode (server/client)]

EXAMPLE: 192.168.1.101 192.168.1.102 server
"

SERVER_IP="$1"
CLIENT_IP="$2"
TEST_MODE="$3"

start_sipp() {
  if [ "$TEST_MODE" == "server" ]; then
    echo "$(date): Launching SIPp Server scenario (uas_cello.xml)" && \
    sipp -bg -sf uas_cello.xml >/dev/null 2>&1
  elif [ "$TEST_MODE" == "client" ]; then
    echo "$(date): Launching SIPp Client scenario (uac_cello.xml)" && \
    sipp -bg -sf uac_cello.xml $SERVER_IP >/dev/null 2>&1
  else
    exit 1
  fi
}

cleanup() {
echo "Stopping SIPp"
killall sipp
}

echo "$SERVER_IP $CLIENT_IP $TEST_MODE"

start_sipp &
sleep 75
cleanup

if [ "$?" == "0" ]; then
  echo "SUCCESS!"
  exit 0
else
  echo "FAILURE!"
  exit 1
fi

