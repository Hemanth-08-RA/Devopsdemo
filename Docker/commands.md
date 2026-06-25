# 📋 Docker Commands

A handy reference of the most frequently used Docker CLI commands.

---

## 💿 1. Working with Images
Images are the read-only blueprints used to build containers.

```bash
# Build an image from a Dockerfile in the current directory
docker build -t <image-name> .

# List all locally available Docker images
docker images

# Delete a local image
docker rmi <image-name>

# Pull an image from Docker Hub (without running it)
docker pull <image-name>
```

---

## 🚀 2. Container Lifecycle
Containers are running instances of images.

```bash
# Run a container from an image (runs in foreground by default)
docker run <image-name>

# Run a container in detached mode (in the background)
docker run -d <image-name>

# Run a container, publish ports, and give it a custom name
# (Maps host port 8080 to container port 80)
docker run -d -p 8080:80 --name <container-name> <image-name>

# List all RUNNING containers
docker ps

# List ALL containers (both running and stopped)
docker ps -a

# Stop a running container
docker stop <container-id-or-name>

# Start a stopped container
docker start <container-id-or-name>

# Restart a container
docker restart <container-id-or-name>

# Delete a stopped container
docker rm <container-id-or-name>

# Stop AND delete a running container (force deletion)
docker rm -f <container-id-or-name>
```

---

## 🔎 3. Monitoring & Debugging
Inspect running containers to troubleshoot issues.

```bash
# View the console output (logs) of a container
docker logs <container-id-or-name>

# Stream logs in real-time (follow mode)
docker logs -f <container-id-or-name>

# Open an interactive shell terminal INSIDE a running container
docker exec -it <container-id-or-name> sh
# OR (if bash is available):
docker exec -it <container-id-or-name> bash

# View detailed JSON configuration of an image or container
docker inspect <name-or-id>
```

---

## 🧹 4. System Maintenance & Cleanup
Remove unused files to free up disk space.

```bash
# Delete all STOPPED containers
docker container prune

# Delete all UNUSED images
docker image prune

# Delete all stopped containers, unused networks, and dangling build cache
docker system prune

# Delete EVERYTHING unused (stopped containers, unused images, volumes, cache)
docker system prune -a --volumes
```

---

## 💡 Best Practices
1. **Use `.dockerignore`**: Create a `.dockerignore` file to prevent copying unnecessary files (like `node_modules`, `.git`, or temporary logs) into your image to keep size small.
2. **Keep Images Light**: Use minimal base images (like `alpine` or `-slim` variants) to reduce build times and deployment sizes.
3. **One Process Per Container**: Design your containers to perform a single role (e.g., one container for the database, one for the backend API, and one for the frontend server).
4. **Use Environment Variables**: Never hardcode sensitive secrets or configuration URLs in your Dockerfile. Pass them at runtime using `docker run -e MY_SECRET=xyz ...`.
