# Use Ubuntu as the base image
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip3 install --upgrade pip && \
    pip3 install jupyterlab && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create the 'julien' user with root privileges
RUN useradd -m -s /bin/bash julien && \
    echo "julien:password" | chpasswd && \
    usermod -aG root julien

# Switch to the 'julien' user
USER julien

RUN jupyter lab --generate-config

# Set the password for JupyterLab
RUN echo "c.ServerApp.password = 'sha1:5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8'" > /home/julien/.jupyter/jupyter_lab_config.py

# Install Jupyter Lab and Python packages
WORKDIR /home/julien

RUN mkdir /home/julien/host

COPY requirements.txt .

RUN pip3 install --no-cache-dir -r requirements.txt 

# Expose port 8000 for Jupyter Lab
EXPOSE 8000

# Entrypoint to keep JupyterLab in the foreground
ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--port=8000", "--no-browser", "--notebook-dir=/home/julien"]