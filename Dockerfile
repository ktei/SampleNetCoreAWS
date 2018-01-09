FROM microsoft/dotnet:2.0.4-sdk-2.1.3 as builder

COPY . /app
WORKDIR /app
RUN ["dotnet", "restore", "--no-cache"]
RUN dotnet publish -c Release -r linux-x64

FROM microsoft/dotnet:2.0.4-runtime
WORKDIR /app
COPY --from=builder /app/bin/Release/netcoreapp2.0/publish .
EXPOSE 5000
ENTRYPOINT ["dotnet", "SampleNetCoreAWS.dll"]