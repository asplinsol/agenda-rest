FROM node:lts-alpine as builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . ./
RUN npm run-script build 

FROM  node:lts-alpine 
WORKDIR /app/
COPY server.js settings.js ./
COPY --from=builder  /app/dist/ ./dist
COPY --from=builder  /app/node_modules/ ./node_modules
RUN ls -l
EXPOSE 4040
CMD ["node", "server.js"]  