#! /bin/sh
dotnet test Aurora.Tests.csproj -c Release --no-build -l "trx;LogFileName=TestResults.trx"
cat ./TestResults/TestResults.trx
sleep 3600
