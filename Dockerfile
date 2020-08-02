#Phase 1
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm i
COPY . .
RUN npm run build

#Phase 2. FROM signalizes start of the new stage
FROM nginx
#copy ./build folder from the previous step to the /usr/share/nginx/html
#container.
COPY --from=builder /app/build /usr/share/nginx/html
#RUN command is not required. This is done by nginx image