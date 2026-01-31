# Installation Guide - Custom Branding Plugin

This guide will walk you through the installation and initial setup of the Custom Branding Plugin for FeatherPanel.

## Prerequisites

Before installing the plugin, ensure you have:

- [ ] FeatherPanel version 1.0.0 or higher installed
- [ ] Administrative access to your FeatherPanel instance
- [ ] Access to the server's file system (for manual installation)
- [ ] Basic understanding of JSON format (for configuration)

## Installation Steps

### Step 1: Download the Plugin

Download the latest version of the Custom Branding Plugin:

- **Recommended**: Download the `.fpa` package file from releases
- **Alternative**: Download the source code from the repository

### Step 2: Install the Plugin

#### Option A: Install from .fpa Package (Recommended)

The `.fpa` (FeatherPanel Plugin Archive) format is the easiest installation method.

1. **Download the .fpa file**
   - Get `CustomBranding-v1.0.0.fpa` from releases
   - Or build it yourself (see [BUILD.md](BUILD.md))

2. **Upload via Admin Panel**
   - Log into your FeatherPanel admin dashboard
   - Navigate to **Settings** → **Plugins** (or **Addons**)
   - Click **Upload Plugin** or **Install Plugin**
   - Click **Choose File** and select the `.fpa` file
   - Click **Install** or **Upload**
   - Wait for the upload and installation to complete

3. **Enable the Plugin**
   - Once installed, find "Custom Branding Plugin" in the plugins list
   - Click **Enable** or **Activate**
   - The plugin is now active!

**Advantages of .fpa installation:**
- ✅ One-click installation
- ✅ Automatic file extraction
- ✅ Automatic permission setup
- ✅ Version management
- ✅ Easy updates

#### Option B: Manual Installation from .fpa

If your FeatherPanel admin panel doesn't support .fpa uploads:

