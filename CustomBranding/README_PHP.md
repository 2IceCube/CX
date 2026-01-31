# Custom Branding Plugin for FeatherPanel v2

A complete FeatherPanel v2 plugin that removes all default watermarks and footers, allowing you to fully customize your panel's branding.

## 🌟 Features

- ✅ **Remove Default Watermarks** - Completely remove FeatherPanel's default watermarks
- ✅ **Remove Default Footers** - Remove all default footer elements
- ✅ **Custom Footer Text** - Add your own footer text with variable replacements
- ✅ **Custom Watermark** - Add custom watermark/branding text
- ✅ **Custom Logo** - Replace the default logo with your own
- ✅ **Copyright Information** - Add custom copyright text
- ✅ **Admin Panel Configuration** - Easy configuration through FeatherPanel admin interface
- ✅ **PHP 8.1+ Compatible** - Modern PHP implementation
- ✅ **Event-Driven Architecture** - Uses FeatherPanel's event system

## 📋 Requirements

- FeatherPanel v2 or higher
- PHP 8.1 or higher
- FeatherPanel admin access for installation

## 📦 Installation

### Method 1: Install from .fpa Package (Recommended)

1. **Build the .fpa package** (if not already built):
   ```bash
   cd CustomBranding
   ./build.sh
   ```

2. **Upload to FeatherPanel**:
   - Log in to your FeatherPanel admin panel
   - Navigate to **Plugins** → **Upload Plugin**
   - Select the `CustomBranding-v1.0.0.fpa` file
   - Click **Install**
   - Enable the plugin

### Method 2: Install from Source

1. **Copy plugin to FeatherPanel plugins directory**:
   ```bash
   cp -r CustomBranding /path/to/featherpanel/plugins/custom_branding
   ```

2. **Set proper permissions**:
   ```bash
   chown -R www-data:www-data /path/to/featherpanel/plugins/custom_branding
   chmod -R 755 /path/to/featherpanel/plugins/custom_branding
   ```

3. **Restart FeatherPanel**:
   ```bash
   systemctl restart featherpanel
   ```

4. **Enable the plugin** in the FeatherPanel admin panel

## ⚙️ Configuration

### Access Configuration

1. Log in to FeatherPanel admin panel
2. Navigate to **Plugins** → **Custom Branding Plugin**
3. Click **Configure** or **Settings**

### Configuration Options

| Setting | Type | Description | Default |
|---------|------|-------------|---------|
| **Enable Watermark Removal** | Boolean | Remove all default FeatherPanel watermarks | `true` |
| **Enable Footer Removal** | Boolean | Remove all default FeatherPanel footer elements | `true` |
| **Custom Footer Text** | Text (max 200 chars) | Custom text to display in footer. Supports `{year}` and `{copyright}` variables | _(empty)_ |
| **Custom Watermark Text** | Text (max 100 chars) | Custom watermark or branding text | _(empty)_ |
| **Custom Logo URL** | URL | URL for custom logo image (must be HTTPS) | _(empty)_ |
| **Copyright Text** | Text (max 150 chars) | Custom copyright information. Supports `{year}` variable | _(empty)_ |

### Variable Replacements

The following variables can be used in text fields:

- **`{year}`** - Automatically replaced with the current year
- **`{copyright}`** - Replaced with the copyright text (in footer only)

**Example:**
```
Custom Footer Text: "© {year} {copyright}. All rights reserved."
Copyright Text: "MyCompany Inc."

Result: "© 2024 MyCompany Inc. All rights reserved."
```

## 🎨 Usage Examples

### Example 1: Remove All Branding

**Configuration:**
- Enable Watermark Removal: `Yes`
- Enable Footer Removal: `Yes`
- Leave all other fields empty

**Result:** Clean panel with no watermarks or footer branding

### Example 2: Custom Footer Only

**Configuration:**
- Enable Watermark Removal: `Yes`
- Enable Footer Removal: `Yes`
- Custom Footer Text: `© {year} MyCompany. All rights reserved.`
- Copyright Text: `MyCompany Inc.`

**Result:** Clean panel with only your custom footer

