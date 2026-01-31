# Custom Branding Plugin for FeatherPanel

A powerful plugin for FeatherPanel (by MysticsSystems) that removes all default watermarks and footers, allowing you to customize your panel with your own branding elements.

## Features

- ✅ **Remove Default Watermarks**: Automatically hide all FeatherPanel watermarks
- ✅ **Remove Default Footers**: Hide default footer branding elements
- ✅ **Custom Footer**: Add your own custom footer text and links
- ✅ **Custom Watermark**: Add your own watermark with customizable position and opacity
- ✅ **Logo Customization**: Replace the default logo with your own
- ✅ **Copyright Information**: Add custom copyright text with automatic year
- ✅ **Advanced Styling**: Customize colors, fonts, and add custom CSS
- ✅ **Flexible Configuration**: Enable/disable features independently
- ✅ **Context-Aware**: Apply branding to admin panel, client area, or both

## Installation

### Method 1: Install from .fpa Package (Recommended)

The easiest way to install this plugin is using the `.fpa` (FeatherPanel Plugin Archive) package:

1. **Download or build the .fpa package**:
   - Download `CustomBranding-v1.0.0.fpa` from releases
   - Or build it yourself: `./build.sh` (see [BUILD.md](BUILD.md))

2. **Upload to FeatherPanel**:
   - Log into your FeatherPanel admin dashboard
   - Navigate to **Plugins** or **Addons** section
   - Click **Upload Plugin** or **Install Plugin**
   - Select the `.fpa` file and click **Install**
   - Enable the plugin once installation completes

**Advantages**: One-click installation, automatic setup, easy updates

### Method 2: Manual Installation from .fpa

If your admin panel doesn't support .fpa uploads:

