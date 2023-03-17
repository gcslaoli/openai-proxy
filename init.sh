#!/bin/bash
# 初始化开发环境

# 出错时终止脚本
set -e

# 获取当前脚本所在目录完整路径
BASEDIR=$(cd `dirname $0`; pwd)
echo "BASEDIR: $BASEDIR"

# 初始化所有子模块
git submodule update --init --recursive

# 替换 backend 的 git 地址为 ssh 地址
cd $BASEDIR/backend
git remote set-url --push origin git@github.com:gcslaoli/openai-proxy-backend.git 

# 替换 frontend 的 git 地址为 ssh 地址
cd $BASEDIR/frontend
git remote set-url --push origin git@github.com:gcslaoli/openai-proxy-frontend.git 

# 如果当前运行环境是 codespaces，则从 Codespaces secrets 中获取 ssh 私钥 并写入到 ~/.ssh/id_rsa
if [ -n "$CODESPACES" ]; then
# 如果没有设置 ssh 私钥,则继续执行
    if [ -z "$SSH_PRIVATE_KEY" ]; then
        echo "SSH_PRIVATE_KEY is not set"
    else
        echo "SSH_PRIVATE_KEY is set"
        # 如果 ~/.ssh/id_rsa 存在，则先删除
        if [ -f ~/.ssh/id_rsa ]; then
            rm ~/.ssh/id_rsa
        fi
        # 将 ssh 私钥写入到 ~/.ssh/id_rsa
        echo "$SSH_PRIVATE_KEY" > ~/.ssh/id_rsa
        chmod 600 ~/.ssh/id_rsa
    fi

fi
cat ~/.ssh/id_rsa