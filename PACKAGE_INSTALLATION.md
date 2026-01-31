# Custom Branding Plugin - Installation & Configuration Guide

## 📦 Package Information

**File:** `CustomBranding-v1.0.0.fpa`  
**Version:** 1.0.0  
**Size:** ~42KB  
**Files:** 28 files  
**Author:** 2IceCube  

## 🎯 What This Plugin Does

The Custom Branding Plugin allows you to:
- ✅ Remove all default FeatherPanel watermarks
- ✅ Remove all default FeatherPanel footers
- ✅ Add custom footer text with dynamic variables
- ✅ Add custom watermark text
- ✅ Use custom logo URLs
- ✅ Configure copyright information
- ✅ Easy admin panel configuration (FeatherPanel v2)

## 📋 Requirements

### For FeatherPanel v2 (PHP)
- FeatherPanel v2 or higher
- PHP 8.1 or higher
- Admin access to FeatherPanel

### For FeatherPanel v1 (Node.js - Legacy)
- FeatherPanel v1.x
- Node.js 14 or higher
- Admin access to FeatherPanel

## 🚀 Installation

### Method 1: Admin Panel Upload (FeatherPanel v2 - Recommended)

1. **Download the Package**
   - Download `CustomBranding-v1.0.0.fpa` from the repository

2. **Access FeatherPanel Admin Panel**
   - Log in to your FeatherPanel admin panel
   - Navigate to **Plugins** or **Addons** section

3. **Upload Plugin**
   - Click **Upload Plugin** or **Install Plugin**
   - Select the `CustomBranding-v1.0.0.fpa` file
   - Click **Install** or **Upload**
   - Wait for the installation to complete

4. **Enable the Plugin**
   - Go to **Plugins** → **Installed Plugins**
   - Find "Custom Branding Plugin"
   - Click **Enable** or toggle the switch

5. **Configure the Plugin**
   - Click **Configure** or **Settings** next to the plugin
   - Adjust settings as needed (see Configuration section below)
   - Click **Save Changes**

### Method 2: Manual Installation (All Versions)

1. **Extract the Package**
   ```bash
   unzip CustomBranding-v1.0.0.fpa -d /tmp/
   ```

2. **Copy to Plugins Directory**
   ```bash
   # For FeatherPanel v2 (identifier must match conf.yml)
   cp -r /tmp/CustomBranding /path/to/featherpanel/plugins/custom_branding
   
   # For FeatherPanel v1
   cp -r /tmp/CustomBranding /path/to/featherpanel/plugins/CustomBranding
   ```

3. **Set Proper Permissions**
   ```bash
   chown -R www-data:www-data /path/to/featherpanel/plugins/custom_branding
   chmod -R 755 /path/to/featherpanel/plugins/custom_branding
   ```

4. **Restart FeatherPanel**
   ```bash
   systemctl restart featherpanel
   # or
   pm2 restart featherpanel
   ```

5. **Enable in Admin Panel**
   - Log in to FeatherPanel admin panel
   - Navigate to **Plugins**
   - Enable "Custom Branding Plugin"

## ⚙️ Configuration

### FeatherPanel v2 Configuration (via Admin Panel)

After installation, configure the plugin through the admin panel:

1. **Navigate to Plugin Settings**
   - Plugins → Custom Branding Plugin → Configure

2. **Core Settings**

   | Setting | Description | Example |
   |---------|-------------|---------|
   | **Enable Watermark Removal** | Remove all default FeatherPanel watermarks | ✅ Yes |
   | **Enable Footer Removal** | Remove all default FeatherPanel footer elements | ✅ Yes |

3. **Custom Branding Settings**

   | Setting | Description | Example |
   |---------|-------------|---------|
   | **Custom Footer Text** | Custom footer text (max 200 chars). Supports `{year}` and `{copyright}` variables | `© {year} {copyright}. All rights reserved.` |
   | **Custom Watermark Text** | Custom watermark text (max 100 chars) | `Powered by MyCompany` |
   | **Custom Logo URL** | HTTPS URL for custom logo | `https://example.com/logo.png` |
   | **Copyright Text** | Copyright information (max 150 chars). Supports `{year}` variable | `MyCompany Inc.` |