1. Extract the .fpa file (it's a ZIP archive):
   ```bash
   unzip CustomBranding-v1.0.0.fpa -d /path/to/featherpanel/plugins/
   ```
2. Set permissions:
   ```bash
   chown -R www-data:www-data /path/to/featherpanel/plugins/CustomBranding
   chmod -R 755 /path/to/featherpanel/plugins/CustomBranding
   ```
3. Restart FeatherPanel:
   ```bash
   systemctl restart featherpanel
   ```

### Method 3: Install from Source

For development or customization:

1. Download or clone this repository
2. Copy the `CustomBranding` folder to your FeatherPanel plugins directory:
   ```bash
   cp -r CustomBranding /path/to/featherpanel/plugins/
   ```
3. Restart FeatherPanel or reload plugins:
   ```bash
   # If FeatherPanel has a plugin reload command
   featherpanel plugins reload
   
   # Or restart the entire panel
   systemctl restart featherpanel
   ```

**Complete installation instructions**: See [INSTALLATION.md](INSTALLATION.md)

## Building the Plugin Package

To create a `.fpa` package for distribution:

```bash
# Run the build script
./build.sh

# Find the package in dist/
ls dist/CustomBranding-v1.0.0.fpa
```

**Complete build instructions**: See [BUILD.md](BUILD.md)

## Configuration

The plugin uses a `config.json` file for all customization options. Edit this file to configure your branding.

### Configuration File Location

```
CustomBranding/config.json
```

### Configuration Options

#### Branding Settings

```json
{
  "branding": {
    "removeWatermark": true,        // Remove default FeatherPanel watermarks
    "removeFooter": true,            // Remove default FeatherPanel footers
    "customFooter": {
      "enabled": true,
      "text": "© {year} Your Company Name. All rights reserved.",
      "link": "https://yourcompany.com",
      "alignment": "center"          // Options: left, center, right
    },
    "customWatermark": {
      "enabled": false,
      "text": "Powered by Your Brand",
      "position": "bottom-right",    // Options: bottom-right, bottom-left, top-right, top-left
      "opacity": 0.7                 // Range: 0.0 to 1.0
    },
    "logo": {
      "enabled": false,
      "url": "",                     // URL to your logo image
      "altText": "Company Logo",
      "width": "150px",
      "height": "auto"
    },
    "copyright": {
      "enabled": true,
      "text": "Your Company Name",
      "year": "auto"                 // Use "auto" for current year or specify like "2024"
    }
  }
}
```

#### Styling Settings

```json
{
  "styling": {
    "footerBackgroundColor": "#1a1a1a",
    "footerTextColor": "#ffffff",
    "footerLinkColor": "#4a9eff",
    "watermarkColor": "#666666",
    "customCSS": ""                  // Add any custom CSS here
  }
}
```

#### Advanced Settings

```json
{
  "advanced": {
    "hideAllBranding": false,        // Remove ALL branding elements (nuclear option)
    "preserveLoginPage": false,      // Keep branding on login page
    "applyToAdminPanel": true,       // Apply custom branding to admin panel
    "applyToClientArea": true        // Apply custom branding to client area
  }
}
```

## Usage Examples

### Example 1: Complete Branding Removal

To remove all FeatherPanel branding without adding custom branding:

```json
{
  "branding": {
    "removeWatermark": true,
    "removeFooter": true,
    "customFooter": {
      "enabled": false
    },
    "customWatermark": {
      "enabled": false
    }
  },
  "advanced": {
    "hideAllBranding": true
  }
}
```

### Example 2: Custom Footer Only

To keep everything but replace the footer:

```json
{
  "branding": {
    "removeWatermark": false,
    "removeFooter": true,
    "customFooter": {
      "enabled": true,
      "text": "© {year} Acme Hosting. Powered by our infrastructure.",
      "link": "https://acmehosting.com",
      "alignment": "center"
    }
  }
}
```

### Example 3: Custom Watermark

To add a subtle custom watermark:

```json
{
  "branding": {
    "removeWatermark": true,
    "customWatermark": {
      "enabled": true,
      "text": "Acme Hosting Platform",
      "position": "bottom-right",
      "opacity": 0.5
    }
  },
  "styling": {
    "watermarkColor": "#888888"
  }
}
```

### Example 4: Full Custom Branding

To implement complete custom branding:

```json
{
  "branding": {
    "removeWatermark": true,
    "removeFooter": true,
    "customFooter": {
      "enabled": true,
      "text": "© {year} Acme Hosting. All rights reserved.",
      "link": "https://acmehosting.com",
      "alignment": "center"
    },
    "customWatermark": {
      "enabled": true,
      "text": "Secured by Acme",
      "position": "bottom-right",
      "opacity": 0.6
    },
    "logo": {
      "enabled": true,
      "url": "https://acmehosting.com/logo.png",
      "altText": "Acme Hosting",
      "width": "180px"
    },
    "copyright": {
      "enabled": true,
      "text": "Acme Hosting Ltd.",
      "year": "auto"
    }
  },
  "styling": {
    "footerBackgroundColor": "#0f172a",
    "footerTextColor": "#e2e8f0",
    "footerLinkColor": "#38bdf8",
    "watermarkColor": "#64748b",
    "customCSS": ".custom-footer { border-top: 2px solid #38bdf8; }"
  }
}
```

## Dynamic Variables

The following variables can be used in text fields:

- `{year}` - Automatically replaced with the current year
- More variables may be added in future versions

## Troubleshooting

### Plugin Not Working

1. **Check plugin is enabled**: Verify the plugin is active in your FeatherPanel plugins list
2. **Check file permissions**: Ensure the plugin directory has proper read permissions
3. **Check logs**: Look for error messages in FeatherPanel logs:
   ```bash
   tail -f /var/log/featherpanel/error.log
   ```
4. **Restart FeatherPanel**: Sometimes a full restart is needed after configuration changes

### Branding Still Showing

1. **Clear browser cache**: Press `Ctrl+Shift+R` (or `Cmd+Shift+R` on Mac) to hard refresh
2. **Check configuration**: Ensure `removeWatermark` and `removeFooter` are set to `true`
3. **Check CSS specificity**: Some themes might have higher CSS specificity. Use `customCSS` to add `!important` rules if needed

### Custom Styles Not Applying

1. **Verify JSON syntax**: Make sure your `config.json` is valid JSON (use a JSON validator)
2. **Check CSS syntax**: If using `customCSS`, ensure your CSS is valid
3. **Restart plugin**: Disable and re-enable the plugin after configuration changes

## Advanced Customization

### Adding Custom CSS

You can add any custom CSS using the `customCSS` field in the configuration:

```json
{
  "styling": {
    "customCSS": "
      .custom-footer {
        background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
        box-shadow: 0 -2px 10px rgba(0,0,0,0.1);
      }
      .custom-watermark {
        font-family: 'Arial', sans-serif;
        font-weight: bold;
      }
    "
  }
}
```

### Targeting Specific Pages

Use the advanced settings to control where branding appears:

```json
{
  "advanced": {
    "applyToAdminPanel": true,    // Show custom branding in admin panel
    "applyToClientArea": false,   // Keep default branding in client area
    "preserveLoginPage": true     // Don't modify login page branding
  }
}
```

## Compatibility

- **FeatherPanel Version**: 1.0.0 and above
- **Browser Compatibility**: Modern browsers (Chrome, Firefox, Safari, Edge)
- **Mobile**: Fully responsive design

## Support

For issues, feature requests, or questions:

1. Check the [FeatherPanel Documentation](https://featherpanel.com/docs)
2. Visit the [FeatherPanel Discord](https://discord.mythical.systems)
3. Open an issue on the plugin repository

## License

This plugin is released under the MIT License. You are free to modify and distribute it as needed.

## Credits

- **Plugin Author**: MysticsSystems
- **FeatherPanel**: By MythicalSystems
- **Version**: 1.0.0

## Changelog

### Version 1.0.0 (Initial Release)
- Remove default FeatherPanel watermarks
- Remove default footer branding
- Add custom footer with configurable text and links
- Add custom watermark with position and opacity controls
- Logo customization support
- Copyright information with auto-year
- Advanced styling options
- Context-aware branding (admin/client areas)
- Comprehensive configuration system
- Full documentation and examples

## Contributing

Contributions are welcome! If you'd like to improve this plugin:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## Disclaimer

This plugin is provided as-is. Always backup your FeatherPanel installation before installing new plugins. The authors are not responsible for any issues that may arise from using this plugin.

---

**Made with ❤️ for the FeatherPanel community**
