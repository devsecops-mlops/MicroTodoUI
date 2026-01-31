#base image as builder in first stage
FROM node:16.17.0-alpine as builder
#set working directory in the container
WORKDIR /app
#copy package-locl.json and package.json
COPY package*.json ./
# Install dependencies
RUN npm install
#copy all files to current working directory in container
COPY . .
#build
RUN npm run build
#Second stage
FROM nginx:alpine
#copy artifacts
COPY --from=builder /app/build /usr/share/nginx/html
#expose docker container on port 80
EXPOSE 80