4. **Save Configuration**
   - Click **Save Changes**
   - Refresh your FeatherPanel page to see changes

### FeatherPanel v1 Configuration (via config.json)

For legacy installations, edit the configuration file:

```bash
nano /path/to/featherpanel/plugins/CustomBranding/config.json
```

See `config.example.json` for all available options.

## 📝 Configuration Examples

### Example 1: Remove All Branding (Clean Panel)

**FeatherPanel v2 Settings:**
```
Enable Watermark Removal: Yes
Enable Footer Removal: Yes
Custom Footer Text: (leave empty)
Custom Watermark Text: (leave empty)
Custom Logo URL: (leave empty)
Copyright Text: (leave empty)
```

**Result:** Complete removal of all branding elements

### Example 2: Custom Footer Only

**FeatherPanel v2 Settings:**
```
Enable Watermark Removal: Yes
Enable Footer Removal: Yes
Custom Footer Text: © {year} MyCompany. All rights reserved.
Custom Watermark Text: (leave empty)
Custom Logo URL: (leave empty)
Copyright Text: MyCompany Inc.
```

**Result:** Clean panel with custom footer showing "© 2024 MyCompany Inc. All rights reserved."

### Example 3: Complete Custom Branding

**FeatherPanel v2 Settings:**
```
Enable Watermark Removal: Yes
Enable Footer Removal: Yes
Custom Footer Text: © {year} {copyright} | Powered by MyBrand | Privacy Policy
Custom Watermark Text: MyBrand Panel v2
Custom Logo URL: https://mycompany.com/logo.png
Copyright Text: MyCompany Inc.
```

**Result:** Fully branded panel with custom logo, footer, and watermark

### Example 4: Custom Watermark Only

**FeatherPanel v2 Settings:**
```
Enable Watermark Removal: Yes
Enable Footer Removal: No
Custom Footer Text: (leave empty)
Custom Watermark Text: Powered by MyBrand
Custom Logo URL: (leave empty)
Copyright Text: (leave empty)
```

**Result:** Default footer remains, custom watermark appears in bottom-right

## 🎨 Variable Replacements

Use these dynamic variables in your text fields:

| Variable | Description | Example Output |
|----------|-------------|----------------|
| `{year}` | Current year | `2024` |
| `{copyright}` | Value from Copyright Text field | `MyCompany Inc.` |

**Example Usage:**
```
Custom Footer Text: © {year} {copyright}. All rights reserved.
Copyright Text: MyCompany Inc.

Output: © 2024 MyCompany Inc. All rights reserved.
```

## ✅ Verification

After installation and configuration:

1. **Check Plugin Status**
   - Go to **Plugins** → **Installed Plugins**
   - Verify "Custom Branding Plugin" is enabled
   - Check for any error messages

2. **Clear Browser Cache**
   - Press `Ctrl + F5` (Windows/Linux)
   - Press `Cmd + Shift + R` (Mac)
   - Or clear cache through browser settings

3. **Verify Changes**
   - Check if default watermarks are removed
   - Check if default footer is removed
   - Verify custom branding appears correctly

4. **Check Console for Errors**
   - Press `F12` to open developer tools
   - Check Console tab for any JavaScript errors
   - Check Network tab for failed requests

## 🔧 Troubleshooting

### Problem: Plugin Doesn't Appear in Admin Panel

**Solutions:**
1. Verify `conf.yml` exists in plugin directory
2. Check file name is exactly `conf.yml` (lowercase)
3. Check file permissions: `chmod 644 conf.yml`
4. Restart FeatherPanel: `systemctl restart featherpanel`
5. Check logs: `tail -f /var/log/featherpanel/error.log`

