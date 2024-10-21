#!/bin/sh

# Run the Ruby script
ruby main.rb

# Run the Docker command
docker run -i ghcr.io/burntsushi/erd:latest < erd-files/metafields.er > out.pdf