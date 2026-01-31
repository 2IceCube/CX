#!/bin/bash

###############################################################################
# FeatherPanel Plugin Archive (FPA) Builder
# Creates a .fpa package file for the Custom Branding Plugin
#
# Author: MysticsSystems
# Version: 1.0.0
###############################################################################

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script configuration
PLUGIN_NAME="CustomBranding"
PLUGIN_VERSION="1.0.0"
BUILD_DIR="build"
DIST_DIR="dist"
FPA_FILE="CustomBranding-v${PLUGIN_VERSION}.fpa"

echo -e "${BLUE}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  FeatherPanel Plugin Archive Builder                    ║${NC}"
echo -e "${BLUE}║  Custom Branding Plugin v${PLUGIN_VERSION}                      ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""

# Function to print status messages
print_status() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[i]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
print_info "Checking prerequisites..."

if ! command_exists zip; then
    print_error "zip command not found. Please install zip utility."
    echo "  Ubuntu/Debian: sudo apt-get install zip"
    echo "  CentOS/RHEL: sudo yum install zip"
    echo "  macOS: Already installed by default"
    exit 1
fi

print_status "All prerequisites met"
echo ""

# Clean previous build
print_info "Cleaning previous build..."
rm -rf "$BUILD_DIR" "$DIST_DIR"
print_status "Clean completed"
echo ""

# Create build directory
print_info "Creating build directory..."
mkdir -p "$BUILD_DIR/$PLUGIN_NAME"
mkdir -p "$DIST_DIR"
print_status "Build directory created"
echo ""

# Files to include in the package
print_info "Copying plugin files..."

# Core plugin files
cp addon.json "$BUILD_DIR/$PLUGIN_NAME/" 2>/dev/null && print_status "  addon.json (plugin manifest)"
cp package.json "$BUILD_DIR/$PLUGIN_NAME/" 2>/dev/null && print_status "  package.json (package metadata)"
cp config.json "$BUILD_DIR/$PLUGIN_NAME/" 2>/dev/null && print_status "  config.json (default configuration)"
cp config.example.json "$BUILD_DIR/$PLUGIN_NAME/" 2>/dev/null && print_status "  config.example.json (example configuration)"

# Source code
cp -r src "$BUILD_DIR/$PLUGIN_NAME/" 2>/dev/null && print_status "  src/ (plugin source code)"

# Assets
cp -r assets "$BUILD_DIR/$PLUGIN_NAME/" 2>/dev/null && print_status "  assets/ (CSS and other assets)"

# Examples
cp -r examples "$BUILD_DIR/$PLUGIN_NAME/" 2>/dev/null && print_status "  examples/ (configuration examples)"

# Documentation
cp LICENSE "$BUILD_DIR/$PLUGIN_NAME/" 2>/dev/null && print_status "  LICENSE (MIT license)"
cp README.md "$BUILD_DIR/$PLUGIN_NAME/" 2>/dev/null && print_status "  README.md (main documentation)"
cp INSTALLATION.md "$BUILD_DIR/$PLUGIN_NAME/" 2>/dev/null && print_status "  INSTALLATION.md (installation guide)"
cp QUICKSTART.md "$BUILD_DIR/$PLUGIN_NAME/" 2>/dev/null && print_status "  QUICKSTART.md (quick start guide)"
cp CHANGELOG.md "$BUILD_DIR/$PLUGIN_NAME/" 2>/dev/null && print_status "  CHANGELOG.md (version history)"

# Optional documentation files
if [ -f "CONTRIBUTING.md" ]; then
    cp CONTRIBUTING.md "$BUILD_DIR/$PLUGIN_NAME/" && print_status "  CONTRIBUTING.md (contribution guidelines)"
fi

if [ -f "STRUCTURE.md" ]; then
    cp STRUCTURE.md "$BUILD_DIR/$PLUGIN_NAME/" && print_status "  STRUCTURE.md (structure documentation)"
fi

if [ -f "TESTING.md" ]; then
    cp TESTING.md "$BUILD_DIR/$PLUGIN_NAME/" && print_status "  TESTING.md (testing guidelines)"
fi

echo ""

# Verify required files
print_info "Verifying package contents..."
REQUIRED_FILES=(
    "$BUILD_DIR/$PLUGIN_NAME/addon.json"
    "$BUILD_DIR/$PLUGIN_NAME/src/index.js"
    "$BUILD_DIR/$PLUGIN_NAME/config.json"
)

all_present=true
for file in "${REQUIRED_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        print_error "Required file missing: $file"
        all_present=false
    fi
done

if [ "$all_present" = false ]; then
    print_error "Package verification failed. Missing required files."
    exit 1
fi

print_status "All required files present"
echo ""

# Create the .fpa package (ZIP archive with .fpa extension)
print_info "Creating .fpa package..."
cd "$BUILD_DIR"
zip -r "../$DIST_DIR/$FPA_FILE" "$PLUGIN_NAME" -q
cd ..

if [ -f "$DIST_DIR/$FPA_FILE" ]; then
    print_status "Package created successfully"
else
    print_error "Failed to create package"
    exit 1
fi

# Copy package README alongside the .fpa file
if [ -f "PACKAGE_README.md" ]; then
    cp PACKAGE_README.md "$DIST_DIR/README-PACKAGE.txt"
    print_status "Package README created"
fi

echo ""

# Get package information
PACKAGE_SIZE=$(du -h "$DIST_DIR/$FPA_FILE" | cut -f1)
FILE_COUNT=$(unzip -l "$DIST_DIR/$FPA_FILE" | tail -1 | awk '{print $2}')

# Display summary
echo -e "${GREEN}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  Build Successful!                                       ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""
print_status "Package: $FPA_FILE"
print_status "Size: $PACKAGE_SIZE"
print_status "Files: $FILE_COUNT"
print_status "Location: $DIST_DIR/$FPA_FILE"
echo ""

print_info "Installation Instructions:"
echo "  1. Upload $FPA_FILE to your FeatherPanel admin panel"
echo "  2. Navigate to Plugins/Addons section"
echo "  3. Click 'Upload Plugin' or 'Install Plugin'"
echo "  4. Select the .fpa file"
echo "  5. Enable the plugin after installation"
echo ""

print_info "Manual Installation:"
echo "  1. Extract: unzip $DIST_DIR/$FPA_FILE -d /path/to/featherpanel/plugins/"
echo "  2. Set permissions: chown -R www-data:www-data /path/to/featherpanel/plugins/$PLUGIN_NAME"
echo "  3. Restart FeatherPanel: systemctl restart featherpanel"
echo ""

print_warning "Remember to configure the plugin by editing config.json after installation!"
echo ""

# Optional: Show package contents
if [ "$1" == "--verbose" ] || [ "$1" == "-v" ]; then
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}Package Contents:${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
    unzip -l "$DIST_DIR/$FPA_FILE"
    echo ""
fi

print_status "Build process completed successfully!"
echo ""

exit 0
