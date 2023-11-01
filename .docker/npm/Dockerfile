FROM node:14-alpine as npm

USER node:node
# ARG USER
# ARG GROUP
# RUN adduser -g ${GROUP} -s /bin/sh -D ${USER}
RUN mkdir /.npm && chown -R ${USER}:${GROUP} /.npm && \
    mkdir /.config && chown -R ${USER}:${GROUP} /.config

RUN npm install -g http-server
EXPOSE 3000
CMD [ "http-server", "dist" ]