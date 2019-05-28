FROM ubuntu:18.04
RUN sudo apt-get update && sudo apt-get install -y nodejs &&
    sudo apt-get install -y npm
RUN nodejs -v

#----------------Install frameworks------------------------
FROM nodejs
RUN npm install express