# This dockerfile is created in order to get all projects together.


# Build stage
FROM mcr.microsoft.com/dotnet/sdk:2.1 as build-env
WORKDIR /generator
# restore
COPY api/api.csproj ./api/
RUN dotnet restore api/api.csproj

COPY tests/tests.csproj ./tests/
RUN dotnet restore tests/tests.csproj

# RUN ls -alR
# We can first of all run "docker build -t testing ."
# then run "docker run --rm testing ls -alR" and we will see everything in teh container
# this is useful for adding files to .dockerignore

# copy src
COPY . .

# test
RUN dotnet test tests/tests.csproj

# publish
RUN dotnet publish api/api.csproj -o /publish


# Runtime stage
FROM mcr.microsoft.com/dotnet/core/aspnet:2.1
COPY --from=build-env /publish /publish
WORKDIR /publish
ENTRYPOINT [ "dotnet", "api.dll" ]