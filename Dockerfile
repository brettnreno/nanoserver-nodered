FROM mcr.microsoft.com/windows/nanoserver:ltsc2019 as build

WORKDIR tmp
ADD https://nodejs.org/dist/v21.2.0/node-v21.2.0-win-x64.zip node-v21.2.0-win-x64.zip
RUN tar -xvf node-v21.2.0-win-x64.zip
RUN del node-v21.2.0-win-x64.zip

FROM mcr.microsoft.com/windows/nanoserver:ltsc2019
COPY --from=build /tmp/node-v21.2.0-win-x64 /nodejs
WORKDIR nodejs
RUN npm config set registry https://registry.npmjs.org/


CMD [ "node.exe" ]
RUN npm install -g --unsafe-perm node-red
CMD node-red
