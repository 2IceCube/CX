# CX - Custom Extensions for FeatherPanel

This repository contains custom extensions and plugins for FeatherPanel by MysticsSystems.

## Custom Branding Plugin

A powerful plugin that removes all default FeatherPanel watermarks and footers, allowing you to customize your panel with your own branding elements.

### Features

- ✅ Remove default watermarks and footers
- ✅ Add custom footer text and links
- ✅ Add custom watermarks with position control
- ✅ Logo customization
- ✅ Full styling control
- ✅ Easy configuration via JSON

### Quick Start

#### Option 1: Install from .fpa Package (Recommended)

```bash
# Build the .fpa package
cd CustomBranding
./build.sh

# Upload dist/CustomBranding-v1.0.0.fpa to your FeatherPanel admin panel
# Navigate to Plugins → Upload Plugin → Select .fpa file
```

#### Option 2: Install from Source

```bash
# Copy plugin to FeatherPanel plugins directory
cp -r CustomBranding /path/to/featherpanel/plugins/

# Restart FeatherPanel
systemctl restart featherpanel
```

### Documentation

- **[Full Documentation](CustomBranding/README.md)** - Complete feature overview and usage guide
- **[Build Guide](CustomBranding/BUILD.md)** - How to create .fpa package
- **[Installation Guide](CustomBranding/INSTALLATION.md)** - Detailed installation instructions  
- **[Quick Start Guide](CustomBranding/QUICKSTART.md)** - Get started in 5 minutes
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