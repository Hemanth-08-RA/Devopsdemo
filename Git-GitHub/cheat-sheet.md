# 📋 Git & GitHub Cheat Sheet

A handy reference of the most frequently used Git commands.

---

## ⚙️ 1. Setup & Configuration
Configure user info for all local repositories.

```bash
# Set your name (appears in your commits)
git config --global user.name "Your Name"

# Set your email (must match your GitHub email)
git config --global user.email "your.email@example.com"

# Check your configuration settings
git config --list
```

---

## 📁 2. Starting a Repository
Create a new local repository or clone an existing one.

```bash
# Initialize a new Git repository in the current directory
git init

# Clone (download) a repository from GitHub to your computer
git clone <repository-url>
```

---

## 🔄 3. Basic Workflow (The Daily Cycle)
Track and record changes to your files.

```bash
# Check the status of your files (untracked, modified, staged)
git status

# Stage a specific file for the next commit
git add <filename>

# Stage ALL files (new, modified, and deleted)
git add .

# View differences between your working directory and staging area
git diff

# Commit your staged changes with a descriptive message
git commit -m "Describe what changes you made"

# View the project's commit history (press 'q' to exit)
git log

# View a simplified, one-line version of the commit history
git log --oneline
```

---

## 🌿 4. Branching & Merging
Manage multiple lines of development.

```bash
# List all local branches (current branch is marked with *)
git branch

# Create a new branch
git branch <branch-name>

# Switch to a specific branch
git checkout <branch-name>
# OR (modern Git):
git switch <branch-name>

# Create a new branch AND switch to it immediately
git checkout -b <branch-name>
# OR (modern Git):
git switch -c <branch-name>

# Merge a branch into your current branch (e.g., merge feature into main)
# 1. Switch to the target branch first:
git checkout main
# 2. Merge the source branch:
git merge <branch-name>

# Delete a branch (must switch to another branch first)
git branch -d <branch-name>
```

---

## ☁️ 5. Sharing & Syncing (GitHub)
Connect your local repository to a remote server like GitHub.

```bash
# Link your local repository to a remote repository on GitHub
git remote add origin <github-repo-url>

# Verify the remote repository links
git remote -v

# Push your local commits on 'main' branch to GitHub
git push -u origin main

# Pull (download and merge) the latest changes from GitHub
git pull origin main

# Fetch changes from GitHub without merging them automatically
git fetch origin
```

---

## ⏪ 6. Undoing Changes
Recover from mistakes safely.

```bash
# Discard changes in a file (revert it back to the last commit)
git checkout -- <filename>

# Unstage a file (keep the edits, but remove them from the staging area)
git reset HEAD <filename>

# Undo the last commit, but KEEP your changes in the working directory
git reset --soft HEAD~1

# Undo the last commit and DESTROY all changes (use with caution!)
git reset --hard HEAD~1

# Revert a commit (creates a new commit that does the exact opposite of a past commit)
git revert <commit-hash>
```

---

## 💡 Best Practices
1. **Commit Often, Commit Early**: Make small, logical commits rather than one massive commit at the end of the day.
2. **Write Meaningful Commit Messages**: Start with a verb (e.g., `Add user login validation`, `Fix navbar alignment`).
3. **Always Pull Before Pushing**: Ensure your local branch has the latest updates from GitHub to avoid conflicts.
4. **Never Work Directly on Main**: Always create a feature branch for your changes and merge them via a Pull Request on GitHub.
