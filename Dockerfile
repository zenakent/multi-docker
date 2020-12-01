FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . . 
RUN npm run build

#/app/build <-- all the stuff we care about

FROM nginx
#expose port 80 on AWS elasticbeanstalk
#does nothing on personal machine
EXPOSE 80
#--------------------#stuf     #copy the stuff to here
COPY --from=0 /app/build /usr/share/nginx/html
