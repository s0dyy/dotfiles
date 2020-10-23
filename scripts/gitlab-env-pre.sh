#!/bin/bash

local token="<my-token>"

curl --header "PRIVATE-TOKEN: ${token}" "https://gitlab.com/api/v4/projects/<id>/variables" | \
    jq -r '.[]| "\(.key)=\(.value)"' | \
    grep "^ENV_"
