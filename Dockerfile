# Stage 1
FROM node:12-alpine as build-step
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app
RUN npm install
RUN npm install -g @angular/cli
COPY . /app
RUN ng build service-center-catalog -c production
 
# Stage 2
FROM nginx:1.17.1-alpine
COPY --from=build-step /app/dist/service-center-catalog /usr/share/nginx/html
