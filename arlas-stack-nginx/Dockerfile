FROM nginx:1.25.3-alpine3.18-slim
COPY arlas-stack-nginx/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]