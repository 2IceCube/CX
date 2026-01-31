# FeatherPanel Plugin Archive (.fpa) - Package Information

## What is this file?

This is a **FeatherPanel Plugin Archive (.fpa)** - a packaged plugin for FeatherPanel by MysticsSystems.

- **Plugin Name**: Custom Branding Plugin
- **Version**: 1.0.0
- **Author**: MysticsSystems
- **Package Format**: .fpa (ZIP-based archive)

## Installation

### Method 1: Via FeatherPanel Admin Panel (Recommended)

1. Log into your FeatherPanel admin dashboard
2. Navigate to **Settings** → **Plugins** or **Addons**
3. Click **Upload Plugin** or **Install Plugin**
4. Select this `.fpa` file
5. Click **Install**
6. Enable the plugin once installation completes

### Method 2: Manual Installation

```bash
# Extract the .fpa file (it's a ZIP archive)
unzip CustomBranding-v1.0.0.fpa -d /path/to/featherpanel/plugins/

# Set proper permissions
sudo chown -R www-data:www-data /path/to/featherpanel/plugins/CustomBranding
sudo chmod -R 755 /path/to/featherpanel/plugins/CustomBranding

# Restart FeatherPanel
sudo systemctl restart featherpanel
```

## What's Inside?

This package contains:

- **Plugin Source Code** - Main plugin logic (src/index.js)
- **Configuration Files** - Default and example configurations
- **Assets** - CSS stylesheets and other resources
- **Documentation** - README, installation guide, and quick start
- **Examples** - Sample configuration files for different use cases
- **License** - MIT License

## Package Contents

```
CustomBranding/
├── addon.json              # Plugin manifest
├── package.json            # Package metadata
├── config.json             # Default configuration
├── config.example.json     # Example configuration
├── src/
│   └── index.js           # Main plugin code
├── assets/
│   └── custom-branding.css
├── examples/
│   ├── minimal-example.json
│   ├── footer-only-example.json
│   ├── full-branding-example.json
│   └── watermark-only-example.json
├── LICENSE                 # MIT License
├── README.md               # Main documentation
├── INSTALLATION.md         # Installation guide
├── QUICKSTART.md           # Quick start guide
└── CHANGELOG.md            # Version history
```

## After Installation

1. **Configure the Plugin**
   - Edit `CustomBranding/config.json` to customize your branding
   - See examples in `CustomBranding/examples/` for inspiration

2. **Verify Installation**
   - Check that the plugin appears in your FeatherPanel plugins list
   - Enable the plugin if not already enabled
   - Refresh your browser to see changes

3. **Documentation**
   - Read `CustomBranding/README.md` for complete feature documentation
   - See `CustomBranding/QUICKSTART.md` for a 5-minute setup guide
   - Check `CustomBranding/INSTALLATION.md` for detailed installation help

## Features

- ✅ Remove default FeatherPanel watermarks
- ✅ Remove default footer branding
- ✅ Add custom footer text and links
- ✅ Add custom watermark with position control
- ✅ Logo customization
- ✅ Copyright information with auto-year
- ✅ Advanced styling options
- ✅ Context-aware branding (admin/client areas)

## Requirements

- **FeatherPanel**: Version 1.0.0 or higher
- **Node.js**: Version 14.0.0 or higher (if required by FeatherPanel)
- **Permissions**: Administrative access to FeatherPanel

## Support

For help with installation or configuration:

1. Read the included documentation in the package
2. Visit the [GitHub Repository](https://github.com/2IceCube/CX)
3. Join the [FeatherPanel Discord](https://discord.mythical.systems)
4. Open an issue on GitHub

## Package Verification

To verify this package hasn't been tampered with:

1. Check the file size (should be around 30-35 KB)
2. Verify it's a valid ZIP file: `unzip -t CustomBranding-v1.0.0.fpa`
3. Check contents: `unzip -l CustomBranding-v1.0.0.fpa`

## License

This plugin is released under the MIT License. See the LICENSE file included in the package for details.

## Building from Source

If you want to build this package from source:

1. Clone the repository: `git clone https://github.com/2IceCube/CX.git`
2. Navigate to plugin directory: `cd CX/CustomBranding`
3. Run build script: `./build.sh`
4. Package will be created in: `dist/CustomBranding-v1.0.0.fpa`

See `BUILD.md` in the source repository for complete build instructions.

---

**Plugin Version**: 1.0.0  
**Package Date**: 2024-01-31  
**Format**: FeatherPanel Plugin Archive (.fpa)  
**Compatibility**: FeatherPanel 1.0.0+

For more information, visit: https://github.com/2IceCube/CX
