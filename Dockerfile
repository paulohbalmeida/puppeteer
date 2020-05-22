FROM alpine:edge

# Installs latest Chromium (77) package.

RUN apk add --no-cache \
      chromium \
      nss \
      freetype \
      freetype-dev \
      harfbuzz \
      ca-certificates \
      ttf-freefont \
      nodejs \
      npm \
      yarn

# Install latest chrome dev package and fonts to support major charsets (Chinese, Japanese, Arabic, Hebrew, Thai and a few others)

# Note: this installs the necessary libs to make the bundled version of Chromium that Puppeteer

# installs, work.

# RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \

#     && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \

#     && apt-get update \

#     && apt-get install -y google-chrome-unstable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf \

#       --no-install-recommends \

#     && rm -rf /var/lib/apt/lists/*

WORKDIR /var/opt/mof

ADD . /var/opt/mof

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# Puppeteer v1.19.0 works with Chromium 77.

# RUN yarn add puppeteer

RUN npm i puppeteer 
RUN npm install pm2 -g
RUN npm install

# Run everything after as non-privileged user.

# USER pptruser


ENV CONTEXT_PATH=/mof
ENV PORT=3939
ENV NODE_ENV=production
EXPOSE 3939

CMD [ "pm2-docker" ]

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
