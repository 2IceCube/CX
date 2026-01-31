# Deployment Guide - Custom Branding Plugin

This guide covers the complete process of building, packaging, testing, and deploying the Custom Branding Plugin for FeatherPanel.

## Table of Contents

1. [Pre-Deployment Checklist](#pre-deployment-checklist)
2. [Building the Package](#building-the-package)
3. [Verification](#verification)
4. [Testing](#testing)
5. [Distribution](#distribution)
6. [Installation for End Users](#installation-for-end-users)
7. [Post-Deployment](#post-deployment)

## Pre-Deployment Checklist

Before building and deploying the plugin, ensure:

### Code Quality
- [ ] All features are implemented and working
- [ ] No debug code or console.logs in production code
- [ ] Configuration files have sensible defaults
- [ ] Code follows FeatherPanel plugin standards

### Documentation
- [ ] README.md is up to date
- [ ] CHANGELOG.md includes version history
- [ ] Installation instructions are clear
- [ ] Configuration options are documented

### Version Management
- [ ] Version number updated in:
  - [ ] `addon.json` (version field)
  - [ ] `package.json` (version field)
  - [ ] `CHANGELOG.md` (new entry)
  - [ ] `build.sh` (PLUGIN_VERSION variable)

### Testing
- [ ] Plugin tested in development environment
- [ ] All major features verified working
- [ ] Configuration options tested
- [ ] No errors in browser console or server logs

## Building the Package

### Step 1: Prepare the Build Environment

```bash
# Navigate to plugin directory
cd CustomBranding

# Ensure build script is executable
chmod +x build.sh verify.sh

# Clean any previous builds (optional)
rm -rf build dist
```

### Step 2: Run the Build Script

```bash
# Build the .fpa package
./build.sh

# Expected output:
# - Package created in dist/CustomBranding-v1.0.0.fpa
# - README-PACKAGE.txt created in dist/
```

### Step 3: Verify the Build

```bash
# Run verification script
./verify.sh

# This checks:
# - ZIP integrity
# - Required files present
# - JSON validity
# - File structure correct
# - No unwanted files
```

### Expected Results

After successful build:
```
dist/
├── CustomBranding-v1.0.0.fpa    (~30-35 KB)
└── README-PACKAGE.txt            (~4-5 KB)
```

## Verification

### Automated Verification

The `verify.sh` script performs comprehensive checks:

```bash
./verify.sh
```

**What it checks:**
- ✓ ZIP file integrity
- ✓ Package structure
- ✓ Required files present
- ✓ JSON files are valid
- ✓ Configuration sections present
- ✓ Source code has content and exports
- ✓ Assets directory exists
- ✓ Example configurations included
- ✓ Documentation files present
- ✓ No unwanted files (node_modules, .git, etc.)

### Manual Verification

Additional manual checks:

```bash
# Check package size (should be 30-50 KB)
ls -lh dist/CustomBranding-v1.0.0.fpa

# List package contents
unzip -l dist/CustomBranding-v1.0.0.fpa

# Test ZIP integrity
unzip -t dist/CustomBranding-v1.0.0.fpa

# Extract and inspect
mkdir -p test-extract
unzip dist/CustomBranding-v1.0.0.fpa -d test-extract
tree test-extract/CustomBranding  # or use: ls -la
rm -rf test-extract
```

## Testing

### Pre-Release Testing

Before distributing, test the package in a real environment:

#### Test Environment Setup

1. **Install FeatherPanel** (if not already installed)
2. **Create backup** of existing plugins
3. **Prepare test server** or local development environment

#### Installation Test

**Method 1: Via Admin Panel**

```bash
# Upload the .fpa file through:
# Admin Panel → Plugins → Upload Plugin
```

**Method 2: Manual Installation**

```bash
# Extract package
sudo unzip dist/CustomBranding-v1.0.0.fpa -d /path/to/featherpanel/plugins/

# Set permissions
sudo chown -R www-data:www-data /path/to/featherpanel/plugins/CustomBranding
sudo chmod -R 755 /path/to/featherpanel/plugins/CustomBranding

# Restart FeatherPanel
sudo systemctl restart featherpanel
```

#### Functional Testing

After installation, test these scenarios:

1. **Default Configuration**
   - [ ] Plugin loads without errors
   - [ ] Default watermark removal works
   - [ ] Default footer removal works
   - [ ] No console errors

2. **Custom Footer**
   - [ ] Custom footer appears
   - [ ] Footer text is correct
   - [ ] Footer link works
   - [ ] Alignment is correct

3. **Custom Watermark**
   - [ ] Custom watermark appears
   - [ ] Position is correct
   - [ ] Opacity is correct
   - [ ] Color is correct

4. **Advanced Features**
   - [ ] Context-aware application works (admin/client)
   - [ ] Login page preservation works
   - [ ] Hide all branding option works

5. **Browser Compatibility**
   - [ ] Works in Chrome
   - [ ] Works in Firefox
   - [ ] Works in Safari
   - [ ] Works in Edge
   - [ ] Responsive on mobile

6. **Configuration Changes**
   - [ ] Config reload works
   - [ ] Invalid JSON handled gracefully
   - [ ] Missing fields use defaults

## Distribution

### Creating a Release

#### Step 1: Tag the Release

```bash
# Tag the version
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0
```

#### Step 2: Create GitHub Release

1. Go to GitHub repository
2. Navigate to **Releases**
3. Click **Create a new release**
4. Select tag: `v1.0.0`
5. Release title: `Custom Branding Plugin v1.0.0`
6. Description: Copy from CHANGELOG.md
7. Attach files:
   - `dist/CustomBranding-v1.0.0.fpa`
   - `dist/README-PACKAGE.txt`
8. Click **Publish release**

#### Step 3: Generate Checksums (Optional)

For added security, generate checksums:

```bash
# Generate SHA256 checksum
cd dist
sha256sum CustomBranding-v1.0.0.fpa > CustomBranding-v1.0.0.fpa.sha256

# Users can verify with:
# sha256sum -c CustomBranding-v1.0.0.fpa.sha256
```

### Distribution Channels

1. **GitHub Releases** (Primary)
   - Attach .fpa file to release
   - Include README-PACKAGE.txt
   - Add installation instructions

2. **Direct Download** (Secondary)
   - Host on your website
   - Provide direct download link
   - Include version number in URL

3. **Plugin Repository** (If Available)
   - Submit to FeatherPanel plugin directory
   - Follow their submission guidelines
   - Include all required metadata

## Installation for End Users

### Quick Install Instructions

Provide users with this quick guide:

```markdown
## Quick Installation

1. **Download** the plugin package:
   - Download `CustomBranding-v1.0.0.fpa` from releases

2. **Upload to FeatherPanel**:
   - Log into your FeatherPanel admin dashboard
   - Navigate to **Settings** → **Plugins**
   - Click **Upload Plugin**
   - Select the `.fpa` file and click **Install**

3. **Enable the Plugin**:
   - Find "Custom Branding Plugin" in the plugins list
   - Click **Enable** or **Activate**

4. **Configure** (Optional):
   - Edit `plugins/CustomBranding/config.json`
   - Customize your branding
   - Restart FeatherPanel or reload plugins

For detailed instructions, see INSTALLATION.md in the package.
```

### Support Documentation

Ensure users have access to:

- **README.md** - Feature overview and usage
- **INSTALLATION.md** - Detailed installation steps
- **QUICKSTART.md** - 5-minute setup guide
- **CHANGELOG.md** - Version history
- **Examples** - Sample configurations

## Post-Deployment

### Monitoring

After release, monitor for:

1. **Installation Issues**
   - Watch GitHub issues for installation problems
   - Respond to user questions promptly
   - Update documentation based on feedback

2. **Bug Reports**
   - Track reported bugs
   - Prioritize critical issues
   - Release patches as needed

3. **Feature Requests**
   - Collect feature requests
   - Consider for future versions
   - Update roadmap

### Maintenance

#### Version Updates

When releasing a new version:

```bash
# 1. Update version numbers
# Edit: addon.json, package.json, build.sh

# 2. Update changelog
# Edit: CHANGELOG.md

# 3. Rebuild package
./build.sh

# 4. Verify package
./verify.sh

# 5. Test thoroughly
# Install in test environment

# 6. Create release
# Tag, build, and publish
```

#### Security Updates

For security issues:

1. **Immediate Response**
   - Assess severity
   - Develop fix quickly
   - Test thoroughly

2. **Release Process**
   - Bump version (patch number)
   - Update security section in CHANGELOG
   - Release immediately
   - Notify users

3. **Communication**
   - Post security advisory
   - Explain the issue and fix
   - Recommend immediate update

## Troubleshooting Deployment

### Build Issues

**Problem**: Build script fails

**Solutions**:
```bash
# Check prerequisites
which zip

# Verify file permissions
chmod +x build.sh

# Check current directory
pwd  # Should be in CustomBranding/

# Try verbose mode
./build.sh --verbose
```

**Problem**: Package too large

**Solutions**:
```bash
# Check for unwanted files
unzip -l dist/CustomBranding-v1.0.0.fpa | grep -E "(node_modules|\.git)"

# Review .gitignore
cat .gitignore

# Clean and rebuild
rm -rf build dist node_modules
./build.sh
```

### Verification Issues

**Problem**: Verification fails

**Solutions**:
```bash
# Check detailed output
./verify.sh

# Manually inspect package
unzip -l dist/CustomBranding-v1.0.0.fpa

# Test JSON files
python3 -m json.tool addon.json
python3 -m json.tool config.json
```

### Installation Issues

**Problem**: Plugin won't install

**Solutions**:
1. Check FeatherPanel version compatibility
2. Verify .fpa file isn't corrupted
3. Check server permissions
4. Review FeatherPanel logs
5. Try manual installation method

## Deployment Checklist

Use this checklist for each release:

### Pre-Build
- [ ] Code tested and working
- [ ] Documentation updated
- [ ] Version numbers updated
- [ ] Changelog updated
- [ ] Examples verified

### Build
- [ ] Run `./build.sh`
- [ ] Check dist/ directory
- [ ] Verify package size reasonable
- [ ] Run `./verify.sh`
- [ ] All checks pass

### Testing
- [ ] Install in test environment
- [ ] Test default configuration
- [ ] Test custom configurations
- [ ] Test in multiple browsers
- [ ] Test permission scenarios
- [ ] No errors in logs

### Release
- [ ] Create git tag
- [ ] Push tag to repository
- [ ] Create GitHub release
- [ ] Upload .fpa file
- [ ] Upload README-PACKAGE.txt
- [ ] Generate checksums (optional)
- [ ] Update release notes

### Post-Release
- [ ] Verify download links work
- [ ] Test installation from release
- [ ] Monitor for issues
- [ ] Respond to feedback
- [ ] Update documentation if needed

## Summary

Complete deployment process:

```bash
# 1. Build
./build.sh

# 2. Verify
./verify.sh

# 3. Test
# Install in test environment and verify functionality

# 4. Release
# Create GitHub release with .fpa file

# 5. Monitor
# Watch for issues and user feedback
```

## Getting Help

If you encounter issues during deployment:

1. **Review Documentation**
   - Check BUILD.md for build issues
   - Check INSTALLATION.md for install issues
   - Check TESTING.md for testing guidelines

2. **Community Support**
   - GitHub Issues
   - FeatherPanel Discord
   - Community forums

3. **Direct Support**
   - Email: support@example.com
   - Create detailed bug report with:
     - Error messages
     - Build output
     - Environment details
     - Steps to reproduce

---

**Plugin Version**: 1.0.0  
**Last Updated**: 2024-01-31  
**Status**: Production Ready ✅

For questions about deployment, create an issue on GitHub.
