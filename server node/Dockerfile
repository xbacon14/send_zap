FROM ubuntu:18.04 AS zap_server_dev
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app/
RUN apt-get update && apt-get install -y \
    gconf-service \
    libasound2 \
    libatk1.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libexpat1 \
    libfontconfig1 \
    libgcc1 \
    libgconf-2-4 \
    libgdk-pixbuf2.0-0 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    ca-certificates \
    fonts-liberation \
    libappindicator1 \
    libnss3 \
    lsb-release \
    xdg-utils \
    wget \
    build-essential \
    apt-transport-https \
    libgbm-dev \
    git

RUN apt-get install curl -y \
    && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y \
    nodejs && apt-get install chromium-browser xvfb -y \ 
    && npm i -g lighthouse -y

EXPOSE 3332
CMD npm install --verbose --foreground-scripts --ignore-scripts=false --platform=linuxmusl --arch=x64 sharp ; node index.js

FROM zap_server_dev AS zap_server_prod
WORKDIR /usr/src/app/
COPY package.json ./
RUN npm install
COPY . /usr/src/app/
#RUN rm -rf .env
COPY .env.prod ./.env
EXPOSE 3333
CMD npm start