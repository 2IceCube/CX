# FeatherPanel Plugin Package Guide

## Package: CustomBranding-v1.0.0.fpa

This package contains the Custom Branding Plugin for FeatherPanel.

## What's Inside

This .fpa package includes:

### FeatherPanel v2 (PHP) Files:
- ✅ **conf.yml** - Plugin configuration (REQUIRED for v2)
- ✅ **Plugin.php** - Main plugin class
- ✅ **events/BrandingEvents.php** - Event handlers
- ✅ **README_PHP.md** - PHP/v2 documentation

### Legacy FeatherPanel v1 (Node.js) Files:
- **addon.json** - Legacy plugin manifest
- **src/index.js** - Legacy plugin code
- **config.json** - Legacy configuration

### Common Files:
- **assets/custom-branding.css** - CSS styles
- **LICENSE** - MIT License
- **Documentation** - README.md, INSTALLATION.md, etc.

## Installation

### FeatherPanel v2 (Recommended)

1. **Upload Plugin**:
   - Log in to FeatherPanel admin panel
   - Navigate to **Plugins** → **Upload Plugin**
   - Select `CustomBranding-v1.0.0.fpa`
   - Click **Install**

2. **Enable Plugin**:
   - Go to **Plugins** → **Installed Plugins**
   - Find "Custom Branding Plugin"
   - Click **Enable**

3. **Configure**:
   - Click **Configure** or **Settings**
   - Adjust settings:
     - Enable Watermark Removal: Yes
     - Enable Footer Removal: Yes
     - Custom Footer Text: "© {year} MyCompany"
     - (and other options)
   - Click **Save**

4. **Verify**:
   - Refresh FeatherPanel
   - Watermarks and footers should be removed
   - Your custom branding should appear

### FeatherPanel v1 (Legacy)

1. **Extract Package**:
   ```bash
   unzip CustomBranding-v1.0.0.fpa -d /path/to/featherpanel/plugins/
   ```

2. **Set Permissions**:
   ```bash
   chown -R www-data:www-data /path/to/featherpanel/plugins/CustomBranding
   ```

3. **Edit Configuration**:
   ```bash
   nano /path/to/featherpanel/plugins/CustomBranding/config.json
   ```

4. **Restart FeatherPanel**:
   ```bash
   systemctl restart featherpanel
   ```

## Configuration Options

### For FeatherPanel v2 (via Admin Panel)

| Setting | Description | Default |
|---------|-------------|---------|
| **Enable Watermark Removal** | Remove all default watermarks | Yes |
| **Enable Footer Removal** | Remove all default footers | Yes |
| **Custom Footer Text** | Your custom footer text (max 200 chars) | (empty) |
| **Custom Watermark Text** | Your custom watermark (max 100 chars) | (empty) |
| **Custom Logo URL** | HTTPS URL for your logo | (empty) |
| **Copyright Text** | Copyright information (max 150 chars) | (empty) |

### Variable Replacements

Use these variables in your text:
- `{year}` - Current year (e.g., "2024")
- `{copyright}` - Your copyright text

**Example Footer Text:**
```
© {year} {copyright}. All rights reserved. | Powered by MyCompany
```

## Features

✅ Remove default FeatherPanel watermarks  
✅ Remove default FeatherPanel footers  
✅ Add custom footer with variable replacement  
✅ Add custom watermark  
✅ Custom logo support  
✅ Copyright information  
✅ Admin panel configuration (v2)  
✅ PHP 8.1+ compatible  
✅ Event-driven architecture  

## Requirements

- **FeatherPanel v2**: PHP 8.1 or higher
- **FeatherPanel v1**: Node.js 14+ (legacy)
- Admin access for installation

## Support

- 📖 Documentation: See README_PHP.md (v2) or README.md (v1)
- 💬 Discord: https://discord.mythical.systems
- 🐛 Issues: https://github.com/2IceCube/CX/issues

## License

MIT License - Free to use and modify

---

**Plugin Version**: 1.0.0  
**Package Date**: 2024-01-31  
**Author**: 2IceCube  
**Status**: Production Ready ✅
