# Use an official Ubuntu image as a parent image
FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    cmake \
    libuv1-dev \
    libssl-dev \
    libhwloc-dev \
    && rm -rf /var/lib/apt/lists/*

# Clone the XMRig repository
RUN git clone https://github.com/xmrig/xmrig.git /xmrig

# Set the working directory
WORKDIR /xmrig

# Build XMRig
RUN mkdir build && cd build && cmake .. && make -j$(nproc)

# Run XMRig
CMD ["./build/xmrig", "-o", "your_mining_pool_url", "-u", "your_wallet_address", "-p", "x"]