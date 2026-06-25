# 🐳 Dockerized Flask Environment Dashboard

A beautiful, dark-themed Docker demonstration application built with Python Flask, vanilla CSS, and modern responsive design. This project is ready to be built and run inside a Docker container.

## 🚀 Quick Start Guide

### Prerequisites
Make sure you have [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running on your machine.

### 1. Build the Docker Image
Run the following command in your terminal at the root of the project:
```bash
docker build -t flask-docker-demo .
```

### 2. Run the Container
Start the container and map port `8080` on your host machine to port `80` inside the container:
```bash
docker run -d -p 8080:80 flask-docker-demo
```

### 3. Access the App
Open your web browser and navigate to:
👉 **[http://localhost:8080](http://localhost:8080)**

---

## 📂 Project Structure

- `app.py`: The entry point and backend server handling routing and API info retrieval.
- `Dockerfile`: Instructions for Docker to build the image optimized with layer caching.
- `requirements.txt`: Python package dependencies.
- `templates/index.html`: The frontend user interface styled with Outfit and JetBrains Mono fonts, linear glow gradients, and modern dark mode styling.

---

## 🛠️ Docker Commands Cheat Sheet

- **Build**: `docker build -t flask-docker-demo .`
- **Run**: `docker run -d -p 8080:80 flask-docker-demo`
- **View Logs**: `docker logs -f <container-id>`
- **Stop**: `docker stop <container-id>`
- **Clean Up**: `docker system prune -a`
