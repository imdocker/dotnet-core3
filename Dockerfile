FROM mcr.microsoft.com/dotnet/core/runtime-deps:2.2-alpine3.9

# Install ASP.NET Core
ENV ASPNETCORE_VERSION 2.2.5
#Setup tzdata with zone info
ENV TZ=Europe/Moscow

RUN wget -O aspnetcore.tar.gz https://dotnetcli.blob.core.windows.net/dotnet/aspnetcore/Runtime/$ASPNETCORE_VERSION/aspnetcore-runtime-$ASPNETCORE_VERSION-linux-musl-x64.tar.gz \
    && aspnetcore_sha512='6dc1058c218a8ac70c4ea8ce0c62a0ce275374c282ff87fcac940c9e472297effaab94fb7e1738d68e61f1f021166e9f565e676a0a9ddcf2aeb0762144bf7b92' \
    && echo "$aspnetcore_sha512  aspnetcore.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf aspnetcore.tar.gz -C /usr/share/dotnet \
    && rm aspnetcore.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet \
    && apk add tzdata msttcorefonts-installer libgdiplus icu-libs curl mc --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
    && /usr/bin/update-ms-fonts && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
