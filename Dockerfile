# 第一阶段：构建 Next.js 应用
FROM node:20-alpine AS builder

# 设置工作目录
WORKDIR /thrive/blog

# 配置 npm 镜像源
RUN npm config set registry https://registry.npmmirror.com

# 复制 package.json 和 package-lock.json
COPY package*.json .

# 安装依赖
RUN npm install

# 复制所有文件到工作目录
COPY . .

# 构建 Next.js 应用
RUN npm run build

# 第二阶段：使用 NGINX 提供服务
FROM nginx:alpine

# 将第一阶段生成的静态文件复制到 NGINX 默认目录
COPY --from=builder /thrive/blog/.next/standalone /usr/share/nginx/html
COPY --from=builder /thrive/blog/.next/static /usr/share/nginx/html/_next/static

# 替换 NGINX 默认配置文件（如果需要自定义）
COPY nginx.conf /etc/nginx/nginx.conf

# 暴露端口
EXPOSE 80

# 启动 NGINX
CMD ["nginx", "-g", "daemon off;"]
