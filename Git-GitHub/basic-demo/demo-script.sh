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
echo "    ██████╗ ██╗████████╗    ██████╗ ███████╗███╗   ███╗ ██████╗ "
echo "   ██╔════╝ ██║╚══██╔══╝    ██╔══██╗██╔════╝████╗ ████║██╔═══██╗"
echo "   ██║  ███╗██║   ██║       ██║  ██║█████╗  ██╔████╔██║██║   ██║"
echo "   ██║   ██║██║   ██║       ██║  ██║██╔══╝  ██║╚██╔╝██║██║   ██║"
echo "   ╚██████╔╝██║   ██║       ██████╔╝███████╗██║ ╚═╝ ██║╚██████╔╝"
echo "    ╚═════╝ ╚═╝   ╚═╝       ╚═════╝ ╚══════╝╚═╝     ╚═╝ ╚═════╝ "
echo -e "${NC}"
echo -e "Welcome to the Git Interactive Workflow simulator!\n"

# 1. Clean up sandbox
SANDBOX_DIR="git-sandbox"
if [ -d "$SANDBOX_DIR" ]; then
    echo -e "${YELLOW}Cleaning up existing sandbox directory...${NC}"
    rm -rf "$SANDBOX_DIR"
fi

print_header "Step 1: Create a Sandbox Directory & Initialize Git"
echo "We are creating a new folder called '$SANDBOX_DIR' and moving into it."
echo "Command to initialize a Git repository:"
echo -e "  ${GREEN}git init${NC}"

press_enter_to_continue

mkdir -p "$SANDBOX_DIR"
cd "$SANDBOX_DIR"
git init

# Configure local git user for the sandbox in case global config is missing
git config user.name "Git Demo Student"
git config user.email "student@devopsdemo.internal"

echo -e "\n${GREEN}✓ Git repository successfully initialized!${NC}"
echo "If you look inside the directory, Git has created a hidden '.git' folder."
echo "This hidden folder is where Git keeps all configuration and file history."

print_header "Step 2: Create a File and Check Git Status"
echo "We will create a simple README.md file in our workspace."
echo "Then we will check the state of our project using:"
echo -e "  ${GREEN}git status${NC}"

press_enter_to_continue

echo "# My Awesome DevOps Project" > README.md
echo "This project demonstrates the core elements of Git and GitHub." >> README.md

echo -e "\nRunning: ${CYAN}git status${NC}"
git status

echo -e "\n${YELLOW}Explanation:${NC}"
echo "Notice that README.md is listed in RED as 'untracked'. This is Stage 1 (Working Directory)."
echo "Git knows the file exists but isn't watching it for changes yet."

print_header "Step 3: Stage the File (Add to Index)"
echo "To tell Git we want to include README.md in our next snapshot, we must stage it."
echo "Command:"
echo -e "  ${GREEN}git add README.md${NC}"

press_enter_to_continue

echo -e "\nRunning: ${CYAN}git add README.md${NC}"
git add README.md

echo -e "\nRunning: ${CYAN}git status${NC}"
git status

echo -e "\n${YELLOW}Explanation:${NC}"
echo "README.md is now listed in GREEN under 'Changes to be committed'."
echo "This is Stage 2 (Staging Area). It is now ready to be permanently saved."

print_header "Step 4: Commit Your First Snapshot"
echo "To permanently save the staged files to our Git history, we create a commit."
echo "Command:"
echo -e "  ${GREEN}git commit -m \"Initial commit: Add project documentation\"${NC}"

press_enter_to_continue

echo -e "\nRunning: ${CYAN}git commit -m \"Initial commit: Add project documentation\"${NC}"
git commit -m "Initial commit: Add project documentation"
git branch -M main

echo -e "\nRunning: ${CYAN}git status${NC}"
git status

echo -e "\n${YELLOW}Explanation:${NC}"
echo "The working tree is now clean! The changes are saved in Stage 3 (Local Repository)."

print_header "Step 5: View History and Make a Second Change"
echo "Let's view our project log using:"
echo -e "  ${GREEN}git log --oneline${NC}"
echo "Then, we'll append a line to README.md and commit the updates."

press_enter_to_continue

echo -e "\nRunning: ${CYAN}git log --oneline${NC}"
git log --oneline

echo -e "\nAdding new changes..."
echo "Adding a new line of text..."
echo "Last Updated: $(date)" >> README.md

echo -e "\nRunning: ${CYAN}git status${NC}"
git status

echo -e "\nRunning: ${CYAN}git diff${NC} (to view the line modifications)"
git diff

