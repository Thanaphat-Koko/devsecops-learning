FROM node:18-alpine

WORKDIR /app

COPY package.json ./

# Install dependencies (though none are currently listed in package.json, this is good practice)
RUN npm install

COPY . .

EXPOSE 3000

CMD [ "node", "index.js" ]
