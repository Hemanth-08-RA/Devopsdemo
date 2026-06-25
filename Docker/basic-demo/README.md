# 🚀 Docker Local Workflow Demo

This directory contains automated scripts that simulate a real-world, step-by-step Docker workflow on your local machine.

By running these scripts, you can watch Docker check system status, generate a basic Dockerfile dynamically, build an image, run a container, display logs, and clean up.

---

## 🏃 Prerequisites
Make sure **Docker Desktop** (or the Docker daemon) is running on your machine.

---

## 🏃 How to Run the Demo

Choose the script that matches your operating system:

### Option A: Windows (PowerShell)
1. Open your terminal (PowerShell).
2. Navigate to this directory.
3. Run the script:
   ```powershell
   .\demo-script.ps1
   ```
   *(Note: If you get a policy execution error, run `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass` first, then run the script).*

### Option B: Linux / macOS / Git Bash (Bash)
1. Open your terminal.
2. Navigate to this directory.
3. Make the script executable:
   ```bash
   chmod +x demo-script.sh
   ```
4. Run the script:
   ```bash
   ./demo-script.sh
   ```

---

## 📋 What the Script Does

The script executes the following steps inside a temporary folder named `docker-sandbox/` (located right inside this directory):

1. **Daemon Verification**: Checks if the Docker daemon is active using `docker info`.
2. **Clean Start**: Deletes any leftover `docker-sandbox` folder, container, or image from previous runs.
3. **Dockerfile Generation**: Writes a minimal `Dockerfile` using the lightweight `alpine` base image.
4. **`docker build`**: Builds a local Docker image named `docker-sandbox-img`.
5. **Image Verification**: Runs `docker images` to show the newly built blueprint.
6. **`docker run`**: Spawns and starts a container named `sandbox-ctr` from the image.
7. **`docker logs`**: Fetches the logs of the container to read its greeting message.
8. **Container Inspection**: Runs `docker ps -a` to view the container state.
9. **Cleanup**: Asks if you want to keep the container/image to explore, or clean it up (`docker rm` and `docker rmi`).
