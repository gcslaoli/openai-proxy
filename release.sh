#!/bin/bash
# This script is used to release a new version of the project.

# 出错时终止
set -e

# 获取脚本所在目录为根目录
ROOT_DIR=$(cd $(dirname $0); pwd)
echo "ROOT_DIR: $ROOT_DIR"

# 进入前端目录
cd $ROOT_DIR/frontend

# 打包
echo "Building frontend ..."
npm run build

# 发布 
cd $ROOT_DIR
docker compose build
docker compose push
