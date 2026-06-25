#!/usr/bin/env bash

# Exit on error
set -e

# Parse arguments
AUTO_MODE=false
if [ "$1" = "--auto" ] || [ "$1" = "-a" ]; then
    AUTO_MODE=true
fi

# ANSI Color Codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Helper function to print headers
print_header() {
    echo -e "\n${BLUE}========================================================================${NC}"
    echo -e "${CYAN}$1${NC}"
    echo -e "${BLUE}========================================================================${NC}"
}

# Helper function to pause and wait for user input
press_enter_to_continue() {
    if [ "$AUTO_MODE" = true ]; then
        echo -e "\n------------------------------------------------------------------------"
        sleep 0.1
    else
        echo -e "\n${YELLOW}👉 Press [ENTER] to execute the next step...${NC}"
        read -r
    fi
}

clear

echo -e "${GREEN}"
echo "    ██████╗  ██████╗  ██████╗██╗  ██╗███████╗██████╗ "
echo "    ██╔══██╗██╔═══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗"
echo "    ██║  ██║██║   ██║██║     █████╔╝ █████╗  ██████╔╝"
echo "    ██║  ██║██║   ██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗"
echo "    ██████╔╝╚██████╔╝╚██████╗██║  ██╗███████╗██║  ██║"
echo "    ╚═════╝  ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝"
echo -e "${NC}"
echo -e "Welcome to the Docker Interactive Workflow simulator!\n"

# Verify Docker daemon is running
echo "Checking if Docker is running..."
if ! docker info >/dev/null 2>&1; then
    echo -e "${RED}❌ ERROR: Docker daemon is not running!${NC}"
    echo "Please make sure Docker Desktop is started and try again."
    exit 1
fi
echo -e "${GREEN}✓ Docker is running!${NC}"

# Define names
SANDBOX_DIR="docker-sandbox"
IMAGE_NAME="docker-sandbox-img"
CONTAINER_NAME="sandbox-ctr"

# Clean up leftover artifacts
echo "Performing initial cleanup of old sandbox containers and images..."
docker rm -f "$CONTAINER_NAME" >/dev/null 2>&1 || true
docker rmi -f "$IMAGE_NAME" >/dev/null 2>&1 || true
if [ -d "$SANDBOX_DIR" ]; then
    rm -rf "$SANDBOX_DIR"
fi

print_header "Step 1: Create a Sandbox Directory & Write a Dockerfile"
echo "We are creating a folder called '$SANDBOX_DIR' to keep our build files."
echo "Inside it, we will write a minimal 'Dockerfile' using the Alpine base image."

press_enter_to_continue

mkdir -p "$SANDBOX_DIR"
cat << 'EOF' > "$SANDBOX_DIR/Dockerfile"
# Use the ultra-lightweight alpine base image
FROM alpine:latest

# Run a command during container startup
CMD ["echo", "Hello! This message is printed from inside your isolated Docker container!"]
EOF

echo -e "\n${GREEN}✓ Dockerfile successfully created!${NC} Here is the content of '$SANDBOX_DIR/Dockerfile':"
echo -e "${YELLOW}"
cat "$SANDBOX_DIR/Dockerfile"
echo -e "${NC}"

print_header "Step 2: Build the Docker Image"
echo "We will compile the recipe (Dockerfile) into a read-only Docker Image."
echo "Command:"
echo -e "  ${GREEN}docker build -t $IMAGE_NAME $SANDBOX_DIR${NC}"

press_enter_to_continue

echo -e "\nRunning: ${CYAN}docker build -t $IMAGE_NAME $SANDBOX_DIR${NC}"
docker build -t "$IMAGE_NAME" "$SANDBOX_DIR"

echo -e "\n${GREEN}✓ Docker Image '$IMAGE_NAME' successfully built!${NC}"

print_header "Step 3: List Local Docker Images"
echo "Let's check if our newly built image is registered in our local registry."
echo "Command:"
echo -e "  ${GREEN}docker images${NC}"

press_enter_to_continue

echo -e "\nRunning: ${CYAN}docker images${NC}"
docker images | grep "$IMAGE_NAME" || docker images | head -n 5

echo -e "\n${YELLOW}Explanation:${NC}"
echo "You should see '$IMAGE_NAME' listed along with its size (typically only ~8MB thanks to Alpine!)."

print_header "Step 4: Run the Docker Container"
echo "We will run a container instance named '$CONTAINER_NAME' from our image."
echo "Command:"
echo -e "  ${GREEN}docker run --name $CONTAINER_NAME $IMAGE_NAME${NC}"

press_enter_to_continue

echo -e "\nRunning: ${CYAN}docker run --name $CONTAINER_NAME $IMAGE_NAME${NC}"
docker run --name "$CONTAINER_NAME" "$IMAGE_NAME"

echo -e "\n${YELLOW}Explanation:${NC}"
echo "The container ran, printed the CMD echo statement to the console, and exited because the process finished."

print_header "Step 5: View the Container Logs"
echo "Even if a container has stopped, you can retrieve its console outputs."
echo "Command:"
echo -e "  ${GREEN}docker logs $CONTAINER_NAME${NC}"

press_enter_to_continue

echo -e "\nRunning: ${CYAN}docker logs $CONTAINER_NAME${NC}"
docker logs "$CONTAINER_NAME"

print_header "Step 6: List All Containers (Running and Stopped)"
echo "Since our container is stopped, running plain 'docker ps' won't show it."
echo "We must run 'docker ps -a' to see all container histories."
echo "Command:"
echo -e "  ${GREEN}docker ps -a${NC}"

press_enter_to_continue

echo -e "\nRunning: ${CYAN}docker ps -a${NC}"
docker ps -a | grep "$CONTAINER_NAME" || docker ps -a | head -n 5

print_header "Step 7: Clean Up Sandbox Containers & Images"
echo "It's best practice to delete containers and images you no longer need to free space."
echo "Commands:"
echo -e "  ${GREEN}docker rm $CONTAINER_NAME${NC}"
echo -e "  ${GREEN}docker rmi $IMAGE_NAME${NC}"

press_enter_to_continue

if [ "$AUTO_MODE" = true ]; then
    echo -e "\nRunning automatic cleanup..."
    docker rm "$CONTAINER_NAME"
    docker rmi "$IMAGE_NAME"
    rm -rf "$SANDBOX_DIR"
    echo -e "${GREEN}✓ Cleanup complete! Sandbox directory, container, and image removed.${NC}"
else
    echo -e "\nWould you like to keep the container and image to inspect them?"
    echo -n "Type 'y' to keep, or any other key to clean them up: "
    read -r KEEP_DOCKER

    if [ "$KEEP_DOCKER" != "y" ] && [ "$KEEP_DOCKER" != "Y" ]; then
        echo -e "\n${YELLOW}Cleaning up local artifacts...${NC}"
        docker rm "$CONTAINER_NAME"
        docker rmi "$IMAGE_NAME"
        rm -rf "$SANDBOX_DIR"
        echo -e "${GREEN}✓ Cleanup complete. Clean exit!${NC}"
    else
        echo -e "${GREEN}✓ Docker artifacts preserved!${NC}"
        echo "- Sandbox directory: $(pwd)/$SANDBOX_DIR"
        echo "- Image Name: $IMAGE_NAME"
        echo "- Container Name: $CONTAINER_NAME"
        echo "You can now run your own CLI commands like: 'docker inspect $CONTAINER_NAME'"
    fi
fi
print_header "🎉 Docker Demo Complete!"
