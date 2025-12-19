#!/bin/bash

# GitHub Repository Setup Script for MIKA
# This sets up branch protection rules and repository settings

# Configuration
REPO_OWNER="Nao-30"
REPO_NAME="mika-companion-system"
GITHUB_TOKEN="${GITHUB_TOKEN:-}"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if token is provided
if [ -z "$GITHUB_TOKEN" ]; then
    echo -e "${RED}Error: GITHUB_TOKEN environment variable is not set${NC}"
    echo "Usage: GITHUB_TOKEN=your_token_here ./setup-github-rules.sh"
    echo ""
    echo "To create a token:"
    echo "1. Go to https://github.com/settings/tokens"
    echo "2. Generate new token (classic)"
    echo "3. Select scopes: repo (all), admin:repo_hook"
    exit 1
fi

echo -e "${GREEN}Setting up GitHub repository rules for ${REPO_OWNER}/${REPO_NAME}${NC}"
echo ""

# Function to make GitHub API calls
github_api() {
    local method=$1
    local endpoint=$2
    local data=$3
    
    curl -s -X "$method" \
        -H "Authorization: token $GITHUB_TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        -d "$data" \
        "https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}${endpoint}"
}

# 1. Update repository settings
echo -e "${YELLOW}[1/6] Updating repository settings...${NC}"
github_api PATCH "" '{
  "has_issues": true,
  "has_projects": false,
  "has_wiki": false,
  "allow_squash_merge": true,
  "allow_merge_commit": false,
  "allow_rebase_merge": true,
  "delete_branch_on_merge": true,
  "allow_auto_merge": false,
  "allow_forking": true
}' > /dev/null
echo -e "${GREEN}✓ Repository settings updated${NC}"
echo "  - Issues: enabled"
echo "  - Projects: disabled"
echo "  - Wiki: disabled"
echo "  - Squash merge: enabled"
echo "  - Merge commit: disabled"
echo "  - Rebase merge: enabled"
echo "  - Auto-delete branches: enabled"
echo "  - Forking: enabled"
echo ""

# 2. Protect main branch
echo -e "${YELLOW}[2/6] Setting up main branch protection...${NC}"
github_api PUT "/branches/main/protection" '{
  "required_status_checks": null,
  "enforce_admins": false,
  "required_pull_request_reviews": {
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": false,
    "required_approving_review_count": 1,
    "require_last_push_approval": false
  },
  "restrictions": null,
  "required_linear_history": false,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "block_creations": false,
  "required_conversation_resolution": true,
  "lock_branch": false,
  "allow_fork_syncing": true
}' > /dev/null
echo -e "${GREEN}✓ Main branch protected${NC}"
echo "  - Require PR before merging"
echo "  - Require 1 approval"
echo "  - Dismiss stale reviews"
echo "  - Require conversation resolution"
echo "  - No force pushes"
echo "  - No deletions"
echo ""

# 3. Protect examples/atlas branch
echo -e "${YELLOW}[3/6] Setting up examples/atlas branch protection...${NC}"
github_api PUT "/branches/examples/atlas/protection" '{
  "required_status_checks": null,
  "enforce_admins": false,
  "required_pull_request_reviews": {
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": false,
    "required_approving_review_count": 1,
    "require_last_push_approval": false
  },
  "restrictions": null,
  "required_linear_history": false,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "block_creations": false,
  "required_conversation_resolution": true,
  "lock_branch": false,
  "allow_fork_syncing": true
}' > /dev/null
echo -e "${GREEN}✓ examples/atlas branch protected${NC}"
echo ""

# 4. Protect feature/advanced-setup branch
echo -e "${YELLOW}[4/6] Setting up feature/advanced-setup branch protection...${NC}"
github_api PUT "/branches/feature/advanced-setup/protection" '{
  "required_status_checks": null,
  "enforce_admins": false,
  "required_pull_request_reviews": {
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": false,
    "required_approving_review_count": 1,
    "require_last_push_approval": false
  },
  "restrictions": null,
  "required_linear_history": false,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "block_creations": false,
  "required_conversation_resolution": true,
  "lock_branch": false,
  "allow_fork_syncing": true
}' > /dev/null
echo -e "${GREEN}✓ feature/advanced-setup branch protected${NC}"
echo ""

# 5. Create CODEOWNERS file
echo -e "${YELLOW}[5/6] Creating CODEOWNERS file...${NC}"
cat > CODEOWNERS << 'EOF'
# MIKA Companion System - Code Owners
# These owners will be requested for review when someone opens a pull request

# Default owners for everything in the repo
* @Nao-30

# Core system files require extra attention
/system/ @Nao-30
/ai/ @Nao-30

# Documentation can have more contributors
*.md @Nao-30
EOF

git add CODEOWNERS
git commit -m "chore: add CODEOWNERS file for PR reviews" > /dev/null 2>&1
git push origin main > /dev/null 2>&1
echo -e "${GREEN}✓ CODEOWNERS file created and pushed${NC}"
echo ""

# 6. Create PR template
echo -e "${YELLOW}[6/6] Creating pull request template...${NC}"
mkdir -p .github
cat > .github/PULL_REQUEST_TEMPLATE.md << 'EOF'
## Description
<!-- Describe your changes in detail -->

## Type of Change
<!-- Mark the relevant option with an "x" -->
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update
- [ ] Example/template update

## Testing
<!-- Describe the tests you ran to verify your changes -->
- [ ] I have tested these changes locally
- [ ] I have tested with a fresh AI session
- [ ] Memory persistence works across sessions

## Checklist
- [ ] My code follows the style of this project
- [ ] I have updated the documentation accordingly
- [ ] I have added/updated examples if needed
- [ ] My changes don't break existing functionality
- [ ] I have tested the memory system with these changes

## Related Issues
<!-- Link any related issues here -->
Closes #

## Additional Notes
<!-- Any additional information that reviewers should know -->
EOF

git add .github/PULL_REQUEST_TEMPLATE.md
git commit -m "chore: add pull request template" > /dev/null 2>&1
git push origin main > /dev/null 2>&1
echo -e "${GREEN}✓ Pull request template created and pushed${NC}"
echo ""

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}GitHub repository setup complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Summary of changes:"
echo "  ✓ Repository settings configured"
echo "  ✓ Branch protection rules applied (main, examples/atlas, feature/advanced-setup)"
echo "  ✓ CODEOWNERS file created"
echo "  ✓ Pull request template created"
echo ""
echo "What this means:"
echo "  - Direct pushes to protected branches are blocked"
echo "  - All changes require pull requests"
echo "  - PRs require 1 approval before merging"
echo "  - Stale reviews are dismissed on new commits"
echo "  - Conversations must be resolved before merging"
echo "  - Forking is enabled for contributors"
echo "  - Branches auto-delete after merge"
echo ""
echo -e "${YELLOW}Note: You (as repo owner) can still push directly if needed${NC}"
echo -e "${YELLOW}To enforce rules on admins too, update enforce_admins to true${NC}"
