#! /bin/sh
dotnet test -c Release --no-build -l "trx;LogFileName=TestResults.trx"
cat ./TestResults/TestResults.trx
sleep 3600
