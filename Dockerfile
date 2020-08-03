#Phase 1
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm i
COPY . .
RUN npm run build

#Phase 2. FROM signalizes start of the new stage
FROM nginx
#it does nothing. Just to let developers know that communications
# happens through port 80. But for example aws service can pick that up
# and automatically do the port mapping
EXPOSE 80
#copy ./build folder from the previous step to the /usr/share/nginx/html
#container.
COPY --from=builder /app/build /usr/share/nginx/html
#RUN command is not required. This is done by nginx image