# Testing Checklist

This document provides a comprehensive checklist for testing the Custom Branding Plugin.

## Pre-Installation Tests

### Environment Verification
- [ ] FeatherPanel version 1.0.0 or higher is installed
- [ ] Node.js version 14.0.0 or higher is available
- [ ] Administrative access to FeatherPanel is available
- [ ] File system access is available (for manual installation)

### File Verification
- [ ] All plugin files are present
- [ ] JSON files are valid (use `jq` or JSON validator)
- [ ] File permissions are correct (readable by web server)
- [ ] No syntax errors in JavaScript files

## Installation Tests

### Manual Installation
- [ ] Plugin files copied to correct directory
- [ ] File permissions set correctly (755 for directories, 644 for files)
- [ ] Plugin appears in FeatherPanel plugin list
- [ ] Plugin can be enabled without errors
- [ ] No error messages in FeatherPanel logs

### Admin Panel Installation
- [ ] Plugin ZIP file uploads successfully
- [ ] Plugin extracts without errors
- [ ] Plugin appears in plugin list
- [ ] Plugin can be enabled from admin panel
- [ ] No error messages displayed

## Configuration Tests

### Default Configuration
- [ ] Plugin loads with default config.json
- [ ] Default settings are applied correctly
- [ ] No errors in browser console
- [ ] No errors in server logs

### Custom Configuration
- [ ] Custom config.json is loaded correctly
- [ ] Changes to config.json are reflected after reload
- [ ] Invalid JSON is caught and logged
- [ ] Missing config falls back to defaults

### Configuration Options
Test each configuration option individually:

#### Branding Settings
- [ ] `removeWatermark: true` - Watermarks are hidden
- [ ] `removeWatermark: false` - Watermarks remain visible
- [ ] `removeFooter: true` - Default footer is hidden
- [ ] `removeFooter: false` - Default footer remains visible

#### Custom Footer
- [ ] `customFooter.enabled: true` - Custom footer appears
- [ ] `customFooter.text` - Text is displayed correctly
- [ ] `customFooter.link` - Link works when clicked
- [ ] `customFooter.alignment: left` - Footer is left-aligned
- [ ] `customFooter.alignment: center` - Footer is centered
- [ ] `customFooter.alignment: right` - Footer is right-aligned
- [ ] `{year}` variable is replaced with current year

#### Custom Watermark
- [ ] `customWatermark.enabled: true` - Custom watermark appears
- [ ] `customWatermark.text` - Text is displayed correctly
- [ ] `customWatermark.position: bottom-right` - Positioned correctly
- [ ] `customWatermark.position: bottom-left` - Positioned correctly
- [ ] `customWatermark.position: top-right` - Positioned correctly
- [ ] `customWatermark.position: top-left` - Positioned correctly
- [ ] `customWatermark.opacity` - Opacity is applied correctly

#### Logo Settings
- [ ] `logo.enabled: true` - Custom logo appears
- [ ] `logo.url` - Logo image loads correctly
- [ ] `logo.altText` - Alt text is set correctly
- [ ] `logo.width` - Width is applied correctly
- [ ] `logo.height` - Height is applied correctly

#### Copyright Settings
- [ ] `copyright.enabled: true` - Copyright text appears
- [ ] `copyright.text` - Text is displayed correctly
- [ ] `copyright.year: auto` - Current year is used
- [ ] `copyright.year: 2024` - Specific year is used

#### Styling Settings
- [ ] `footerBackgroundColor` - Background color is applied
- [ ] `footerTextColor` - Text color is applied
- [ ] `footerLinkColor` - Link color is applied
- [ ] `watermarkColor` - Watermark color is applied
- [ ] `customCSS` - Custom CSS is injected and works

#### Advanced Settings
- [ ] `hideAllBranding: true` - All branding is hidden
- [ ] `hideAllBranding: false` - Selective branding works
- [ ] `preserveLoginPage: true` - Login page is not modified
- [ ] `preserveLoginPage: false` - Login page is modified
- [ ] `applyToAdminPanel: true` - Admin panel is modified
- [ ] `applyToAdminPanel: false` - Admin panel is not modified
- [ ] `applyToClientArea: true` - Client area is modified
- [ ] `applyToClientArea: false` - Client area is not modified

## Functionality Tests

### Watermark Removal
- [ ] Default FeatherPanel watermarks are hidden
- [ ] No watermarks visible in corners
- [ ] No watermarks visible at page bottom
- [ ] Custom watermark appears if enabled
- [ ] Watermark position is correct
- [ ] Watermark opacity is correct

### Footer Modification
- [ ] Default footer branding is hidden
- [ ] Custom footer text appears
- [ ] Footer link is clickable
- [ ] Footer alignment is correct
- [ ] Footer colors are applied
- [ ] Footer is responsive on mobile

### Logo Customization
- [ ] Custom logo replaces default logo
- [ ] Logo URL loads correctly
- [ ] Logo dimensions are correct
- [ ] Alt text is set correctly
- [ ] Logo is responsive

### CSS Injection
- [ ] Custom CSS is injected into page
- [ ] CSS rules are applied correctly
- [ ] CSS doesn't break existing styles
- [ ] CSS is responsive

## Browser Compatibility Tests

Test on multiple browsers:

### Desktop Browsers
- [ ] Google Chrome (latest)
- [ ] Mozilla Firefox (latest)
- [ ] Safari (latest)
- [ ] Microsoft Edge (latest)

