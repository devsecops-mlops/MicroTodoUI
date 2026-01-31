#base image as builder in first stage
FROM node:16.17.0-alpine as builder
#set working directory in the container
WORKDIR /app
#copy package-locl.json and package.json
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80 
