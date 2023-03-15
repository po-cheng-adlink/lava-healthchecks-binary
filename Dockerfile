FROM nginx:mainline-alpine

COPY mainline /usr/share/nginx/html/mainline/
COPY images /usr/share/nginx/html/images/