### Mobile Browsers
- [ ] Chrome Mobile (Android)
- [ ] Safari Mobile (iOS)
- [ ] Firefox Mobile
- [ ] Samsung Internet

### Browser Features
For each browser:
- [ ] Custom branding appears correctly
- [ ] No console errors
- [ ] Responsive design works
- [ ] Links are clickable
- [ ] Colors are correct

## Responsive Design Tests

### Desktop Resolutions
- [ ] 1920x1080 (Full HD)
- [ ] 1366x768 (HD)
- [ ] 1280x720 (720p)

### Tablet Resolutions
- [ ] 1024x768 (iPad)
- [ ] 768x1024 (iPad Portrait)

### Mobile Resolutions
- [ ] 414x896 (iPhone XR)
- [ ] 375x667 (iPhone 8)
- [ ] 360x640 (Android)

### Responsive Features
- [ ] Footer adapts to screen size
- [ ] Watermark position adjusts
- [ ] Text remains readable
- [ ] No horizontal scrolling
- [ ] Touch targets are adequate

## Context Tests

### Admin Panel
- [ ] Custom branding appears in admin panel
- [ ] Settings pages show branding
- [ ] Dashboard shows branding
- [ ] User management shows branding

### Client Area
- [ ] Custom branding appears in client area
- [ ] Server list shows branding
- [ ] Server details show branding
- [ ] Account pages show branding

### Login Page
- [ ] Login page respects preserveLoginPage setting
- [ ] Branding appears or doesn't based on config
- [ ] Login functionality is not affected

## Integration Tests

### Plugin Reload
- [ ] Plugin can be reloaded without errors
- [ ] Configuration changes apply after reload
- [ ] No memory leaks after multiple reloads

### FeatherPanel Updates
- [ ] Plugin continues working after FeatherPanel updates
- [ ] No conflicts with core updates
- [ ] Branding persists after updates

### Other Plugins
- [ ] No conflicts with other plugins
- [ ] CSS doesn't override other plugins
- [ ] Hooks don't interfere with other plugins

## Performance Tests

### Load Time
- [ ] Plugin loads within acceptable time (< 1 second)
- [ ] No significant impact on page load time
- [ ] CSS injection is fast

### Resource Usage
- [ ] Plugin uses minimal memory
- [ ] No CPU spikes
- [ ] No excessive network requests

### Caching
- [ ] Static assets are cached
- [ ] Configuration is cached appropriately
- [ ] Cache invalidation works

## Security Tests

### Input Validation
- [ ] Configuration values are validated
- [ ] Malicious URLs are handled safely
- [ ] XSS attempts are prevented
- [ ] SQL injection is not applicable (no database)

### Permissions
- [ ] Plugin respects FeatherPanel permissions
- [ ] Only authorized users can modify config
- [ ] File permissions are secure

### Data Privacy
- [ ] No sensitive data is exposed
- [ ] No data is sent to external servers
- [ ] User data is not collected

## Error Handling Tests

### Invalid Configuration
- [ ] Invalid JSON is caught and logged
- [ ] Missing required fields fall back to defaults
- [ ] Invalid values are rejected gracefully
- [ ] User-friendly error messages are shown

### Missing Files
- [ ] Missing config.json falls back to defaults
- [ ] Missing CSS file logs warning
- [ ] Plugin still loads with missing assets

### Network Errors
- [ ] Failed logo URL loads gracefully
- [ ] Network timeouts are handled
- [ ] Retry logic works if applicable

## Documentation Tests

### README.md
- [ ] All sections are present
- [ ] Examples work as described
- [ ] Links are not broken
- [ ] Code samples are correct

### INSTALLATION.md
- [ ] Instructions are clear and accurate
- [ ] Step-by-step guide works
- [ ] Troubleshooting section is helpful

### QUICKSTART.md
- [ ] Quick start works in < 5 minutes
- [ ] Examples are tested and working

### Configuration Examples
- [ ] minimal-example.json works
- [ ] footer-only-example.json works
- [ ] full-branding-example.json works
- [ ] watermark-only-example.json works

## Regression Tests

After any changes:
- [ ] All previous tests still pass
- [ ] No new bugs introduced
- [ ] Performance is not degraded
- [ ] Documentation is updated

## User Acceptance Tests

### End User Perspective
- [ ] Installation is easy
- [ ] Configuration is intuitive
- [ ] Documentation is clear
- [ ] Results meet expectations

### Admin Perspective
- [ ] Plugin is manageable
- [ ] Troubleshooting is straightforward
- [ ] Performance is acceptable
- [ ] Security is adequate

## Final Verification

### Pre-Release Checklist
- [ ] All tests passed
- [ ] Documentation is complete
- [ ] Examples are working
- [ ] No known critical bugs
- [ ] License is included
- [ ] Version number is correct
- [ ] Changelog is updated

### Post-Release Monitoring
- [ ] Monitor error logs
- [ ] Check user feedback
- [ ] Watch for bug reports
- [ ] Plan updates as needed

---

## Test Results Log

Use this template to log test results:

```
Date: YYYY-MM-DD
Tester: [Name]
Version: 1.0.0
Environment: [FeatherPanel version, browser, OS]

Tests Passed: [X/Y]
Tests Failed: [Y]
Issues Found: [List]
Notes: [Additional comments]
```

---

**Note**: This is a comprehensive checklist. Not all tests may be applicable to every deployment. Prioritize tests based on your use case and environment.
