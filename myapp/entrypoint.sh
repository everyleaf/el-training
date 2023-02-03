#!/bin/bash
set -e

rm -f /myapp/tmp/pids/server.pid

exec "$@"
