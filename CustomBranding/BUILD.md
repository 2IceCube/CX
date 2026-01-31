# Building the FeatherPanel Plugin Archive (.fpa)

This guide explains how to package the Custom Branding Plugin as a `.fpa` file (FeatherPanel Plugin Archive) for easy distribution and installation.

## What is a .fpa File?

A `.fpa` (FeatherPanel Plugin Archive) file is a packaged plugin for FeatherPanel that contains:
- Plugin source code
- Configuration files
- Assets (CSS, images, etc.)
- Documentation
- Manifest file (addon.json)

It's essentially a ZIP archive with a `.fpa` extension, structured specifically for FeatherPanel plugins.

## Prerequisites

Before building the .fpa package, ensure you have:

- [ ] **Linux, macOS, or Windows with WSL** - Build script requires bash
- [ ] **zip utility** - For creating the archive
- [ ] **All plugin files** - Complete plugin source code

### Installing Prerequisites

#### Ubuntu/Debian
```bash
sudo apt-get update
sudo apt-get install zip
```

#### CentOS/RHEL/Fedora
```bash
sudo yum install zip
# OR
sudo dnf install zip
```

#### macOS
```bash
# zip is pre-installed on macOS
# Verify with: which zip
```

#### Windows (WSL)
```bash
# First install WSL, then:
sudo apt-get update
sudo apt-get install zip
```

## Quick Build

The easiest way to build the .fpa package:

```bash
# Navigate to the plugin directory
cd CustomBranding

# Run the build script
./build.sh

# Verify the package (optional but recommended)
./verify.sh
```

The packaged `.fpa` file will be created in the `dist/` directory.

## Build Script Usage

### Basic Usage

```bash
./build.sh
```

### Verbose Output

To see detailed package contents:

```bash
./build.sh --verbose
# OR
./build.sh -v
```

### Verifying the Package

After building, verify the package integrity:

```bash
./verify.sh
```

The verification script checks:
- ZIP file integrity
- Required files presence
- JSON file validity
- Directory structure
- File sizes and content
- No unwanted files included

## Build and Verify Workflow

Complete workflow for creating a distribution-ready package:

```bash
# 1. Build the package
./build.sh

# 2. Verify the package
./verify.sh

# 3. (Optional) View package contents
./build.sh --verbose
# OR
unzip -l dist/CustomBranding-v1.0.0.fpa
```

## Build Process Explained

### What the Build Script Does

1. **Checks Prerequisites**
   - Verifies `zip` utility is installed
   - Validates required files exist

2. **Cleans Previous Builds**
   - Removes old `build/` and `dist/` directories
   - Ensures fresh build environment

3. **Creates Build Directory**
   - Sets up temporary build structure
   - Prepares for file copying

4. **Copies Plugin Files**
   - **Core files**: addon.json, package.json, config files
   - **Source code**: src/ directory with plugin logic
   - **Assets**: assets/ directory with CSS and other files
   - **Examples**: examples/ directory with configuration samples
   - **Documentation**: README, guides, LICENSE

5. **Verifies Package**
   - Checks all required files are present
   - Validates package structure

6. **Creates .fpa Archive**
   - Packages everything into a ZIP file
   - Renames to .fpa extension
   - Saves to dist/ directory

7. **Displays Summary**
   - Shows package size and file count
   - Provides installation instructions

### Files Included in Package

#### Essential Files
```
CustomBranding/
├── addon.json                 # Plugin manifest (REQUIRED)
├── package.json               # Package metadata (REQUIRED)
├── config.json                # Default configuration (REQUIRED)
├── src/
│   └── index.js              # Main plugin code (REQUIRED)
```

#### Asset Files
```
├── assets/
│   └── custom-branding.css   # Plugin styles
```

#### Configuration Files
```
├── config.example.json        # Example configuration
├── examples/
│   ├── minimal-example.json
│   ├── footer-only-example.json
│   ├── full-branding-example.json
│   └── watermark-only-example.json
```

#### Documentation
```
├── LICENSE                    # MIT License
├── README.md                  # Main documentation
├── INSTALLATION.md            # Installation guide
├── QUICKSTART.md              # Quick start guide
├── CHANGELOG.md               # Version history
├── CONTRIBUTING.md            # (Optional) Contribution guidelines
├── STRUCTURE.md               # (Optional) Structure documentation
└── TESTING.md                 # (Optional) Testing guidelines
```

## Manual Build (Without Script)

If you prefer to build manually or the script doesn't work:

### Step 1: Create Build Directory

```bash
mkdir -p build/CustomBranding
mkdir -p dist
```

### Step 2: Copy Files