### Problem: "Invalid addon: missing conf.yml" Error

**Solutions:**
1. Ensure plugin directory name matches identifier in `conf.yml` (`custom_branding`)
2. Verify `conf.yml` is in root of plugin directory, not subdirectory
3. Check YAML syntax is valid
4. Rebuild package with correct structure

### Problem: Watermarks Still Showing

**Solutions:**
1. Verify "Enable Watermark Removal" is set to **Yes**
2. Clear browser cache completely
3. Check if theme overrides are conflicting
4. Verify plugin is enabled
5. Inspect page HTML to see if CSS is being applied

### Problem: Custom Footer Not Appearing

**Solutions:**
1. Ensure "Enable Footer Removal" is set to **Yes**
2. Verify "Custom Footer Text" field is not empty
3. Check variable syntax: `{year}` and `{copyright}` must be lowercase
4. Clear browser cache
5. Check browser console for errors

### Problem: Configuration Not Saving

**Solutions:**
1. Check file permissions on plugin directory
2. Verify database write permissions
3. Check FeatherPanel logs: `tail -f /var/log/featherpanel/error.log`
4. Try clearing FeatherPanel cache
5. Ensure user has admin permissions

### Problem: 404 Error for Custom Logo

**Solutions:**
1. Verify logo URL is valid and accessible
2. Ensure URL uses HTTPS (HTTP is not allowed)
3. Check logo file exists on server
4. Verify URL has no typos
5. Test URL in browser directly

## 📊 Package Contents

The `.fpa` package includes:

### Critical Files (FeatherPanel v2):
- ✅ `conf.yml` - Plugin configuration (REQUIRED)
- ✅ `Plugin.php` - Main plugin class
- ✅ `events/BrandingEvents.php` - Event handlers

### Legacy Files (FeatherPanel v1):
- `addon.json` - Legacy manifest
- `src/index.js` - Legacy JavaScript code
- `config.json` - Legacy configuration

### Documentation:
- `README_PHP.md` - PHP/v2 documentation
- `README.md` - General documentation
- `PACKAGE_GUIDE.md` - Package guide
- `INSTALLATION.md` - Installation guide
- `QUICKSTART.md` - Quick start guide
- `CHANGELOG.md` - Version history

### Assets:
- `assets/custom-branding.css` - CSS styles
- `examples/` - Configuration examples
- `LICENSE` - MIT License

## 🔒 Security

### Validation
- All text inputs are validated and sanitized
- URL inputs must use HTTPS
- Length limits enforced on all fields
- XSS protection via HTML escaping

### Permissions
- Only administrators can install and configure
- Configuration requires admin panel access
- No remote code execution capabilities

### Best Practices
1. Always use HTTPS URLs for logos
2. Keep plugin updated to latest version
3. Review configuration changes before saving
4. Test in staging environment first
5. Backup configuration before major changes

## 📞 Support

### Documentation
- **PHP/v2 Guide:** See `README_PHP.md` in package
- **Legacy Guide:** See `README.md` in package
- **Package Guide:** See `PACKAGE_GUIDE.md` in package

### Community
- **FeatherPanel Discord:** https://discord.mythical.systems
- **GitHub Issues:** https://github.com/2IceCube/CX/issues
- **FeatherPanel Forums:** Check official forums

### Getting Help

When asking for help, please provide:
1. FeatherPanel version
2. PHP version (for v2)
3. Plugin version (1.0.0)
4. Configuration settings (without sensitive data)
5. Error messages from logs
6. Steps to reproduce the issue

## 📜 License

MIT License - Free to use, modify, and distribute

## 🙏 Credits

- **Author:** 2IceCube
- **FeatherPanel:** MysticsSystems
- **Community:** FeatherPanel Discord

---

**Plugin Version:** 1.0.0  
**Last Updated:** 2024-01-31  
**Status:** Production Ready ✅  
**Compatibility:** FeatherPanel v1 & v2

**Made with ❤️ for the FeatherPanel community**
