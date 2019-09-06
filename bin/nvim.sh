#!/bin/bash
docker run --rm -it --mount type=bind,source="$(pwd)",target=/var/nvim-edit nvim nvim "$@"