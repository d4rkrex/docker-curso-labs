FROM node:slim


HEALTHCHECK --interval=5m --timeout=3s \
 CMD curl https://localhost:8443/version -k || exit 1
#RUN apt update && apt upgrade -y && apt autoremove -y


WORKDIR /app
COPY . ./app

CMD echo "Hola"
