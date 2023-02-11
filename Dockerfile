FROM node:18-alpine

# Open port 80 required by NodeJS application.
EXPOSE 80

# Copy nodejs application to <container>/application
COPY sampleapp sampleapp

# set application as workditrectory for container
WORKDIR /sampleapp

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

ENTRYPOINT [ "npm" ]
CMD [ "start" ]