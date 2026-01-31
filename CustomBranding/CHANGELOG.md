# Changelog

All notable changes to the Custom Branding Plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-01-31

### Added
- Initial release of Custom Branding Plugin
- Remove default FeatherPanel watermarks functionality
- Remove default footer branding functionality
- Custom footer with configurable text, links, and alignment
- Custom watermark with position and opacity controls
- Logo customization support
- Copyright information with automatic year replacement
- Comprehensive styling options:
  - Footer background color
  - Footer text color
  - Footer link color
  - Watermark color
  - Custom CSS injection
- Advanced configuration options:
  - Hide all branding (nuclear option)
  - Preserve login page branding
  - Context-aware application (admin panel vs client area)
- Complete documentation:
  - README with usage examples
  - INSTALLATION guide with step-by-step instructions
  - Inline code documentation
- CSS file with pre-built styles for common scenarios
- JSON configuration file with sensible defaults
- Plugin manifest (addon.json) following FeatherPanel standards

### Features
- Hooks into FeatherPanel UI rendering system
- Dynamic variable replacement ({year})
- Responsive design for mobile devices
- Browser compatibility with modern browsers
- Easy installation via admin panel or manual deployment

### Documentation
- Comprehensive README.md with feature overview
- Detailed INSTALLATION.md guide
- Configuration examples for common use cases
- Troubleshooting section
- API hooks documentation

### Technical Details
- Compatible with FeatherPanel 1.0.0+
- Written in Node.js/JavaScript
- CSS-based styling overrides
- JSON-based configuration
- Modular and maintainable code structure

## [Unreleased]

### Planned Features
- Multi-language support
- Visual configuration editor
- More dynamic variables (username, company name, etc.)
- Additional watermark positions
- Animated footer effects
- Theme presets
- Import/export configuration
- A/B testing capabilities
- Analytics integration hooks

---

**Note**: For the full list of changes between versions, compare the tags on the repository.
