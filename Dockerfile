FROM node:latest

EXPOSE 9001

RUN apt update && apt install --yes --no-install-recommends curl git nano python3 python3-pip python3-venv && rm -rf /var/lib/apt/lists/*

RUN npm install -g n

USER node

ENV HOME="/home/node"

ENV N_PREFIX="$HOME/.n"

ENV PATH="$N_PREFIX/bin:$PATH"

WORKDIR "$HOME/dev"

RUN n lts && n latest

RUN n exec lts npx create-next-app@latest site-ssr --app --src-dir --eslint --javascript --tailwind --turbopack --eslint --use-yarn --yes && \
    yarn --cwd site-ssr install

RUN n exec latest npx create-next-app@latest site-csr --app --src-dir --eslint --javascript --tailwind --turbopack --eslint --use-yarn --yes && \
    yarn --cwd site-csr install

RUN n exec lts npx create-next-app@latest site-api --app --src-dir --eslint --javascript --tailwind --turbopack --eslint --use-yarn --yes && \
    yarn --cwd site-api install

WORKDIR "$HOME"

RUN python3 -m venv .venv && . .venv/bin/activate && pip install supervisor

ENV PATH="$HOME/.venv/bin:$PATH"

COPY supervisord.conf supervisord.conf

CMD [ "supervisord" ]