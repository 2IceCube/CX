#!/bin/bash

###############################################################################
# FeatherPanel Plugin Archive (FPA) Verification Script
# Validates the .fpa package structure and contents
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

# Configuration
PLUGIN_NAME="CustomBranding"
FPA_FILE="dist/CustomBranding-v1.0.0.fpa"
VERIFY_DIR="verify_tmp"

echo -e "${BLUE}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  FeatherPanel Plugin Archive Verifier                   ║${NC}"
echo -e "${BLUE}║  Custom Branding Plugin v1.0.0                          ║${NC}"
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

# Track verification status
ERRORS=0
WARNINGS=0

# Check if .fpa file exists
if [ ! -f "$FPA_FILE" ]; then
    print_error "Package file not found: $FPA_FILE"
    echo ""
    print_info "Please run './build.sh' first to create the package"
    exit 1
fi

print_status "Package file found: $FPA_FILE"
echo ""

# Get package information
print_info "Package Information:"
PACKAGE_SIZE=$(du -h "$FPA_FILE" | cut -f1)
echo "  Size: $PACKAGE_SIZE"

# Verify ZIP integrity
print_info "Verifying ZIP integrity..."
if unzip -t "$FPA_FILE" >/dev/null 2>&1; then
    print_status "ZIP integrity check passed"
else
    print_error "ZIP integrity check failed - package is corrupted"
    ERRORS=$((ERRORS + 1))
fi
echo ""

# Extract package for verification
print_info "Extracting package for verification..."
rm -rf "$VERIFY_DIR"
mkdir -p "$VERIFY_DIR"

if unzip -q "$FPA_FILE" -d "$VERIFY_DIR"; then
    print_status "Package extracted successfully"
else
    print_error "Failed to extract package"
    exit 1
fi
echo ""

# Verify directory structure
print_info "Verifying directory structure..."

if [ -d "$VERIFY_DIR/$PLUGIN_NAME" ]; then
    print_status "Root plugin directory exists"
else
    print_error "Root plugin directory missing: $PLUGIN_NAME"
    ERRORS=$((ERRORS + 1))
fi
echo ""

# Verify required files
print_info "Verifying required files..."

