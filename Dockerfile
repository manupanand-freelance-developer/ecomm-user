FROM docker.io/redhat/ubi9-minimal:latest

# Install dependencies
RUN microdnf install -y tar xz 

# Install Node.js v22.14.0
RUN cd /opt && \
    curl -LO https://nodejs.org/dist/v22.16.0/node-v22.16.0-linux-arm64.tar.xz && \
    tar -xJf node-v22.16.0-linux-arm64.tar.xz && \
    rm node-v22.16.0-linux-arm64.tar.xz


# Add Node.js to PATH
ENV PATH="/opt/node-v22.16.0-linux-arm64/bin:$PATH"

# Create app directory
WORKDIR /app

# Copy application files
COPY package.json server.js run.sh ./

# Make run.sh executable (important!)
RUN chmod +x run.sh

# Install Node.js dependencies
RUN npm install

# Start the app using run.sh
ENTRYPOINT [ "bash", "./run.sh" ]
