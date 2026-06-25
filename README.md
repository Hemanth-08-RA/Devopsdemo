# 🚀 DevOps Demo Playground

Welcome to the **DevOps Demo Playground**! This repository is a lightweight, hands-on learning environment designed to help you master the fundamentals of **Version Control (Git & GitHub)** and **Containerization (Docker)**.

Instead of running heavy web servers or complex local environments, this repository uses clear Markdown guides, command cheat sheets, and interactive CLI demo scripts that execute real scenarios locally on your machine.

---

## 📂 Repository Contents

The project is split into two core modules:

### 1. 🐳 [Docker Module](./Docker)
Learn containerization, image building, and container lifecycles.
* 📄 [**Docker Guide**](./Docker/README.md): Conceptual overview of Docker, standard container lifecycles, and a comparison table of containers vs. Virtual Machines (VMs).
* 📋 [**Docker Commands**](./Docker/commands.md): A clean reference sheet for common container, image, monitoring, and system cleanup commands.
* 🚀 [**Interactive Docker Demo**](./Docker/basic-demo/README.md): A step-by-step CLI script that checks your Docker daemon, writes a minimal `Dockerfile`, builds a local image, runs it, reads logs, and cleans up.

### 2. 🐙 [Git & GitHub Module](./Git-GitHub)
Learn local version control workflows and remote collaboration models.
* 📄 [**Git & GitHub Guide**](./Git-GitHub/README.md): Core concepts of local version control, the three stages of Git, branching/merging, and GitHub collaboration flows (fork, clone, PR).
* 📋 [**Git Commands**](./Git-GitHub/commands.md): A categorized cheat sheet for daily workflows, branching, syncing with remotes, and undoing mistakes.
* 🚀 [**Interactive Git Demo**](./Git-GitHub/basic-demo/README.md): A step-by-step CLI script that runs a full local Git cycle (init, add, commit, branch checkout, file isolation, merge, and visual logs).

---

## 🏃 Getting Started

To explore the interactive tutorials locally, clone this repository and run the demo scripts matching your operating system:

### 1. Version Control (Git) Demo:
```bash
# Move to the Git demo folder
cd Git-GitHub/basic-demo

# On Windows (PowerShell):
.\demo-script.ps1

# On Linux/macOS/Git Bash (Bash):
chmod +x demo-script.sh
./demo-script.sh
```

### 2. Containerization (Docker) Demo:
*(Requires Docker Desktop to be running)*
```bash
# Move to the Docker demo folder
cd Docker/basic-demo

# On Windows (PowerShell):
.\demo-script.ps1

# On Linux/macOS/Git Bash (Bash):
chmod +x demo-script.sh
./demo-script.sh
```

*Note: Press **ENTER** after reading each step to run the command and watch the lifecycle happen in real-time!*
