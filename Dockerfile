FROM node:latest

RUN apt update && apt install --yes --no-install-recommends curl git nano python3 python3-pip python3-venv && rm -rf /var/lib/apt/lists/*

USER node

WORKDIR /home/node/dev

ENV NVM_DIR=/home/node/.nvm

RUN mkdir -p ${NVM_DIR}

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash && . ${NVM_DIR}/nvm.sh && nvm install 23.6.1 && nvm install 20.14.0

RUN . ${NVM_DIR}/nvm.sh && nvm use 23.6.1 && npx create-next-app@latest site-ssr --app --src-dir --eslint --javascript --tailwind --turbopack --eslint --use-yarn --yes && yarn --cwd site-ssr install
RUN . ${NVM_DIR}/nvm.sh && nvm use 20.14.0 && npx create-next-app@latest site-csr --app --src-dir --eslint --javascript --tailwind --turbopack --eslint --use-yarn --yes && yarn --cwd site-csr install
RUN . ${NVM_DIR}/nvm.sh && nvm use 23.6.1 && npx create-next-app@latest site-api --app --src-dir --eslint --javascript --tailwind --turbopack --eslint --use-yarn --yes && yarn --cwd site-api install

WORKDIR /home/node
EXPOSE 9001

RUN mkdir -p .venv
COPY supervisord.conf .venv/supervisord.conf

RUN python3 -m venv .venv && . .venv/bin/activate && pip install supervisor

ENV PATH="/home/node/.venv/bin:$PATH"

CMD ["supervisord"]

# output nvm and path to .profile

# HERE SUPERVISORD CALL All SITE HERE TO START
#yarn --port 3001

#ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
#ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
#
#RUN echo "source $NVM_DIR/nvm.sh && \
#    nvm install $NODE_VERSION && \
#    nvm alias default $NODE_VERSION && \
#    nvm use default" | bash
#ENV NVM_DIR=/home/node/.nvm
#
#RUN . /home/node/.nvm/nvm.sh && nvm install 23.6.1 && nvm install 20.14.0

# Environment variables for nvm
#ENV NVM_DIR /home/node/.nvm
#ENV PATH $NVM_DIR/versions/node/v0.0.0/bin:$PATH
#
## Install Node.js versions using nvm
#RUN bash -c "source $NVM_DIR/nvm.sh && nvm install 23.6.1 && nvm install 20.14.0"
#
## Set default Node.js version (optional)
#RUN bash -c "source $NVM_DIR/nvm.sh && nvm alias default 23.6.1"
#
## Verify installation
#RUN bash -c "source $NVM_DIR/nvm.sh && node -v && npm -v"

# Source nvm and install Node.js versions
#RUN . /home/node/.nvm/nvm.sh && nvm install 23.6.1 && nvm install 20.14.0

## Set default Node.js version (optional)
#RUN . /home/node/.nvm/nvm.sh && nvm alias default 23.6.1
#
## Export environment variables
#ENV NVM_DIR /home/node/.nvm
#ENV NODE_VERSION 23.6.1
#ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
#
## Verify installation
#RUN node -v && npm -v


#FROM node:20.14.0 AS site-ssr
#
#RUN apt update && apt install --yes --no-install-recommends curl git nano python3 python3-pip python3-venv && rm -rf /var/lib/apt/lists/*
#
#USER node
#
#WORKDIR /home/node/dev
#
#RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash && . /home/node/.nvm/nvm.sh && nvm install 23.6.1 && nvm install 20.14.0

#    && . "/home/node/nvm.sh"
#    . /home/node/.nvm/nvm.sh && nvm install 23.6.1 && nvm install 20.14.0


#RUN nvm use 23.6.1 && npx create-next-app@latest "$HOME/dev/site-ssr" --app --src-dir --eslint --javascript --tailwind --turbopack --eslint --use-yarn --yes


#EXPOSE 9001
#
#ENV PATH="/home/node/.venv/bin:$PATH"
#
#WORKDIR /home/node
#
#RUN python3 -m venv .venv && . .venv/bin/activate && pip install supervisor
#
#RUN echo "[supervisord]" > /home/node/.venv/supervisord.conf
#RUN echo "nodaemon=true" >> /home/node/.venv/supervisord.conf
#
#CMD ["supervisord"]

#RUN mkdir -p /home/node/.venv
#RUN echo "[supervisord]" > /home/node/.venv/supervisord.conf
#RUN echo "nodaemon=true" >> /home/node/.venv/supervisord.conf
#RUN cd /home/node && python3 -m venv .venv && . .venv/bin/activate && pip install supervisor
#CMD ["/home/node/.venv/bin/supervisord"]

#    && source /home/node/venv/bin/activate && pip install supervisor && supervisord && supervisorctl status

#RUN git clone --depth 1 --branch develop git@gitlab.com:mysmartjourney/visit-mysmartjourney-ssr.git /home/dev/site-ssr
#RUN rm -rf /var/lib/apt/lists/*
#
#ENV API_TOKEN="glpat-o_neT6f9mJTCMsnfxCn9"
#
#WORKDIR /home/dev/site-ssr
#
#ENV NODE_ENV="development"
#RUN yarn install --production && yarn build && yarn cache clean && yarn dev
#
#ENV NODE_ENV="production"supervisorctl statussupervisorctl status
#RUN yarn install --production && yarn build && yarn cache clean && yarn prod