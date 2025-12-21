#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}📋 Checking for changes...${NC}"

# Check if there are any changes
if git diff --quiet && git diff --cached --quiet; then
  echo -e "${RED}❌ No changes to commit.${NC}"
  exit 0
fi

# Show status
echo -e "${YELLOW}📝 Changes detected:${NC}"
git status --short

# Determine commit message
if [ -z "$1" ]; then
  # Auto-generate commit message from changes
  echo -e "${YELLOW}🤖 Auto-generating commit message...${NC}"
  
  # Get list of changed files
  CHANGED_FILES=$(git diff --name-only --cached 2>/dev/null)
  if [ -z "$CHANGED_FILES" ]; then
    CHANGED_FILES=$(git diff --name-only)
  fi
  
  # Count changes
  NUM_FILES=$(echo "$CHANGED_FILES" | wc -l)
  
  # Generate message based on file types
  if echo "$CHANGED_FILES" | grep -q "_posts/"; then
    COMMIT_MSG="update blog posts"
  elif echo "$CHANGED_FILES" | grep -q "_drafts/"; then
    COMMIT_MSG="update drafts"
  elif echo "$CHANGED_FILES" | grep -q "_config"; then
    COMMIT_MSG="update site configuration"
  elif echo "$CHANGED_FILES" | grep -q "_sass/\|assets/css/"; then
    COMMIT_MSG="update styles"
  elif echo "$CHANGED_FILES" | grep -q "_includes/\|_layouts/"; then
    COMMIT_MSG="update templates"
  elif echo "$CHANGED_FILES" | grep -q "README.md"; then
    COMMIT_MSG="update documentation"
  else
    COMMIT_MSG="update site files"
  fi
  
  # Add file count if multiple files
  if [ "$NUM_FILES" -gt 1 ]; then
    COMMIT_MSG="$COMMIT_MSG ($NUM_FILES files)"
  fi
  
  echo -e "${GREEN}📝 Generated message: \"$COMMIT_MSG\"${NC}"
else
  COMMIT_MSG="$1"
  echo -e "${GREEN}📝 Using custom message: \"$COMMIT_MSG\"${NC}"
fi

# Git add, commit, and push
echo -e "${YELLOW}📤 Committing and pushing to GitHub...${NC}"
git add .
git commit -m "$COMMIT_MSG"

if [ $? -eq 0 ]; then
  git push origin master
  
  if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Success! Changes pushed to GitHub.${NC}"
    echo -e "${GREEN}🚀 Netlify will build and deploy automatically.${NC}"
  else
    echo -e "${RED}❌ Failed to push to GitHub.${NC}"
    exit 1
  fi
else
  echo -e "${RED}❌ Failed to commit changes.${NC}"
  exit 1
fi