echo -e "\nStaging and committing new changes..."
git add README.md
git commit -m "docs: Update README with last update timestamp"

echo -e "\nRunning: ${CYAN}git log --oneline${NC}"
git log --oneline

print_header "Step 6: Branching (Create 'feature/awesome-ui')"
echo "Instead of working directly on 'main', we'll create an isolated branch."
echo "Command to create and switch to a branch:"
echo -e "  ${GREEN}git checkout -b feature/awesome-ui${NC}"

press_enter_to_continue

echo -e "\nRunning: ${CYAN}git checkout -b feature/awesome-ui${NC}"
git checkout -b feature/awesome-ui

echo -e "\nRunning: ${CYAN}git branch${NC} (lists all branches, asterisk marks active)"
git branch

print_header "Step 7: Add Feature Code on our Branch"
echo "We will create a stylesheet file named 'styles.css' and commit it."
echo "This file will only exist on our feature branch for now."

press_enter_to_continue

echo "body { background-color: #121212; color: #ffffff; font-family: sans-serif; }" > styles.css
echo -e "\nStaging and committing 'styles.css' on branch 'feature/awesome-ui'..."
git add styles.css
git commit -m "feat: Add dark-mode styles sheet"

echo -e "\nListing directory files on 'feature/awesome-ui':"
ls -la

print_header "Step 8: Switch back to 'main' & See the Magic"
echo "Now we switch back to the 'main' branch."
echo "Command:"
echo -e "  ${GREEN}git checkout main${NC}"
echo "Watch what happens to the files in the directory!"

press_enter_to_continue

echo -e "\nRunning: ${CYAN}git checkout main${NC}"
git checkout main

echo -e "\nListing directory files on 'main':"
ls -la

echo -e "\n${YELLOW}Explanation:${NC}"
echo "Notice that 'styles.css' is GONE! That's because it was created on 'feature/awesome-ui'."
echo "Git safely isolates files based on the branch you are currently on."

print_header "Step 9: Merge the Feature branch into 'main'"
echo "Now that the feature is ready, we merge it into the 'main' branch."
echo "Command:"
echo -e "  ${GREEN}git merge feature/awesome-ui${NC}"

press_enter_to_continue

echo -e "\nRunning: ${CYAN}git merge feature/awesome-ui${NC}"
git merge feature/awesome-ui

echo -e "\nListing directory files on 'main' after merge:"
ls -la

echo -e "\n${GREEN}✓ Merge successful!${NC} 'styles.css' has been merged into main."

print_header "Step 10: Final Visual Graph History"
echo "We can look at the commit tree to see how our branches diverged and merged:"
echo -e "  ${GREEN}git log --graph --oneline --all${NC}"

press_enter_to_continue

echo -e "\nRunning: ${CYAN}git log --graph --oneline --all${NC}"
git log --graph --oneline --all

# Return to original directory
cd ..

print_header "🎉 Demo Complete!"
echo "You have successfully navigated a full Git cycle!"
echo -e "1. ${GREEN}git init${NC} (Created repository)"
echo -e "2. ${GREEN}git status${NC} (Checked files status)"
echo -e "3. ${GREEN}git add${NC} (Staged files)"
echo -e "4. ${GREEN}git commit${NC} (Saved snapshot)"
echo -e "5. ${GREEN}git checkout -b${NC} (Created feature branch)"
echo -e "6. ${GREEN}git merge${NC} (Integrated features back to main)"

if [ "$AUTO_MODE" = true ]; then
    echo -e "\n${YELLOW}Cleaning up '$SANDBOX_DIR' folder (Auto-mode)...${NC}"
    rm -rf "$SANDBOX_DIR"
    echo -e "${GREEN}Sandbox deleted. Clean exit!${NC}"
else
    echo -e "\nWould you like to keep the '$SANDBOX_DIR' folder to explore it yourself?"
    echo -n "Type 'y' to keep, or any other key to clean it up: "
    read -r KEEP_SANDBOX

    if [ "$KEEP_SANDBOX" != "y" ] && [ "$KEEP_SANDBOX" != "Y" ]; then
        echo -e "${YELLOW}Cleaning up '$SANDBOX_DIR' folder...${NC}"
        rm -rf "$SANDBOX_DIR"
        echo -e "${GREEN}Sandbox deleted. Clean exit!${NC}"
    else
        echo -e "${GREEN}Sandbox preserved at: $(pwd)/$SANDBOX_DIR${NC}"
        echo "You can open your terminal, go into that directory, and run your own Git commands!"
    fi
fi