REQUIRED_FILES=(
    "$VERIFY_DIR/$PLUGIN_NAME/addon.json"
    "$VERIFY_DIR/$PLUGIN_NAME/package.json"
    "$VERIFY_DIR/$PLUGIN_NAME/config.json"
    "$VERIFY_DIR/$PLUGIN_NAME/src/index.js"
    "$VERIFY_DIR/$PLUGIN_NAME/README.md"
    "$VERIFY_DIR/$PLUGIN_NAME/LICENSE"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        print_status "  $(basename "$file")"
    else
        print_error "  Missing required file: $(basename "$file")"
        ERRORS=$((ERRORS + 1))
    fi
done
echo ""

# Verify addon.json structure
print_info "Verifying addon.json structure..."

ADDON_JSON="$VERIFY_DIR/$PLUGIN_NAME/addon.json"
if [ -f "$ADDON_JSON" ]; then
    # Check if valid JSON
    if python3 -m json.tool "$ADDON_JSON" >/dev/null 2>&1 || jq empty "$ADDON_JSON" >/dev/null 2>&1; then
        print_status "addon.json is valid JSON"
        
        # Check required fields (basic check with grep)
        REQUIRED_FIELDS=("id" "name" "version" "author" "main")
        for field in "${REQUIRED_FIELDS[@]}"; do
            if grep -q "\"$field\"" "$ADDON_JSON"; then
                print_status "  Field '$field' present"
            else
                print_error "  Missing required field: $field"
                ERRORS=$((ERRORS + 1))
            fi
        done
    else
        print_error "addon.json is not valid JSON"
        ERRORS=$((ERRORS + 1))
    fi
else
    print_error "addon.json file not found"
    ERRORS=$((ERRORS + 1))
fi
echo ""

# Verify package.json structure
print_info "Verifying package.json structure..."

PACKAGE_JSON="$VERIFY_DIR/$PLUGIN_NAME/package.json"
if [ -f "$PACKAGE_JSON" ]; then
    # Check if valid JSON
    if python3 -m json.tool "$PACKAGE_JSON" >/dev/null 2>&1 || jq empty "$PACKAGE_JSON" >/dev/null 2>&1; then
        print_status "package.json is valid JSON"
    else
        print_error "package.json is not valid JSON"
        ERRORS=$((ERRORS + 1))
    fi
else
    print_error "package.json file not found"
    ERRORS=$((ERRORS + 1))
fi
echo ""

# Verify config.json structure
print_info "Verifying config.json structure..."

CONFIG_JSON="$VERIFY_DIR/$PLUGIN_NAME/config.json"
if [ -f "$CONFIG_JSON" ]; then
    # Check if valid JSON
    if python3 -m json.tool "$CONFIG_JSON" >/dev/null 2>&1 || jq empty "$CONFIG_JSON" >/dev/null 2>&1; then
        print_status "config.json is valid JSON"
        
        # Check for main configuration sections
        CONFIG_SECTIONS=("branding" "styling" "advanced")
        for section in "${CONFIG_SECTIONS[@]}"; do
            if grep -q "\"$section\"" "$CONFIG_JSON"; then
                print_status "  Section '$section' present"
            else
                print_warning "  Section '$section' not found"
                WARNINGS=$((WARNINGS + 1))
            fi
        done
    else
        print_error "config.json is not valid JSON"
        ERRORS=$((ERRORS + 1))
    fi
else
    print_error "config.json file not found"
    ERRORS=$((ERRORS + 1))
fi
echo ""

# Verify source code
print_info "Verifying source code..."

INDEX_JS="$VERIFY_DIR/$PLUGIN_NAME/src/index.js"
if [ -f "$INDEX_JS" ]; then
    print_status "index.js exists"
    
    # Check file size (should be reasonable)
    FILE_SIZE=$(wc -c < "$INDEX_JS")
    if [ "$FILE_SIZE" -gt 100 ]; then
        print_status "index.js has content ($FILE_SIZE bytes)"
    else
        print_warning "index.js seems too small ($FILE_SIZE bytes)"
        WARNINGS=$((WARNINGS + 1))
    fi
    
    # Check for key classes/exports
    if grep -q "module.exports" "$INDEX_JS" || grep -q "export" "$INDEX_JS"; then
        print_status "index.js has exports"
    else
        print_warning "index.js may not export anything"
        WARNINGS=$((WARNINGS + 1))
    fi
else
    print_error "index.js not found"
    ERRORS=$((ERRORS + 1))
fi
echo ""

# Verify assets
print_info "Verifying assets..."

if [ -d "$VERIFY_DIR/$PLUGIN_NAME/assets" ]; then
    print_status "assets/ directory exists"
    
    CSS_FILE="$VERIFY_DIR/$PLUGIN_NAME/assets/custom-branding.css"
    if [ -f "$CSS_FILE" ]; then
        print_status "custom-branding.css exists"
    else
        print_warning "custom-branding.css not found"
        WARNINGS=$((WARNINGS + 1))
    fi
else
    print_warning "assets/ directory not found"
    WARNINGS=$((WARNINGS + 1))
fi
echo ""

# Verify examples
print_info "Verifying examples..."

if [ -d "$VERIFY_DIR/$PLUGIN_NAME/examples" ]; then
    print_status "examples/ directory exists"
    
    EXAMPLE_COUNT=$(find "$VERIFY_DIR/$PLUGIN_NAME/examples" -name "*.json" | wc -l)
    if [ "$EXAMPLE_COUNT" -gt 0 ]; then
        print_status "Found $EXAMPLE_COUNT example configuration(s)"
    else
        print_warning "No example configurations found"
        WARNINGS=$((WARNINGS + 1))
    fi
else
    print_warning "examples/ directory not found"
    WARNINGS=$((WARNINGS + 1))
fi
echo ""

# Verify documentation
print_info "Verifying documentation..."

DOC_FILES=("README.md" "INSTALLATION.md" "LICENSE")
for doc in "${DOC_FILES[@]}"; do
    if [ -f "$VERIFY_DIR/$PLUGIN_NAME/$doc" ]; then
        FILE_SIZE=$(wc -c < "$VERIFY_DIR/$PLUGIN_NAME/$doc")
        print_status "  $doc ($FILE_SIZE bytes)"
    else
        print_warning "  $doc not found"
        WARNINGS=$((WARNINGS + 1))
    fi
done
echo ""

# Check for unwanted files
print_info "Checking for unwanted files..."

UNWANTED_PATTERNS=(".git" "node_modules" ".DS_Store" "*.swp" "*.tmp" ".env")
UNWANTED_FOUND=0

for pattern in "${UNWANTED_PATTERNS[@]}"; do
    if find "$VERIFY_DIR/$PLUGIN_NAME" -name "$pattern" | grep -q .; then
        print_warning "  Found unwanted files matching: $pattern"
        UNWANTED_FOUND=$((UNWANTED_FOUND + 1))
    fi
done

if [ "$UNWANTED_FOUND" -eq 0 ]; then
    print_status "No unwanted files found"
else
    print_warning "Found $UNWANTED_FOUND unwanted file pattern(s)"
    WARNINGS=$((WARNINGS + $UNWANTED_FOUND))
fi
echo ""

# File count and size summary
print_info "Package Summary:"
FILE_COUNT=$(find "$VERIFY_DIR/$PLUGIN_NAME" -type f | wc -l)
TOTAL_SIZE=$(du -sh "$VERIFY_DIR/$PLUGIN_NAME" | cut -f1)
echo "  Total files: $FILE_COUNT"
echo "  Total size: $TOTAL_SIZE"
echo ""

# Clean up
print_info "Cleaning up verification directory..."
rm -rf "$VERIFY_DIR"
print_status "Cleanup completed"
echo ""

# Display results
echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}Verification Results${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"

if [ "$ERRORS" -eq 0 ] && [ "$WARNINGS" -eq 0 ]; then
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  ALL CHECKS PASSED! ✓                                   ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    print_status "Package is valid and ready for distribution"
    echo ""
    print_info "Next steps:"
    echo "  1. Test installation in a FeatherPanel instance"
    echo "  2. Verify all features work correctly"
    echo "  3. Create a GitHub release with the .fpa file"
    echo ""
    exit 0
elif [ "$ERRORS" -eq 0 ]; then
    echo -e "${YELLOW}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║  VERIFICATION PASSED WITH WARNINGS                      ║${NC}"
    echo -e "${YELLOW}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    print_warning "Found $WARNINGS warning(s)"
    print_info "Package is functional but could be improved"
    echo ""
    exit 0
else
    echo -e "${RED}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║  VERIFICATION FAILED                                     ║${NC}"
    echo -e "${RED}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    print_error "Found $ERRORS error(s) and $WARNINGS warning(s)"
    print_info "Please fix the errors before distributing the package"
    echo ""
    exit 1
fi
