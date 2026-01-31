# Plugin Architecture

## System Overview

```
┌─────────────────────────────────────────────────────────────┐
│                     FeatherPanel Core                        │
│                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │  UI Layer    │  │  API Layer   │  │  Hook System │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
│         │                 │                   │             │
└─────────┼─────────────────┼───────────────────┼─────────────┘
          │                 │                   │
          │                 │                   │
          ▼                 ▼                   ▼
┌─────────────────────────────────────────────────────────────┐
│              Custom Branding Plugin                          │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                   Plugin Core                         │  │
│  │  (src/index.js - 326 lines)                          │  │
│  │                                                       │  │
│  │  ┌─────────────────┐  ┌──────────────────┐         │  │
│  │  │ Configuration   │  │  Hook Registry   │         │  │
│  │  │    Loader       │  │     System       │         │  │
│  │  └─────────────────┘  └──────────────────┘         │  │
│  │           │                      │                   │  │
│  │           ▼                      ▼                   │  │
│  │  ┌─────────────────────────────────────┐           │  │
│  │  │      UI Modifier Functions          │           │  │
│  │  │  - modifyFooter()                   │           │  │
│  │  │  - modifyWatermark()                │           │  │
│  │  │  - modifyBranding()                 │           │  │
│  │  │  - modifyLogo()                     │           │  │
│  │  └─────────────────────────────────────┘           │  │
│  │           │                                          │  │
│  │           ▼                                          │  │
│  │  ┌─────────────────────────────────────┐           │  │
│  │  │      CSS Generator & Injector       │           │  │
│  │  │  - generateCSS()                     │           │  │
│  │  │  - applyStyling()                    │           │  │
│  │  └─────────────────────────────────────┘           │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐  │
│  │              CSS Overrides                            │  │
│  │  (assets/custom-branding.css - 177 lines)           │  │
│  │                                                       │  │
│  │  - Hide default branding                             │  │
│  │  - Custom footer styles                              │  │
│  │  - Custom watermark styles                           │  │
│  │  - Responsive adjustments                            │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐  │
│  │           Configuration System                        │  │
│  │  (config.json)                                        │  │
│  │                                                       │  │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐ │  │
│  │  │  Branding   │  │   Styling   │  │  Advanced   │ │  │
│  │  │   Options   │  │   Options   │  │   Options   │ │  │
│  │  └─────────────┘  └─────────────┘  └─────────────┘ │  │
│  └──────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

## Component Breakdown

### 1. Plugin Core (`src/index.js`)

The main JavaScript file that handles all plugin logic.

**Class: CustomBrandingPlugin**

```javascript
CustomBrandingPlugin
├── constructor()              // Initialize plugin, load config
├── loadConfig()              // Load configuration from JSON
├── getDefaultConfig()        // Provide fallback configuration
├── init(featherPanel)        // Initialize plugin with FeatherPanel
├── registerHooks()           // Register UI modification hooks
├── modifyFooter()            // Transform footer content
├── modifyWatermark()         // Transform watermark content
├── modifyBranding()          // Transform branding elements
├── modifyLogo()              // Transform logo elements
├── applyStyling()            // Inject custom CSS
├── generateCSS()             // Generate CSS from config
└── cleanup()                 // Clean up on plugin disable
```

**Data Flow:**

```
config.json → loadConfig() → configuration object
                ↓
         init(featherPanel)
                ↓
         registerHooks()
                ↓
    ┌───────────┴───────────┐
    ↓                       ↓
Hook Callbacks         applyStyling()
    ↓                       ↓
UI Modifications      CSS Injection
    ↓                       ↓
Modified UI Elements  Styled Page
```

### 2. Configuration System

**Configuration Flow:**

```
User edits config.json
        ↓
Plugin reload/restart
        ↓
loadConfig() reads file
        ↓
Parse JSON
        ↓
Validate structure
        ↓
Apply to plugin instance
        ↓
Hooks use configuration
        ↓
UI reflects changes
```

**Configuration Structure:**

```json
{
  "branding": {
    "removeWatermark": boolean,
    "removeFooter": boolean,
    "customFooter": { ... },
    "customWatermark": { ... },
    "logo": { ... },
    "copyright": { ... }
  },
  "styling": {
    "colors": { ... },
    "customCSS": string
  },
  "advanced": {
    "context": { ... },
    "options": { ... }
  }
}
```

### 3. Hook System

The plugin registers hooks with FeatherPanel to intercept and modify UI elements.

**Registered Hooks:**

```
ui.footer → modifyFooter()
    ↓
Receives default footer
    ↓
Checks config
    ↓
Returns modified footer or null

ui.watermark → modifyWatermark()
    ↓
Receives default watermark
    ↓
Checks config
    ↓
Returns modified watermark or null

ui.branding → modifyBranding()
    ↓
Receives branding context
    ↓
Checks config
    ↓
Returns modified branding

ui.logo → modifyLogo()
    ↓
Receives default logo
    ↓
Checks config
    ↓
Returns custom logo if configured
```

### 4. CSS System

**CSS Generation Flow:**

```
config.json styling section
        ↓
generateCSS() function
        ↓
Build CSS rules
        ↓
Add hide rules (if enabled)
        ↓
Add custom styles
        ↓
Add custom CSS from config
        ↓
Return complete CSS string
        ↓
applyStyling() injects CSS
        ↓
