param(
    [switch]$Auto
)

# PowerShell Script for Docker Interactive Workflow Simulator

# Set encoding to UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

# Color mapping
function Write-Header ($text) {
    Write-Host "`n========================================================================" -ForegroundColor Blue
    Write-Host $text -ForegroundColor Cyan
    Write-Host "========================================================================" -ForegroundColor Blue
}

function Write-Explanation ($text) {
    Write-Host "`n[Explanation]" -ForegroundColor Yellow -NoNewline
    Write-Host " $text"
}

function Write-Command ($text) {
    Write-Host "  $text" -ForegroundColor Green
}

function Write-Action ($text) {
    Write-Host "`nRunning: $text" -ForegroundColor DarkCyan
}

function Write-Success ($text) {
    Write-Host "`n[OK] $text" -ForegroundColor Green
}

function Read-Enter {
    if ($Auto) {
        Write-Host "`n------------------------------------------------------------------------" -ForegroundColor Gray
        Start-Sleep -Milliseconds 100
    } else {
        Write-Host "`n-> Press [ENTER] to execute the next step..." -ForegroundColor Yellow -NoNewline
        [void](Read-Host)
    }
}

Clear-Host

Write-Host "====================================================" -ForegroundColor Green
Write-Host "      DOCKER INTERACTIVE WORKFLOW SIMULATOR         " -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Green

Write-Host "`nWelcome to the Docker Interactive Workflow simulator!`n"

# Verify Docker daemon is running
Write-Host "Checking if Docker is running..."
& docker info >$null 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ ERROR: Docker daemon is not running!" -ForegroundColor Red
    Write-Host "Please make sure Docker Desktop is started and try again."
    Exit 1
}
Write-Success "Docker is running!"

# Define names
$SandboxDir = "docker-sandbox"
$ImageName = "docker-sandbox-img"
$ContainerName = "sandbox-ctr"

# Clean up leftover artifacts
Write-Host "Performing initial cleanup of old sandbox containers and images..." -ForegroundColor Yellow
& docker rm -f $ContainerName >$null 2>&1
& docker rmi -f $ImageName >$null 2>&1
if (Test-Path $SandboxDir) {
    Remove-Item -Recurse -Force $SandboxDir
}

Write-Header "Step 1: Create a Sandbox Directory & Write a Dockerfile"
Write-Host "We are creating a folder called '$SandboxDir' to keep our build files."
Write-Host "Inside it, we will write a minimal 'Dockerfile' using the Alpine base image."

Read-Enter

New-Item -ItemType Directory -Path $SandboxDir | Out-Null
@"
# Use the ultra-lightweight alpine base image
FROM alpine:latest

# Run a command during container startup
CMD ["echo", "Hello! This message is printed from inside your isolated Docker container!"]
"@ | Out-File -FilePath "$SandboxDir/Dockerfile" -Encoding ascii

Write-Success "Dockerfile successfully created! Content of '$SandboxDir/Dockerfile':"
Write-Host (Get-Content "$SandboxDir/Dockerfile" -Raw) -ForegroundColor Yellow

Write-Header "Step 2: Build the Docker Image"
Write-Host "We will compile the recipe (Dockerfile) into a read-only Docker Image."
Write-Host "Command:"
Write-Command "docker build -t $ImageName $SandboxDir"

Read-Enter

Write-Action "docker build -t $ImageName $SandboxDir"
& docker build -t $ImageName $SandboxDir

Write-Success "Docker Image '$ImageName' successfully built!"

Write-Header "Step 3: List Local Docker Images"
Write-Host "Let's check if our newly built image is registered in our local registry."
Write-Host "Command:"
Write-Command "docker images"

Read-Enter

Write-Action "docker images"
& docker images | Select-String $ImageName

Write-Explanation "You should see '$ImageName' listed along with its size (typically only ~8MB thanks to Alpine!)."

Write-Header "Step 4: Run the Docker Container"
Write-Host "We will run a container instance named '$ContainerName' from our image."
Write-Host "Command:"
Write-Command "docker run --name $ContainerName $ImageName"

Read-Enter

Write-Action "docker run --name $ContainerName $ImageName"
& docker run --name $ContainerName $ImageName

Write-Explanation "The container ran, printed the CMD echo statement to the console, and exited because the process finished."

Write-Header "Step 5: View the Container Logs"
Write-Host "Even if a container has stopped, you can retrieve its console outputs."
Write-Host "Command:"
Write-Command "docker logs $ContainerName"

Read-Enter

Write-Action "docker logs $ContainerName"
& docker logs $ContainerName

Write-Header "Step 6: List All Containers (Running and Stopped)"
Write-Host "Since our container is stopped, running plain 'docker ps' won't show it."
Write-Host "We must run 'docker ps -a' to see all container histories."
Write-Host "Command:"
Write-Command "docker ps -a"

Read-Enter

Write-Action "docker ps -a"
& docker ps -a | Select-String $ContainerName

Write-Header "Step 7: Clean Up Sandbox Containers & Images"
Write-Host "It's best practice to delete containers and images you no longer need to free space."
Write-Host "Commands:"
Write-Command "docker rm $ContainerName"
Write-Command "docker rmi $ImageName"

Read-Enter

if ($Auto) {
    Write-Host "`nRunning automatic cleanup..." -ForegroundColor Yellow
    & docker rm $ContainerName | Out-Null
    & docker rmi $ImageName | Out-Null
    Remove-Item -Recurse -Force $SandboxDir
    Write-Success "Cleanup complete! Sandbox directory, container, and image removed."
} else {
    $Keep = Read-Host "`nWould you like to keep the container and image to inspect them? (y/n)"
    if ($Keep -ne "y" -and $Keep -ne "Y") {
        Write-Host "`nCleaning up local artifacts..." -ForegroundColor Yellow
        & docker rm $ContainerName | Out-Null
        & docker rmi $ImageName | Out-Null
        Remove-Item -Recurse -Force $SandboxDir
        Write-Success "Cleanup complete. Clean exit!"
    } else {
        Write-Success "Docker artifacts preserved!"
        Write-Host "- Sandbox directory: $((Get-Location).Path)\$SandboxDir"
        Write-Host "- Image Name: $ImageName"
        Write-Host "- Container Name: $ContainerName"
        Write-Host "You can now run your own CLI commands like: 'docker inspect $ContainerName'"
    }
}

Write-Header "Docker Demo Complete!"
