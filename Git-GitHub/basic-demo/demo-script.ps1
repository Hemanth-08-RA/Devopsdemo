param(
    [switch]$Auto
)

# PowerShell Script for Git Interactive Workflow Simulator

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
Write-Host "       GIT INTERACTIVE WORKFLOW SIMULATOR           " -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Green

Write-Host "`nWelcome to the Git Interactive Workflow simulator!`n"

# 1. Clean up sandbox
$SandboxDir = "git-sandbox"
if (Test-Path $SandboxDir) {
    Write-Host "Cleaning up existing sandbox directory..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $SandboxDir
}

Write-Header "Step 1: Create a Sandbox Directory & Initialize Git"
Write-Host "We are creating a new folder called '$SandboxDir' and moving into it."
Write-Host "Command to initialize a Git repository:"
Write-Command "git init"

Read-Enter

New-Item -ItemType Directory -Path $SandboxDir | Out-Null
Set-Location $SandboxDir
git init

# Configure local git user for the sandbox in case global config is missing
git config user.name "Git Demo Student"
git config user.email "student@devopsdemo.internal"

Write-Success "Git repository successfully initialized!"
Write-Host "If you look inside the directory, Git has created a hidden '.git' folder."
Write-Host "This hidden folder is where Git keeps all configuration and file history."

Write-Header "Step 2: Create a File and Check Git Status"
Write-Host "We will create a simple README.md file in our workspace."
Write-Host "Then we will check the state of our project using:"
Write-Command "git status"

Read-Enter

"# My Awesome DevOps Project`r`nThis project demonstrates the core elements of Git and GitHub." | Out-File -FilePath README.md -Encoding utf8

Write-Action "git status"
git status

Write-Explanation "Notice that README.md is listed in RED as 'untracked'. This is Stage 1 (Working Directory)."
Write-Host "Git knows the file exists but isn't watching it for changes yet."

Write-Header "Step 3: Stage the File (Add to Index)"
Write-Host "To tell Git we want to include README.md in our next snapshot, we must stage it."
Write-Host "Command:"
Write-Command "git add README.md"

Read-Enter

Write-Action "git add README.md"
git add README.md

Write-Action "git status"
git status

Write-Explanation "README.md is now listed in GREEN under 'Changes to be committed'."
Write-Host "This is Stage 2 (Staging Area). It is now ready to be permanently saved."

Write-Header "Step 4: Commit Your First Snapshot"
Write-Host "To permanently save the staged files to our Git history, we create a commit."
Write-Host "Command:"
Write-Command 'git commit -m "Initial commit: Add project documentation"'

Read-Enter

Write-Action 'git commit -m "Initial commit: Add project documentation"'
git commit -m "Initial commit: Add project documentation"
git branch -M main

Write-Action "git status"
git status

Write-Explanation "The working tree is now clean! The changes are saved in Stage 3 (Local Repository)."

Write-Header "Step 5: View History and Make a Second Change"
Write-Host "Let's view our project log using:"
Write-Command "git log --oneline"
Write-Host "Then, we'll append a line to README.md and commit the updates."

Read-Enter

Write-Action "git log --oneline"
git log --oneline

Write-Host "`nAdding new changes..."
$Date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Add-Content -Path README.md -Value "Last Updated: $Date"

Write-Action "git status"
git status

Write-Action "git diff (to view the line modifications)"
git diff

Write-Host "`nStaging and committing new changes..."
git add README.md
git commit -m "docs: Update README with last update timestamp"

Write-Action "git log --oneline"
git log --oneline

Write-Header "Step 6: Branching (Create 'feature/awesome-ui')"
Write-Host "Instead of working directly on 'main', we'll create an isolated branch."
Write-Host "Command to create and switch to a branch:"
Write-Command "git checkout -b feature/awesome-ui"

Read-Enter

Write-Action "git checkout -b feature/awesome-ui"
git checkout -b feature/awesome-ui

Write-Action "git branch (lists all branches, asterisk marks active)"
git branch

Write-Header "Step 7: Add Feature Code on our Branch"
Write-Host "We will create a stylesheet file named 'styles.css' and commit it."
Write-Host "This file will only exist on our feature branch for now."

Read-Enter

"body { background-color: #121212; color: #ffffff; font-family: sans-serif; }" | Out-File -FilePath styles.css -Encoding utf8

Write-Host "`nStaging and committing 'styles.css' on branch 'feature/awesome-ui'..."
git add styles.css
git commit -m "feat: Add dark-mode styles sheet"

Write-Host "`nListing directory files on 'feature/awesome-ui':"
Get-ChildItem

Write-Header "Step 8: Switch back to 'main' & See the Magic"
Write-Host "Now we switch back to the 'main' branch."
Write-Host "Command:"
Write-Command "git checkout main"
Write-Host "Watch what happens to the files in the directory!"

Read-Enter

Write-Action "git checkout main"
git checkout main

Write-Host "`nListing directory files on 'main':"
Get-ChildItem

Write-Explanation "Notice that 'styles.css' is GONE! That's because it was created on 'feature/awesome-ui'."
Write-Host "Git safely isolates files based on the branch you are currently on."

Write-Header "Step 9: Merge the Feature branch into 'main'"
Write-Host "Now that the feature is ready, we merge it into the 'main' branch."
Write-Host "Command:"
Write-Command "git merge feature/awesome-ui"

Read-Enter

Write-Action "git merge feature/awesome-ui"
git merge feature/awesome-ui

Write-Host "`nListing directory files on 'main' after merge:"
Get-ChildItem

Write-Success "Merge successful! 'styles.css' has been merged into main."

Write-Header "Step 10: Final Visual Graph History"
Write-Host "We can look at the commit tree to see how our branches diverged and merged:"
Write-Command "git log --graph --oneline --all"

Read-Enter

Write-Action "git log --graph --oneline --all"
git log --graph --oneline --all

# Return to original directory
Set-Location ..

Write-Header "Demo Complete!"
Write-Host "You have successfully navigated a full Git cycle!"
Write-Host "1. git init (Created repository)" -ForegroundColor Green
Write-Host "2. git status (Checked files status)" -ForegroundColor Green
Write-Host "3. git add (Staged files)" -ForegroundColor Green
Write-Host "4. git commit (Saved snapshot)" -ForegroundColor Green
Write-Host "5. git checkout -b (Created feature branch)" -ForegroundColor Green
Write-Host "6. git merge (Integrated features back to main)" -ForegroundColor Green

if ($Auto) {
    Write-Host "`nCleaning up '$SandboxDir' folder (Auto-mode)..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $SandboxDir
    Write-Host "Sandbox deleted. Clean exit!" -ForegroundColor Green
} else {
    $Keep = Read-Host "`nWould you like to keep the '$SandboxDir' folder to explore it yourself? (y/n)"
    if ($Keep -ne "y" -and $Keep -ne "Y") {
        Write-Host "Cleaning up '$SandboxDir' folder..." -ForegroundColor Yellow
        Remove-Item -Recurse -Force $SandboxDir
        Write-Host "Sandbox deleted. Clean exit!" -ForegroundColor Green
    } else {
        Write-Host "Sandbox preserved at: $((Get-Location).Path)\$SandboxDir" -ForegroundColor Green
        Write-Host "You can open your terminal, go into that directory, and run your own Git commands!"
    }
}