1. **Extract the .fpa file** (it's a ZIP archive):
   ```bash
   unzip CustomBranding-v1.0.0.fpa -d /path/to/featherpanel/plugins/
   ```

2. **Set proper permissions**:
   ```bash
   sudo chown -R www-data:www-data /path/to/featherpanel/plugins/CustomBranding
   sudo chmod -R 755 /path/to/featherpanel/plugins/CustomBranding
   ```

3. **Restart FeatherPanel**:
   ```bash
   systemctl restart featherpanel
   # OR
   service featherpanel restart
   ```

#### Option C: Install from Source (Development)

For development or if you want to modify the plugin:

1. **Clone or download the repository**
   ```bash
   git clone https://github.com/2IceCube/CX.git
   cd CX
   ```

2. **Copy plugin to FeatherPanel**
   ```bash
   cp -r CustomBranding /path/to/featherpanel/plugins/
   ```

3. **Set proper permissions**
   ```bash
   sudo chown -R www-data:www-data /path/to/featherpanel/plugins/CustomBranding
   sudo chmod -R 755 /path/to/featherpanel/plugins/CustomBranding
   ```

4. **Restart FeatherPanel**
   ```bash
   systemctl restart featherpanel
   ```

### Step 3: Verify Installation

1. Log into FeatherPanel admin panel
2. Go to **Plugins** section
3. Look for "Custom Branding Plugin" in the list
4. Verify the status shows as **Active** or **Enabled**

## Initial Configuration

### Step 1: Locate Configuration File

The configuration file is located at:
```
CustomBranding/config.json
```

### Step 2: Basic Configuration

Edit the `config.json` file with your preferred settings. Here's a minimal configuration to get started:

```json
{
  "branding": {
    "removeWatermark": true,
    "removeFooter": true,
    "customFooter": {
      "enabled": true,
      "text": "© 2024 Your Company Name. All rights reserved.",
      "link": "https://yourcompany.com",
      "alignment": "center"
    }
  }
}
```

### Step 3: Apply Configuration

After editing the configuration:

1. Save the `config.json` file
2. Reload the plugin:
   - Via Admin Panel: Navigate to Plugins → Custom Branding → Click **Reload**
   - Via Command Line:
     ```bash
     featherpanel plugins reload custom-branding
     ```
3. Clear your browser cache (`Ctrl+Shift+R` or `Cmd+Shift+R`)
4. Refresh your FeatherPanel page to see changes

## Verification

### Verify Watermark Removal

1. Open your FeatherPanel dashboard
2. Check the bottom corners and edges of the page
3. Verify that default FeatherPanel watermarks are no longer visible

### Verify Footer Customization

1. Scroll to the bottom of any page
2. Verify that your custom footer text appears
3. Click the footer link to ensure it works correctly

### Verify Custom Branding

1. Navigate through different sections (admin panel, client area)
2. Verify that custom branding appears consistently
3. Check mobile/responsive view to ensure proper display

## Post-Installation Tips

### Tip 1: Backup Configuration

Always keep a backup of your `config.json` file:
```bash
cp CustomBranding/config.json CustomBranding/config.json.backup
```

### Tip 2: Test Changes Gradually

When customizing:
1. Make one change at a time
2. Reload the plugin after each change
3. Verify the change worked before moving to the next

### Tip 3: Use Browser Developer Tools

To debug CSS issues:
1. Open browser Developer Tools (F12)
2. Inspect elements to see which styles are applied
3. Test CSS changes live before adding to configuration

### Tip 4: Monitor Logs

Keep an eye on FeatherPanel logs for any errors:
```bash
tail -f /var/log/featherpanel/error.log
```

## Common Installation Issues

### Issue: Plugin Not Showing in List

**Solution:**
- Check file permissions: `ls -la plugins/CustomBranding`
- Ensure `addon.json` file exists and is valid JSON
- Restart FeatherPanel completely

### Issue: Permission Denied Errors

**Solution:**
```bash
sudo chown -R www-data:www-data /path/to/featherpanel/plugins/CustomBranding
sudo chmod -R 755 /path/to/featherpanel/plugins/CustomBranding
```

### Issue: Configuration Not Loading

**Solution:**
- Validate JSON syntax using [JSONLint](https://jsonlint.com/)
- Check file encoding (should be UTF-8)
- Verify file name is exactly `config.json`

### Issue: Changes Not Visible

**Solution:**
1. Hard refresh browser: `Ctrl+Shift+R` (Windows/Linux) or `Cmd+Shift+R` (Mac)
2. Clear browser cache completely
3. Try in incognito/private browsing mode
4. Reload the plugin via admin panel

## Upgrading

To upgrade to a newer version:

1. **Backup current installation:**
   ```bash
   cp -r CustomBranding CustomBranding.backup
   ```

2. **Download new version:**
   Download the latest version of the plugin

3. **Replace files:**
   ```bash
   rm -rf CustomBranding/src
   cp -r NewVersion/CustomBranding/src CustomBranding/
   ```

4. **Keep your configuration:**
   Your `config.json` file will remain unchanged

5. **Restart FeatherPanel:**
   ```bash
   systemctl restart featherpanel
   ```

## Uninstallation

To remove the plugin:

### Via Admin Panel

1. Go to **Plugins** section
2. Find "Custom Branding Plugin"
3. Click **Disable**
4. Click **Uninstall** or **Delete**

### Manual Removal

```bash
# Stop FeatherPanel
systemctl stop featherpanel

# Remove plugin directory
rm -rf /path/to/featherpanel/plugins/CustomBranding

# Start FeatherPanel
systemctl start featherpanel
```

Note: Removing the plugin will restore default FeatherPanel branding.

## Getting Help

If you encounter issues during installation:

1. **Check Documentation**: Review the main README.md file
2. **Search Existing Issues**: Check if others have faced similar problems
3. **FeatherPanel Discord**: Ask in the community Discord server
4. **Create Issue**: Open an issue on the plugin repository with:
   - Your FeatherPanel version
   - Plugin version
   - Error messages (if any)
   - Steps to reproduce the problem

## Next Steps

After successful installation:

1. Read the [Configuration Examples](README.md#usage-examples) in the main README
2. Customize the branding to match your company's identity
3. Test thoroughly on different devices and browsers
4. Consider adding custom CSS for advanced styling

---

**Installation Complete!** 🎉

You should now have a fully functioning Custom Branding Plugin. Enjoy your customized FeatherPanel experience!
