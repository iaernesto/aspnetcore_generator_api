# This file was created to implement sdk stage 0 and then runtime stage 1

# stage 0 build---------------------------------
FROM mcr.microsoft.com/dotnet/sdk:2.1 as build-env

WORKDIR /api
COPY api.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -o /publish
# end stage 0 -----------------------------

# stage 1 runtime---------------------------------
FROM mcr.microsoft.com/dotnet/core/aspnet:2.1

# we need to change our working directory to publish folder so 
# when running docker run --rm -it ........ we will read "Content root path: /publish"
WORKDIR /publish

# COPY from .... /sourcefile   to /newfile, in this case is also /publish
# but we are already in publish because of the command WORKDIR, so we
# can put just dot (.)
COPY --from=build-env /publish .

ENTRYPOINT ["dotnet", "api.dll"]


# end stage 1 ----------------------------
# we run the command to build: docker build -t aspnetcore/generator:multi .
# we run the command to spinnig it up: docker run --rm -it -p 8080:80 aspnetcore/generator:multi
# we open localhost:8080/swagger


