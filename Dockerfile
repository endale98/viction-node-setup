# Use an appropriate base image
FROM ubuntu:20.04

# Install necessary runtime dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /viction

# Copy the tomo binary into the container
COPY victionchain/build/bin/tomo /usr/local/bin/tomo

# Ensure the binary is executable
RUN chmod +x /usr/local/bin/tomo

# Expose necessary ports
EXPOSE 10303 1545 1546

# Set the entrypoint to the tomo binary
ENTRYPOINT ["tomo"]