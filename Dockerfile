FROM node:12-alpine

WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .

# sebelum build/start, pastikan baseURL di api.js = https://api.batch24.studentdumbways.my.id
EXPOSE 3000
CMD ["npm", "start"]
