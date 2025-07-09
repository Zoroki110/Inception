#!/bin/bash

# Test nginx configuration
nginx -t

# Start nginx in foreground
exec nginx -g "daemon off;"