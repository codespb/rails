#!/bin/sh

INSTALL_PATH=/app
SERVER_PID=$INSTALL_PATH/tmp/pids/server.pid

if [ -f $SERVER_PID ]; then
    rm -f $SERVER_PID
fi

# Installing rails is /app dir is empty.
# Usefull when using volumes
if [ -f "$INSTALL_PATH/Gemfile" ]; then
    bundle install
else
    rails new $INSTALL_PATH -j esbuild --css tailwind --database=mysql --no-sprockets
fi
exec "$@"
