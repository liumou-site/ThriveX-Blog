set -e
# 如果 /thrive/blog下无文件则移动 /thrive/blog_source 目录覆盖
if [ ! -d "/thrive/blog" ]; then
    echo "blog目录不存在，开始初始化blog目录"
    if [ ! -d "/thrive/blog_source"];then
        echo "/thrive/blog_source目录不存在，请检查"
        exit 1
    fi
    cp -rf /thrive/blog_source/* /thrive/blog
    if [ $? -ne 0 ]; then
        echo "blog目录初始化失败"
        exit 1
    fi
    echo "blog目录初始化完成"
fi
ls -l /thrive/blog
if [ ! -d "/thrive/blog/.env" ]; then
    if [ ! -d "/thrive/blog_source"];then
        echo "/thrive/blog_source目录不存在，请检查"
        exit 1
    fi
    echo "/thrive/blog/.env 不存在，开始初始化blog目录"
    rm -rf /thrive/blog/*
    cp -rf /thrive/blog_source/* /thrive/blog
    if [ $? -ne 0 ]; then
        echo "blog目录初始化失败"
        exit 1
    fi
    echo "blog目录初始化完成"
fi
cd /thrive/blog
if [ $? -ne 0 ]; then
    echo "进入 /thrive/blog 目录失败"
   exit 4
fi
which npm
if [ $? -ne 0 ]; then
    echo "npm命令不存在"
    exit 3
fi
which next
if [ $? -ne 0 ]; then
    echo "next命令不存在"
    echo "npx next dev --turbopack"
    npx next dev --turbopack
else
    echo "next dev --turbopack"
    next dev --turbopack
fi

