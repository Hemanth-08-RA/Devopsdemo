# 🚀 Git Local Workflow Demo

This directory contains automated scripts that simulate a real-world, step-by-step Git workflow on your local machine. 

By running these scripts, you can watch Git initialize a repository, stage files, make commits, create branches, and merge code, printing out what each step does in the console.

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

The script executes the following steps inside a temporary folder named `git-sandbox/` (located right inside this directory):

1. **Clean Start**: Deletes any existing `git-sandbox/` directory to ensure a clean state.
2. **`git init`**: Initializes a brand-new Git repository.
3. **First Stage & Commit**: Creates a `README.md` file, stages it with `git add`, and commits it as the initial commit.
4. **Second Commit**: Appends a new line to `README.md` and commits it to see how history builds on the `main` branch.
5. **Branching (`git checkout -b`)**: Creates and switches to a new branch called `feature/awesome-ui`.
6. **Feature Commit**: Creates a new file `styles.css` representing UI work, stages, and commits it on the feature branch.
7. **Switching back (`git checkout main`)**: Switches back to the `main` branch (demonstrating how `styles.css` vanishes from the folder because it only exists in the feature branch).
8. **Merging (`git merge`)**: Integrates `feature/awesome-ui` into `main`, bringing `styles.css` back.
9. **Final Inspection**: Displays the final status and a visual commit graph using `git log --graph --oneline`.
10. **Cleanup**: Asks if you want to keep the `git-sandbox/` folder to explore it yourself, or clean it up.
