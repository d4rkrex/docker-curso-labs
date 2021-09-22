FROM node:slim


RUN apt update && apt upgrade -y && apt autoremove

CMD echo "Hola"
