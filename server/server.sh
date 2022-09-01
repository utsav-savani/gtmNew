#!/bin/bash

# Welcome
echo 'Server start script initialized...'

# Set the port
PORT=443
#URL="https://qa-gtm.uas.aero"
URL=${URL}

# Kill anything that is already running on that port
echo 'Cleaning port' $PORT '...'
fuser -k $PORT/tcp

# Change directories to the release folder
cd build/web/

# Start the server
echo 'Starting server on '$URL' port ' $PORT '...'

python3 /app/server/redirect.py $PORT &
python3 /app/server/https.py $PORT

# Exit
echo 'Server exited...'
