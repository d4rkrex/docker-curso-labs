FROM alpine:3.14.2

# ensure we only use apk repositories over HTTPS (altough APK contain an embedded signature)
RUN echo "https://alpine.global.ssl.fastly.net/alpine/v$(cut -d . -f 1,2 < /etc/alpine-release)/main" > /etc/apk/repositories \
	&& echo "https://alpine.global.ssl.fastly.net/alpine/v$(cut -d . -f 1,2 < /etc/alpine-release)/community" >> /etc/apk/repositories

# The user the app should run as
ENV APP_USER=app
# The home directory
ENV APP_DIR="/$APP_USER"
# Where persistent data (volume) should be stored
ENV DATA_DIR "$APP_DIR/data"
# Where configuration should be stored
ENV CONF_DIR "$APP_DIR/conf"

# Add custom user and setup home directory
RUN addgroup -S $APP_USER && adduser -s /bin/true -u 1000 -S -D -h $APP_DIR $APP_USER -G $APP_USER \
  && mkdir "$DATA_DIR" "$CONF_DIR" \
  && chown -R "$APP_USER" "$APP_DIR" "$CONF_DIR" \
  && chmod 700 "$APP_DIR" "$DATA_DIR" "$CONF_DIR"

# Default directory is /app
WORKDIR $APP_DIR

# Install Java
ENV JAVA_HOME="/usr/lib/jvm/default-jvm/"
RUN apk add --no-cache ca-certificates openjdk11
ENV PATH=$PATH:${JAVA_HOME}/bin

# Newrelic installation
RUN wget https://download.newrelic.com/newrelic/java-agent/newrelic-agent/current/newrelic-java.zip
RUN unzip newrelic-java.zip -d /usr/local/
RUN rm -f newrelic-java.zip

# Copy 
COPY hardener.sh ./
RUN chmod 755 hardener.sh && ./hardener.sh

# Enforce User
USER $APP_USER:$APP_USER

CMD ["jshell"]