```bash
# Core files
cp addon.json build/CustomBranding/
cp package.json build/CustomBranding/
cp config.json build/CustomBranding/
cp config.example.json build/CustomBranding/

# Source and assets
cp -r src build/CustomBranding/
cp -r assets build/CustomBranding/
cp -r examples build/CustomBranding/

# Documentation
cp LICENSE build/CustomBranding/
cp README.md build/CustomBranding/
cp INSTALLATION.md build/CustomBranding/
cp QUICKSTART.md build/CustomBranding/
cp CHANGELOG.md build/CustomBranding/

# Optional documentation
cp CONTRIBUTING.md build/CustomBranding/ 2>/dev/null || true
cp STRUCTURE.md build/CustomBranding/ 2>/dev/null || true
cp TESTING.md build/CustomBranding/ 2>/dev/null || true
```

### Step 3: Create Archive

```bash
cd build
zip -r ../dist/CustomBranding-v1.0.0.fpa CustomBranding
cd ..
```

### Step 4: Verify Package

```bash
# List contents
unzip -l dist/CustomBranding-v1.0.0.fpa

# Check size
du -h dist/CustomBranding-v1.0.0.fpa
```

## Verifying Your Build

After building, verify the package is correct:

### Check Package Contents

```bash
unzip -l dist/CustomBranding-v1.0.0.fpa
```

Should show:
- CustomBranding/addon.json
- CustomBranding/src/index.js
- CustomBranding/config.json
- All other files listed above

### Test Package Integrity

```bash
# Test ZIP integrity
unzip -t dist/CustomBranding-v1.0.0.fpa
```

Should output: "No errors detected"

### Extract and Verify Structure

```bash
# Extract to temporary directory
mkdir -p test-extract
unzip dist/CustomBranding-v1.0.0.fpa -d test-extract

# Check structure
tree test-extract/CustomBranding
# OR
find test-extract/CustomBranding -type f

# Clean up
rm -rf test-extract
```

## Build Troubleshooting

### Issue: "zip: command not found"

**Solution**: Install zip utility
```bash
# Ubuntu/Debian
sudo apt-get install zip

# CentOS/RHEL
sudo yum install zip
```

### Issue: "Permission denied" when running build.sh

**Solution**: Make script executable
```bash
chmod +x build.sh
```

### Issue: "Required file missing" error

**Solution**: Ensure you're in the correct directory
```bash
cd CustomBranding
ls addon.json  # Should exist
./build.sh
```

### Issue: Build succeeds but .fpa file is missing

**Solution**: Check dist/ directory
```bash
ls -lh dist/
# If empty, check for error messages in build output
```

### Issue: Package is too large or contains unnecessary files

**Solution**: The build script only includes necessary files. If custom files were added:
```bash
# Clean and rebuild
rm -rf build dist
./build.sh
```

## Installing Your Built Package

### Method 1: Via FeatherPanel Admin (Recommended)

1. Log into FeatherPanel admin panel
2. Navigate to **Plugins** or **Addons** section
3. Click **Upload Plugin** or **Install Plugin**
4. Select your `.fpa` file from `dist/` directory
5. Click **Install**
6. Enable the plugin once installed

### Method 2: Manual Installation

```bash
# Extract to plugins directory
sudo unzip dist/CustomBranding-v1.0.0.fpa -d /path/to/featherpanel/plugins/

# Set proper permissions
sudo chown -R www-data:www-data /path/to/featherpanel/plugins/CustomBranding
sudo chmod -R 755 /path/to/featherpanel/plugins/CustomBranding

# Restart FeatherPanel
sudo systemctl restart featherpanel
```

### Method 3: Using FeatherPanel CLI

If FeatherPanel has a CLI tool:

```bash
# Install plugin
featherpanel plugin install dist/CustomBranding-v1.0.0.fpa

# Enable plugin
featherpanel plugin enable custom-branding
```

## Distribution

### Sharing Your Plugin

After building, you can distribute the `.fpa` file via:

1. **GitHub Releases**
   - Upload as release asset
   - Users can download directly

2. **Direct Download**
   - Host on your website
   - Share download link

3. **Plugin Repository**
   - Submit to FeatherPanel plugin repository
   - Available to all FeatherPanel users

### Version Management

When releasing new versions:

1. Update version in files:
   - `addon.json` → version field
   - `package.json` → version field
   - `CHANGELOG.md` → add new version entry

2. Rebuild package:
   ```bash
   ./build.sh
   ```

3. New file will be created:
   ```
   dist/CustomBranding-v1.0.1.fpa  # (with new version)
   ```

## Advanced Build Options

### Customizing the Build Script

You can modify `build.sh` to:

1. **Add more files**
   ```bash
   # Add to the file copying section
   cp your-file.txt "$BUILD_DIR/$PLUGIN_NAME/"
   ```