### Example 3: Complete Custom Branding

**Configuration:**
- Enable Watermark Removal: `Yes`
- Enable Footer Removal: `Yes`
- Custom Footer Text: `Powered by MyCompany | © {year} {copyright}`
- Custom Watermark Text: `MyCompany Panel`
- Custom Logo URL: `https://mycompany.com/logo.png`
- Copyright Text: `MyCompany Inc.`

**Result:** Fully branded panel with your logo, footer, and watermark

### Example 4: Custom Watermark Only

**Configuration:**
- Enable Watermark Removal: `Yes`
- Enable Footer Removal: `No`
- Custom Watermark Text: `Powered by MyBrand`

**Result:** Default footer remains, but custom watermark is shown

## 🏗️ Technical Details

### File Structure

```
CustomBranding/
├── conf.yml                  # Plugin configuration (REQUIRED)
├── Plugin.php                # Main plugin class
├── README_PHP.md            # This documentation
├── events/                   # Event handlers
│   └── BrandingEvents.php   # Branding event handlers
└── assets/                   # Optional assets
    └── css/
        └── custom-branding.css
```

### Plugin Architecture

The plugin follows FeatherPanel v2 architecture:

1. **conf.yml** - Defines plugin metadata and configuration schema
2. **Plugin.php** - Main plugin class extending `PluginBase`
3. **Events** - Event handlers for watermark/footer removal
4. **PluginSettings** - Configuration access via FeatherPanel API

### Key Components

#### conf.yml
The configuration manifest required by FeatherPanel v2. Defines:
- Plugin metadata (name, version, author)
- Target FeatherPanel version
- Required PHP version
- Configuration schema with validation
- Plugin flags (hasEvents, hasInstallScript)

#### Plugin.php
Main plugin class with:
- `install()` - Plugin installation logic
- `boot()` - Plugin initialization
- Event registration
- CSS injection for branding removal
- View composers for custom branding

#### BrandingEvents.php
Event handler class with:
- Watermark rendering events
- Footer rendering events
- Logo customization events
- CSS generation for branding removal

### PluginSettings API

Access configuration values:

```php
use App\Plugins\PluginSettings;

// Get a setting value
$value = PluginSettings::getSetting('custom_branding', 'enable_watermark_removal');

// Set a setting value
PluginSettings::setSetting('custom_branding', 'custom_footer_text', 'My Footer');
```

### Event Hooks

The plugin hooks into these FeatherPanel events:

- `view.rendering` - Inject custom branding variables
- `featherpanel.footer.rendering` - Modify footer content
- `featherpanel.watermark.rendering` - Modify watermark content
- `featherpanel.branding.rendering` - General branding modifications

## 📚 Building the .fpa Package

### Using the Build Script

```bash
cd CustomBranding
./build.sh
```

The script will:
1. Create a `build/` directory
2. Copy all required files
3. Create a ZIP archive with proper structure
4. Output to `dist/CustomBranding-v1.0.0.fpa`

### Manual Build Process

If you need to build manually:

```bash
# Create build directory
mkdir -p build/custom_branding

# Copy required files
cp conf.yml build/custom_branding/
cp Plugin.php build/custom_branding/
cp -r events build/custom_branding/
cp -r assets build/custom_branding/
cp README_PHP.md build/custom_branding/README.md

# Create .fpa package
cd build
zip -r ../CustomBranding-v1.0.0.fpa custom_branding/
cd ..
```

### Verify Package Contents

```bash
unzip -l CustomBranding-v1.0.0.fpa
```

Should contain:
- `custom_branding/conf.yml` ✅ (CRITICAL)
- `custom_branding/Plugin.php` ✅
- `custom_branding/events/BrandingEvents.php` ✅
- `custom_branding/assets/css/custom-branding.css` ✅
- `custom_branding/README.md` ✅

## 🔧 Troubleshooting

### Plugin Not Showing Up

**Problem:** Plugin doesn't appear in FeatherPanel plugins list

