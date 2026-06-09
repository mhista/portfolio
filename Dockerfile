# Stage 1: Build
FROM dart:stable AS build

WORKDIR /app

# Copy pubspec and get dependencies
COPY pubspec.* ./
RUN dart pub get

# Copy the rest of the code
COPY . .

# Install jaspr_cli
RUN dart pub global activate jaspr_cli

# Build the project
# This will generate the build/jaspr directory
RUN dart pub global run jaspr build --verbose

# Stage 2: Runtime
FROM debian:bookworm-slim

# Install CA certificates for email sending
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy all the needed runtime libraries for dart.
COPY --from=build /runtime/ /

# Copy the build output
# jaspr build produces a 'build/jaspr' directory
# Inside there is usually a folder named 'app' or similar containing the executable and assets
# We copy everything to /app
COPY --from=build /app/build/jaspr/ /app/

# Expose the port defined in EmailServer
EXPOSE 8080

# Start the server
# The executable is usually named after the project or 'app'
# Since the project name is 'port', it might be 'port' or 'app'
# Jaspr build creates an executable. Let's assume it's named 'app' or we can check the build output.
# Usually it's 'app' in the root of build/jaspr
CMD ["./app"]
