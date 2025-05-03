# Base Image
FROM fedora:latest

# Install base packages
RUN dnf install -y \
    git cmake neovim nano \
    sudo nano

RUN dnf group install -y \
    c-development development-tools

# Compile benchmark
RUN git clone https://github.com/google/benchmark.git /tmp/benchmark    
WORKDIR /tmp/benchmark
RUN cmake -E make_directory "build"
RUN cmake -E chdir "build" cmake -DBENCHMARK_DOWNLOAD_DEPENDENCIES=on -DCMAKE_BUILD_TYPE=Release ../
RUN cmake --build "build" --config Release
RUN cmake --build "build" --config Release --target install

# Cleanup
WORKDIR /root
RUN rm -rf /tmp/benchmark

# Entrypoint
CMD ["/bin/bash"]
