FROM node:alpine3.17 as akash
WORKDIR /myapp
COPY package.json .
COPY package-lock.json .
COPY . .
RUN npm install
RUN npm run build



FROM nginx:1.25.2-alpine
WORKDIR /usr/share/nginx/html
COPY --from=akash /myapp/build .
EXPOSE 80
ENTRYPOINT [ "nginx","-g","daemon off;" ]
