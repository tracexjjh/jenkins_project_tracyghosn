#!/bin/sh
set -eu

workspace_dir="${WORKSPACE:-.}"
deployment_dir="${DEPLOY_DIR:-${workspace_dir}@deploy}"
mkdir -p "$deployment_dir"
cp app.py "$deployment_dir/app.py"

printf 'Deployed app.py to %s\n' "$deployment_dir"
