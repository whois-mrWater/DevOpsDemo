# Sử dụng môi trường .NET SDK để Build code
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy file cấu hình và tải các thư viện cần thiết
COPY ["DevOpsDemo.slnx", "./"]
COPY ["MyApi/MyApi.csproj", "MyApi/"]
COPY ["MyApi.Tests/MyApi.Tests.csproj", "MyApi.Tests/"]
RUN dotnet restore

# Copy toàn bộ code còn lại và tiến hành đóng gói (Publish)
COPY . .
RUN dotnet publish "MyApi/MyApi.csproj" -c Release -o /app/publish

# Đưa bản đóng gói sang môi trường chạy (Runtime) cho nhẹ
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "MyApi.dll"]