FeatherPanel.ui.injectCSS()
        ↓
CSS applied to page
```

**CSS Categories:**

```
1. Hide Rules
   - .feather-watermark { display: none !important; }
   - .fp-footer .default-branding { display: none !important; }

2. Custom Footer Styles
   - Background color
   - Text color
   - Link color
   - Alignment

3. Custom Watermark Styles
   - Position (fixed)
   - Color
   - Opacity
   - Z-index

4. Responsive Rules
   - Mobile adjustments
   - Tablet adjustments
   - Desktop optimizations

5. Custom CSS
   - User-provided CSS
```

### 5. File Structure

```
CustomBranding/
│
├── addon.json                 # Plugin manifest
│   └── Defines: id, name, version, hooks, permissions
│
├── config.json                # Main configuration
│   └── Runtime configuration for the plugin
│
├── src/
│   └── index.js              # Main plugin logic
│       ├── Class definition
│       ├── Configuration handling
│       ├── Hook implementations
│       └── CSS generation
│
├── assets/
│   └── custom-branding.css   # Static CSS overrides
│       ├── Hide rules
│       ├── Custom styles
│       └── Responsive rules
│
├── examples/
│   ├── minimal-example.json
│   ├── footer-only-example.json
│   ├── full-branding-example.json
│   └── watermark-only-example.json
│
└── docs/
    ├── README.md
    ├── INSTALLATION.md
    ├── QUICKSTART.md
    ├── TESTING.md
    ├── CONTRIBUTING.md
    ├── STRUCTURE.md
    ├── CHANGELOG.md
    └── PROJECT_SUMMARY.md
```

## Execution Flow

### Plugin Initialization

```
1. FeatherPanel starts
        ↓
2. Plugin loader finds addon.json
        ↓
3. Validates plugin metadata
        ↓
4. Checks permissions
        ↓
5. Loads src/index.js
        ↓
6. Creates CustomBrandingPlugin instance
        ↓
7. Constructor loads config.json
        ↓
8. Calls init(featherPanel)
        ↓
9. Plugin registers hooks
        ↓
10. Plugin injects CSS
        ↓
11. Plugin ready
```

### Runtime Hook Execution

```
User requests page
        ↓
FeatherPanel renders UI
        ↓
Hook: ui.footer triggered
        ↓
modifyFooter() called
        ↓
Returns custom footer
        ↓
Hook: ui.watermark triggered
        ↓
modifyWatermark() called
        ↓
Returns custom watermark (or null)
        ↓
Hook: ui.branding triggered
        ↓
modifyBranding() called
        ↓
Returns modified branding
        ↓
CSS already injected
        ↓
Page rendered with customizations
```

## Security Architecture

### Input Validation

```
User Input (config.json)
        ↓
JSON Parse (with try-catch)
        ↓
Structure Validation
        ↓
Type Checking
        ↓
Sanitization (URLs, CSS)
        ↓
Safe Configuration Object
```

### Permission System

```
Plugin declares permissions in addon.json:
- read:config    → Read configuration files
- write:config   → Modify configuration
- modify:ui      → Modify UI elements

FeatherPanel grants/denies permissions
```

## Performance Considerations

### Optimization Points

1. **Configuration Caching**
   - Config loaded once at startup
   - Cached in memory
   - No repeated file I/O

2. **CSS Generation**
   - Generated once at init
   - Injected once
   - Cached by browser

3. **Hook Efficiency**
   - Simple conditionals
   - Minimal processing
   - Fast returns

4. **No External Dependencies**
   - No network requests
   - No external libraries
   - Fast load times

## Extension Points

### How to Extend

1. **Add New Hooks**
   ```javascript
   featherPanel.hooks.register('ui.custom', (element) => {
       return this.modifyCustomElement(element);
   });
   ```

2. **Add Configuration Options**
   ```json
   {
     "newFeature": {
       "enabled": true,
       "option": "value"
     }
   }
   ```

3. **Add CSS Rules**
   ```javascript
   generateCSS() {
       // Add new CSS generation logic
   }
   ```

4. **Add Dynamic Variables**
   ```javascript
   text = text.replace(/\{newVar\}/g, newValue);
   ```

## Error Handling

### Error Flow

```
Error Occurs
        ↓
Caught by try-catch
        ↓
Logged to console
        ↓
Fallback to default behavior
        ↓
Plugin continues running
```

### Error Types Handled

1. **Configuration Errors**
   - Invalid JSON → Use defaults
   - Missing file → Use defaults
   - Invalid values → Use defaults

2. **Runtime Errors**
   - Hook failures → Log and continue
   - CSS injection fails → Log warning
   - Rendering errors → Log and fallback

## Monitoring & Debugging

### Logging Points

```
[CustomBranding] Configuration loaded successfully
[CustomBranding] Initializing Custom Branding Plugin v1.0.0
[CustomBranding] Plugin initialized successfully
[CustomBranding] Custom styles applied
[CustomBranding] Error loading config: <error>
[CustomBranding] Plugin cleanup completed
```

### Debug Information

- Check browser console for JavaScript errors
- Check FeatherPanel logs for plugin errors
- Inspect applied CSS in browser dev tools
- Verify configuration with JSON validator

---

**Architecture Version**: 1.0.0  
**Last Updated**: 2024-01-31  
**Complexity**: Medium  
**Maintainability**: High
