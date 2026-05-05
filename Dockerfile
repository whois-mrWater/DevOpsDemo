# Sử dụng môi trường .NET SDK để Build code
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy chỉ các file csproj vào đúng thư mục của nó
COPY ["MyApi/MyApi.csproj", "MyApi/"]
COPY ["MyApi.Tests/MyApi.Tests.csproj", "MyApi.Tests/"]

# Tải thư viện trực tiếp từ các file csproj (Bỏ qua sln)
RUN dotnet restore "MyApi/MyApi.csproj"
RUN dotnet restore "MyApi.Tests/MyApi.Tests.csproj"

# Copy toàn bộ code còn lại và tiến hành đóng gói (Publish)
COPY . .
RUN dotnet publish "MyApi/MyApi.csproj" -c Release -o /app/publish

# Đưa bản đóng gói sang môi trường chạy (Runtime) cho nhẹ
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "MyApi.dll"]