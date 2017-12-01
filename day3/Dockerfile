#Sets the Base Image
FROM node:carbon

# Set the working directory to /code
WORKDIR /code

#Copies package.json and app.js and adds them to the filesystem of the container
COPY package.json package.json
COPY app.js app.js

#Install npm on current image 
RUN npm install

#Runs node app in container.
CMD node app.js