**Solutions:**
1. Verify `conf.yml` exists in the plugin directory
2. Check file permissions: `chmod -R 755 /path/to/plugins/custom_branding`
3. Check FeatherPanel logs: `tail -f /var/log/featherpanel/error.log`
4. Restart FeatherPanel: `systemctl restart featherpanel`

### "Invalid addon: missing conf.yml" Error

**Problem:** FeatherPanel shows error about missing conf.yml

**Solutions:**
1. Ensure `conf.yml` is in the root of the plugin directory
2. Check file name is exactly `conf.yml` (lowercase, not `config.yml` or `conf.yaml`)
3. Verify file is valid YAML syntax
4. Rebuild the .fpa package with correct structure

### Watermarks Still Showing

**Problem:** Default watermarks are not removed

**Solutions:**
1. Ensure "Enable Watermark Removal" is set to `Yes` in plugin settings
2. Clear browser cache: `Ctrl+F5` or `Cmd+Shift+R`
3. Clear FeatherPanel cache if available
4. Check browser console for JavaScript errors
5. Verify plugin is enabled in FeatherPanel admin panel

### Custom Footer Not Appearing

**Problem:** Custom footer text is not showing

**Solutions:**
1. Ensure "Enable Footer Removal" is set to `Yes`
2. Verify "Custom Footer Text" field is not empty
3. Check for theme conflicts that override footer
4. Inspect page HTML to see if footer element exists

### Configuration Not Saving

**Problem:** Configuration changes don't persist

**Solutions:**
1. Check file permissions on plugin directory
2. Verify database write permissions
3. Check FeatherPanel logs for errors
4. Ensure PluginSettings API is available

## 🔒 Security

### Best Practices

1. **HTTPS URLs Only** - Custom logo URLs must use HTTPS
2. **Input Validation** - All configuration values are validated
3. **XSS Protection** - All output is properly escaped
4. **No External Dependencies** - Plugin is self-contained
5. **Permission Checks** - Only admins can configure the plugin

### Security Features

- ✅ HTML escaping for all user input
- ✅ URL validation for logo URLs
- ✅ Length limits on all text fields
- ✅ Regex validation where appropriate
- ✅ No code execution from configuration

## 📝 Development

### Requirements

- PHP 8.1+
- Composer (for development)
- FeatherPanel v2 SDK

### Development Setup

```bash
# Clone repository
git clone https://github.com/2IceCube/CX.git
cd CX/CustomBranding

# Install development dependencies (if any)
composer install --dev

# Make changes to files
# ...

# Build for testing
./build.sh

# Deploy to test environment
cp dist/CustomBranding-v1.0.0.fpa /path/to/test/environment/
```

### Adding New Features

1. Update `conf.yml` with new configuration fields
2. Add logic to `Plugin.php` or `BrandingEvents.php`
3. Update validation in conf.yml schema
4. Test thoroughly
5. Update version in conf.yml and build script
6. Rebuild .fpa package

## 🤝 Support

### Getting Help

1. **Documentation** - Read this README and FeatherPanel docs
2. **FeatherPanel Discord** - Join the community: https://discord.mythical.systems
3. **GitHub Issues** - Report bugs or request features
4. **FeatherPanel Forums** - Ask questions and share experiences

### Reporting Issues

When reporting issues, include:

1. FeatherPanel version
2. PHP version
3. Plugin version
4. Configuration settings (without sensitive data)
5. Error messages from logs
6. Steps to reproduce

## 📜 License

MIT License - See [LICENSE](LICENSE) file for details

## 🙏 Credits

- **Author:** 2IceCube
- **FeatherPanel:** MysticsSystems
- **Community:** FeatherPanel Discord community

## 📚 Additional Resources

- [FeatherPanel Documentation](https://docs.mythical.systems)
- [FeatherPanel Plugin Development Guide](https://docs.mythical.systems/plugins)
- [FeatherPanel API Reference](https://docs.mythical.systems/api)
- [PHP 8.1 Documentation](https://www.php.net/manual/en/)

---

**Version:** 1.0.0  
**Last Updated:** 2024-01-31  
**Status:** Production Ready ✅

**Made with ❤️ for the FeatherPanel community**
