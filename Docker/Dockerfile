FROM ubuntu:18.04
RUN sudo apt-get update && sudo apt-get install -y nodejs &&
    sudo apt-get install -y npm
RUN nodejs -v

#----------------Install frameworks------------------------
FROM nodejs:10
RUN npm install express && npm install nodemon --save-dev \
    npm i bcryptjs body-parser cors jsonwebtoken moment mongoose \
    npm i morgan multer passport passport-jwt