2. **Exclude certain files**
   ```bash
   # Use zip's exclude option
   zip -r "../$DIST_DIR/$FPA_FILE" "$PLUGIN_NAME" -x "*.test.js" -q
   ```

3. **Add checksums**
   ```bash
   # After creating package
   sha256sum "$DIST_DIR/$FPA_FILE" > "$DIST_DIR/$FPA_FILE.sha256"
   ```

### Automated Builds

#### Using GitHub Actions

Create `.github/workflows/build.yml`:

```yaml
name: Build FPA Package

on:
  push:
    tags:
      - 'v*'

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Build package
        run: |
          cd CustomBranding
          chmod +x build.sh
          ./build.sh
      - name: Upload artifact
        uses: actions/upload-artifact@v3
        with:
          name: plugin-package
          path: CustomBranding/dist/*.fpa
```

#### Using Make

Create `Makefile`:

```makefile
.PHONY: build clean install

build:
	cd CustomBranding && ./build.sh

clean:
	rm -rf CustomBranding/build CustomBranding/dist

install: build
	sudo unzip -o CustomBranding/dist/*.fpa -d /path/to/featherpanel/plugins/
```

Usage:
```bash
make build    # Build package
make clean    # Clean build files
make install  # Build and install
```

## Package Structure Specification

### Standard .fpa Structure

```
CustomBranding-v1.0.0.fpa (ZIP archive)
│
└── CustomBranding/
    ├── addon.json              # Plugin manifest
    ├── package.json            # Package metadata
    ├── config.json             # Default configuration
    ├── config.example.json     # Example configuration
    ├── src/
    │   └── index.js           # Main entry point
    ├── assets/
    │   └── *.css              # Stylesheets
    ├── examples/
    │   └── *.json             # Configuration examples
    ├── LICENSE                 # License file
    ├── README.md               # Documentation
    └── *.md                    # Additional docs
```

### Manifest File (addon.json)

Required fields:
```json
{
  "id": "custom-branding",
  "name": "Custom Branding Plugin",
  "version": "1.0.0",
  "author": "MysticsSystems",
  "main": "src/index.js",
  "dependencies": {
    "featherpanel": ">=1.0.0"
  }
}
```

## Build Best Practices

### Before Building

- [ ] Update version numbers in all files
- [ ] Update CHANGELOG.md
- [ ] Test plugin functionality
- [ ] Review all documentation
- [ ] Ensure no sensitive data in code
- [ ] Run linters if available

### During Building

- [ ] Use the provided build script
- [ ] Verify no errors in output
- [ ] Check package size is reasonable
- [ ] Verify all required files included

### After Building

- [ ] Test installation in clean environment
- [ ] Verify plugin loads correctly
- [ ] Test all major features
- [ ] Create checksum for package
- [ ] Tag release in version control

## FAQ

### Q: What's the difference between .fpa and .zip?

**A**: A .fpa file is a ZIP archive with specific structure required by FeatherPanel. It must contain a plugin manifest (addon.json) and follow FeatherPanel's plugin structure.

### Q: Can I open a .fpa file with normal ZIP tools?

**A**: Yes! .fpa files are standard ZIP archives. You can extract them with any ZIP tool:
```bash
unzip CustomBranding-v1.0.0.fpa
```

### Q: How large should a .fpa package be?

**A**: This plugin's .fpa is typically 50-150 KB. Keep packages under 10 MB when possible. If larger, consider hosting assets separately.

### Q: Can I include images and other assets?

**A**: Yes! Place them in the `assets/` directory and they'll be included automatically. Remember to reference them correctly in your code.

### Q: Does the package need to be signed?

**A**: Not for this version of FeatherPanel. Future versions might support package signing for enhanced security.

### Q: Can I distribute the .fpa file?

**A**: Yes! The plugin is under MIT License, so you can distribute freely. Just maintain the license file and attribution.

## Getting Help

If you encounter issues building the package:

1. **Check Prerequisites**: Ensure zip is installed
2. **Review Error Messages**: Read build script output carefully
3. **Verify File Structure**: Ensure all required files exist
4. **Check Permissions**: Ensure you have write access
5. **Try Manual Build**: Use manual steps if script fails

For more help:
- Check [INSTALLATION.md](INSTALLATION.md) for installation issues
- Review [README.md](README.md) for general documentation
- Open an issue on GitHub
- Visit FeatherPanel Discord community

## Summary

Building a .fpa package is simple:

1. **Run**: `./build.sh`
2. **Find**: Package in `dist/` directory
3. **Install**: Upload to FeatherPanel admin panel

The build script handles everything automatically, creating a complete, ready-to-install plugin package.

---

**Happy Building! 🚀**

For questions or improvements to this guide, please contribute via pull request.
