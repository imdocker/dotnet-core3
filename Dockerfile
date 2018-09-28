FROM microsoft/dotnet:2.1-runtime-deps-alpine3.7

# Install ASP.NET Core
ENV ASPNETCORE_VERSION 2.1.4

RUN apk add --no-cache --virtual .build-deps \
        openssl \
    && apk upgrade apk --no-cache \
    && wget -O aspnetcore.tar.gz https://dotnetcli.blob.core.windows.net/dotnet/aspnetcore/Runtime/$ASPNETCORE_VERSION/aspnetcore-runtime-$ASPNETCORE_VERSION-linux-musl-x64.tar.gz \
    && aspnetcore_sha512='173168730d6fe23a7c5457ed5533e4dc103a2f95ae5c0118a3ac4fd06ad23a1bd5a605bd43b10148cf8bcfc3a5b4c32d78b8d745dd5ba57921449a236f2c8ad8' \
    && echo "$aspnetcore_sha512  aspnetcore.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf aspnetcore.tar.gz -C /usr/share/dotnet \
    && rm aspnetcore.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet \
    && apk del .build-deps
