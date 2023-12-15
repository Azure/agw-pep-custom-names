FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

RUN apt-get update && apt-get install -y curl && apt-get install -y ca-certificates
ADD ./modules/app_gateway/certs/contoso.corp.ca.crt /usr/local/share/ca-certificates/contoso.corp.ca.crt
RUN chmod 644 /usr/local/share/ca-certificates/contoso.corp.ca.crt && update-ca-certificates
RUN wget -O /usr/local/share/ca-certificates/BaltimoreCyberTrustRoot.crt https://www.digicert.com/CACerts/BaltimoreCyberTrustRoot.crt.pem \
    && wget -O /usr/local/share/ca-certificates/DigiCertGlobalRootCA.crt https://www.digicert.com/CACerts/DigiCertGlobalRootCA.crt.pem \
    && chmod 644 /usr/local/share/ca-certificates/BaltimoreCyberTrustRoot.crt \
    && chmod 644 /usr/local/share/ca-certificates/DigiCertGlobalRootCA.crt \
    && update-ca-certificates

WORKDIR /src
COPY "./tests/Aurora.Tests.csproj" .
RUN dotnet restore Aurora.Tests.csproj

COPY ./tests/ .
RUN chmod +x ./scripts/run.sh
RUN dotnet build Aurora.Tests.csproj -c Release
ENTRYPOINT ["./scripts/run.sh"]