# GitHub Repository Setup Guide

This guide explains how to set up proper branch protection and repository rules for the MIKA project.

## Quick Setup

### Step 1: Create a GitHub Personal Access Token

1. Go to https://github.com/settings/tokens
2. Click "Generate new token (classic)"
3. Give it a name: "MIKA Repository Setup"
4. Select scopes:
   - ✅ `repo` (all sub-scopes)
   - ✅ `admin:repo_hook` (all sub-scopes)
5. Click "Generate token"
6. **Copy the token** (you won't see it again)

### Step 2: Run the Setup Script

```bash
# Set your token as environment variable
export GITHUB_TOKEN=your_token_here

# Run the setup script
./setup-github-rules.sh
```

The script will:
- Configure repository settings
- Set up branch protection rules
- Create CODEOWNERS file
- Create pull request template

## What Gets Configured

### Repository Settings
- **Issues**: Enabled (for bug reports and feature requests)
- **Projects**: Disabled (not needed for this project)
- **Wiki**: Disabled (documentation is in README)
- **Merge strategies**:
  - Squash merge: ✅ Enabled (clean history)
  - Merge commit: ❌ Disabled (messy history)
  - Rebase merge: ✅ Enabled (linear history)
- **Auto-delete branches**: ✅ Enabled (clean up after merge)
- **Forking**: ✅ Enabled (open source contributions)

### Branch Protection Rules

Applied to: `main`, `examples/atlas`, `feature/advanced-setup`

- **Require pull request before merging**: ✅
- **Require 1 approval**: ✅
- **Dismiss stale reviews**: ✅ (on new commits)
- **Require conversation resolution**: ✅
- **Block force pushes**: ✅
- **Block deletions**: ✅
- **Enforce on admins**: ❌ (you can still push if needed)

### CODEOWNERS File

Automatically requests review from @Nao-30 on:
- All files (default)
- Core system files (`/system/`, `/ai/`)
- Documentation files (`*.md`)

### Pull Request Template

Provides structure for contributors:
- Description section
- Type of change checklist
- Testing checklist
- Documentation checklist
- Related issues linking

## Manual Setup (Alternative)

If you prefer to set up manually through GitHub UI:

### 1. Repository Settings

Go to: `Settings` → `General`

**Features:**
- ✅ Issues
- ❌ Projects
- ❌ Wiki

**Pull Requests:**
- ✅ Allow squash merging
- ❌ Allow merge commits
- ✅ Allow rebase merging
- ✅ Automatically delete head branches

### 2. Branch Protection

Go to: `Settings` → `Branches` → `Add rule`

**Branch name pattern:** `main`

**Protect matching branches:**
- ✅ Require a pull request before merging
  - ✅ Require approvals: 1
  - ✅ Dismiss stale pull request approvals when new commits are pushed
- ✅ Require conversation resolution before merging
- ✅ Do not allow bypassing the above settings

Repeat for `examples/atlas` and `feature/advanced-setup` branches.

### 3. Create CODEOWNERS

Create `.github/CODEOWNERS` file:
```
* @Nao-30
/system/ @Nao-30
/ai/ @Nao-30
*.md @Nao-30
```

### 4. Create PR Template

Create `.github/PULL_REQUEST_TEMPLATE.md` with the template from the script.

## Contributor Workflow

With these rules in place, contributors must:

1. **Fork the repository**
2. **Create a feature branch** in their fork
3. **Make changes** and commit
4. **Open a pull request** to the main repository
5. **Wait for review** (1 approval required)
6. **Address feedback** if any
7. **Merge** once approved

## Maintainer Workflow

As the maintainer, you can:

1. **Review pull requests**
2. **Request changes** if needed
3. **Approve** when ready
4. **Merge** using squash or rebase
5. **Branch auto-deletes** after merge

## Emergency Override

If you need to push directly (emergency fix):

1. You can still push as repo owner (enforce_admins is false)
2. Or temporarily disable branch protection
3. Make the fix
4. Re-enable protection

**Note:** Try to avoid this - use PRs even for your own changes to maintain consistency.

## Troubleshooting

### "Resource not accessible by personal access token"
- Your token doesn't have the right scopes
- Regenerate with `repo` and `admin:repo_hook` scopes

### "Branch protection rule already exists"
- The script is idempotent - it will update existing rules
- Safe to run multiple times

### "Not Found" error
- Check repository owner and name in the script
- Make sure the repository exists
- Verify your token has access to the repository

## Security Notes

- **Never commit your GitHub token** to the repository
- Use environment variables for the token
- Revoke tokens when no longer needed
- Use fine-grained tokens if possible (requires GitHub Enterprise)

## Questions?

Open an issue in the repository or contact @Nao-30.

---

*This setup ensures code quality, proper review process, and safe collaboration for the MIKA project.*
