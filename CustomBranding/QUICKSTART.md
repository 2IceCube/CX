# Quick Start Guide

Get started with the Custom Branding Plugin in 5 minutes!

## 1. Install the Plugin

Copy the `CustomBranding` folder to your FeatherPanel plugins directory:

```bash
cp -r CustomBranding /path/to/featherpanel/plugins/
```

## 2. Enable the Plugin

Restart FeatherPanel or reload plugins:

```bash
featherpanel plugins reload
# OR
systemctl restart featherpanel
```

## 3. Basic Configuration

Edit `CustomBranding/config.json`:

```json
{
  "branding": {
    "removeWatermark": true,
    "removeFooter": true,
    "customFooter": {
      "enabled": true,
      "text": "© 2024 Your Company. All rights reserved.",
      "link": "https://yourcompany.com",
      "alignment": "center"
    }
  }
}
```

## 4. Apply Changes

Reload the plugin and refresh your browser:

```bash
featherpanel plugins reload custom-branding
```

Press `Ctrl+Shift+R` (or `Cmd+Shift+R` on Mac) in your browser.

## 5. Verify

Check that:
- [ ] Default watermarks are removed
- [ ] Your custom footer appears
- [ ] Footer link works correctly

## Need More?

- **Full Documentation**: See [README.md](README.md)
- **Installation Help**: See [INSTALLATION.md](INSTALLATION.md)
- **Configuration Examples**: Check the `examples/` folder

## Common Use Cases

### Remove Everything
```json
{
  "branding": {
    "removeWatermark": true,
    "removeFooter": true,
    "customFooter": { "enabled": false }
  },
  "advanced": {
    "hideAllBranding": true
  }
}
```

### Custom Footer Only
```json
{
  "branding": {
    "removeFooter": true,
    "customFooter": {
      "enabled": true,
      "text": "© {year} Your Company",
      "link": "https://yourcompany.com"
    }
  }
}
```

### Add Watermark
```json
{
  "branding": {
    "removeWatermark": true,
    "customWatermark": {
      "enabled": true,
      "text": "Powered by Your Brand",
      "position": "bottom-right",
      "opacity": 0.7
    }
  }
}
```

## Troubleshooting

**Changes not visible?**
- Clear browser cache (Ctrl+Shift+R)
- Reload the plugin
- Check browser console for errors

**Plugin not loading?**
- Verify file permissions
- Check FeatherPanel logs
- Ensure JSON syntax is valid

---

**Ready?** Start customizing your FeatherPanel branding now! 🚀
