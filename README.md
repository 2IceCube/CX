# CX - Custom Extensions for FeatherPanel

This repository contains custom extensions and plugins for FeatherPanel by MysticsSystems.

## Custom Branding Plugin

A powerful plugin that removes all default FeatherPanel watermarks and footers, allowing you to customize your panel with your own branding elements.

**🎯 Now with full FeatherPanel v2 support!** Includes `conf.yml` configuration and PHP implementation.

### Features

- ✅ Remove default watermarks and footers
- ✅ Add custom footer text and links
- ✅ Add custom watermarks with position control
- ✅ Logo customization
- ✅ Full styling control
- ✅ Admin panel configuration (FeatherPanel v2)
- ✅ PHP 8.1+ compatible with event system
- ✅ Easy configuration via conf.yml or JSON (legacy)

### Quick Start

#### Option 1: Install from .fpa Package (Recommended)

```bash
# Download or build the .fpa package
cd CustomBranding
./build.sh

# Upload CustomBranding-v1.0.0.fpa to your FeatherPanel admin panel
# Navigate to Plugins → Upload Plugin → Select .fpa file
# Configure via admin panel settings
```

#### Option 2: Install from Source

```bash
# Copy plugin to FeatherPanel plugins directory
cp -r CustomBranding /path/to/featherpanel/plugins/custom_branding

# Set permissions
chown -R www-data:www-data /path/to/featherpanel/plugins/custom_branding

# Restart FeatherPanel
systemctl restart featherpanel
```

### FeatherPanel Version Support

This plugin supports both legacy and modern FeatherPanel installations:

- **FeatherPanel v2+** (PHP): Uses `conf.yml` + `Plugin.php` with admin panel configuration
- **FeatherPanel v1** (Node.js): Uses `addon.json` + `src/index.js` with JSON configuration

The .fpa package includes both implementations for maximum compatibility.

### Documentation

#### For FeatherPanel v2 (PHP/conf.yml)
- **[PHP Documentation](CustomBranding/README_PHP.md)** - Complete guide for FeatherPanel v2
- **[conf.yml](CustomBranding/conf.yml)** - Plugin configuration schema
- **[Plugin.php](CustomBranding/Plugin.php)** - Main plugin class

#### For FeatherPanel v1 (Node.js/JSON)
- **[Legacy Documentation](CustomBranding/README.md)** - Complete feature overview and usage guide
- **[Build Guide](CustomBranding/BUILD.md)** - How to create .fpa package
- **[Installation Guide](CustomBranding/INSTALLATION.md)** - Detailed installation instructions  
- **[Quick Start Guide](CustomBranding/QUICKSTART.md)** - Get started in 5 minutes

#### General
- **[Changelog](CustomBranding/CHANGELOG.md)** - Version history

### Configuration Examples

See the `CustomBranding/examples/` folder for ready-to-use configuration examples:

- `minimal-example.json` - Remove all branding without customization
- `footer-only-example.json` - Just replace the footer
- `full-branding-example.json` - Complete custom branding
- `watermark-only-example.json` - Add custom watermark

### License

MIT License - See [LICENSE](CustomBranding/LICENSE) for details

### Support

For issues or questions:
- Check the [documentation](CustomBranding/README.md)
- Visit [FeatherPanel Discord](https://discord.mythical.systems)
- Open an issue on this repository

---

**Made with ❤️ for the FeatherPanel community**