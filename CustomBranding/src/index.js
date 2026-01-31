/**
 * Custom Branding Plugin for FeatherPanel
 * Removes default watermarks and footers, allows custom branding
 * 
 * @author MysticsSystems
 * @version 1.0.0
 */

const fs = require('fs');
const path = require('path');

class CustomBrandingPlugin {
    constructor() {
        this.config = null;
        this.configPath = path.join(__dirname, '../config.json');
        this.loadConfig();
    }

    /**
     * Load configuration from config.json
     */
    loadConfig() {
        try {
            const configData = fs.readFileSync(this.configPath, 'utf8');
            this.config = JSON.parse(configData);
            console.log('[CustomBranding] Configuration loaded successfully');
        } catch (error) {
            console.error('[CustomBranding] Error loading config:', error.message);
            this.config = this.getDefaultConfig();
        }
    }

    /**
     * Get default configuration
     */
    getDefaultConfig() {
        return {
            branding: {
                removeWatermark: true,
                removeFooter: true,
                customFooter: {
                    enabled: true,
                    text: "© 2024 Your Company Name. All rights reserved.",
                    link: "https://yourcompany.com",
                    alignment: "center"
                },
                customWatermark: {
                    enabled: false,
                    text: "Powered by Your Brand",
                    position: "bottom-right",
                    opacity: 0.7
                },
                logo: {
                    enabled: false,
                    url: "",
                    altText: "Company Logo",
                    width: "150px",
                    height: "auto"
                },
                copyright: {
                    enabled: true,
                    text: "Your Company Name",
                    year: "auto"
                }
            },
            styling: {
                footerBackgroundColor: "#1a1a1a",
                footerTextColor: "#ffffff",
                footerLinkColor: "#4a9eff",
                watermarkColor: "#666666",
                customCSS: ""
            },
            advanced: {
                hideAllBranding: false,
                preserveLoginPage: false,
                applyToAdminPanel: true,
                applyToClientArea: true
            }
        };
    }

    /**
     * Initialize the plugin
     */
    init(featherPanel) {
        console.log('[CustomBranding] Initializing Custom Branding Plugin v1.0.0');
        
        // Register hooks for UI modification
        this.registerHooks(featherPanel);
        
        // Apply CSS overrides
        this.applyStyling(featherPanel);
        
        console.log('[CustomBranding] Plugin initialized successfully');
    }

    /**
     * Register hooks to modify UI elements
     */
    registerHooks(featherPanel) {
        // Hook to remove/modify footer
        if (this.config.branding.removeFooter || this.config.branding.customFooter.enabled) {
            featherPanel.hooks.register('ui.footer', (footer) => {
                return this.modifyFooter(footer);
            });
        }

        // Hook to remove/modify watermark
        if (this.config.branding.removeWatermark || this.config.branding.customWatermark.enabled) {
            featherPanel.hooks.register('ui.watermark', (watermark) => {
                return this.modifyWatermark(watermark);
            });
        }

        // Hook to modify branding elements
        featherPanel.hooks.register('ui.branding', (branding) => {
            return this.modifyBranding(branding);
        });

        // Hook to inject custom logo
        if (this.config.branding.logo.enabled) {
            featherPanel.hooks.register('ui.logo', (logo) => {
                return this.modifyLogo(logo);
            });
        }
    }

    /**
     * Modify footer content
     */
    modifyFooter(footer) {
        if (this.config.branding.removeFooter && !this.config.branding.customFooter.enabled) {
            // Remove footer entirely
            return null;
        }

        if (this.config.branding.customFooter.enabled) {
            const { text, link, alignment } = this.config.branding.customFooter;
            const year = this.config.branding.copyright.year === 'auto' 
                ? new Date().getFullYear() 
                : this.config.branding.copyright.year;
            
            let footerText = text.replace(/\{year\}/g, year);
            if (this.config.branding.copyright.enabled) {
                footerText = footerText.replace(/Your Company Name/g, this.config.branding.copyright.text);
            }

            return {
                content: footerText,
                link: link,
                alignment: alignment,
                custom: true
            };
        }

        return footer;
    }

    /**
     * Modify watermark content
     */
    modifyWatermark(watermark) {
        if (this.config.branding.removeWatermark && !this.config.branding.customWatermark.enabled) {
            // Remove watermark entirely
            return null;
        }

        if (this.config.branding.customWatermark.enabled) {
            const { text, position, opacity } = this.config.branding.customWatermark;
            return {
                content: text,
                position: position,
                opacity: opacity,
                custom: true
            };
        }

        return watermark;
    }

    /**
     * Modify branding elements
     */
    modifyBranding(branding) {
        if (this.config.advanced.hideAllBranding) {
            return null;
        }

        // Apply custom branding based on context
        if (branding.context === 'admin' && !this.config.advanced.applyToAdminPanel) {
            return branding;
        }

        if (branding.context === 'client' && !this.config.advanced.applyToClientArea) {
            return branding;
        }

        // Return modified branding
        return {
            ...branding,
            custom: true,
            modified: true
        };
    }

    /**
     * Modify logo
     */
    modifyLogo(logo) {
        if (this.config.branding.logo.enabled && this.config.branding.logo.url) {
            return {
                url: this.config.branding.logo.url,
                altText: this.config.branding.logo.altText,
                width: this.config.branding.logo.width,
                height: this.config.branding.logo.height,
                custom: true
            };
        }

        return logo;
    }

    /**
     * Apply CSS styling
     */
    applyStyling(featherPanel) {
        const styles = this.generateCSS();
        
        if (featherPanel.ui && featherPanel.ui.injectCSS) {
            featherPanel.ui.injectCSS('custom-branding-styles', styles);
            console.log('[CustomBranding] Custom styles applied');
        }
    }

    /**
     * Generate CSS based on configuration
     */
    generateCSS() {
        const { styling } = this.config;
        let css = `
            /* Custom Branding Plugin Styles */
            
            /* Hide default FeatherPanel branding */
            ${this.config.branding.removeWatermark ? `
            .feather-watermark,
            .fp-watermark,
            [class*="watermark"],
            [data-watermark],
            .powered-by-feather {
                display: none !important;
                visibility: hidden !important;
            }
            ` : ''}

            ${this.config.branding.removeFooter ? `
            .feather-footer .default-branding,
            .fp-footer .default-branding,
            footer .featherpanel-branding,
            footer [class*="feather-credit"] {
                display: none !important;
                visibility: hidden !important;
            }
            ` : ''}

            /* Custom footer styling */
            ${this.config.branding.customFooter.enabled ? `
            .custom-footer {
                background-color: ${styling.footerBackgroundColor};
                color: ${styling.footerTextColor};
                text-align: ${this.config.branding.customFooter.alignment};
                padding: 1rem;
                width: 100%;
            }

            .custom-footer a {
                color: ${styling.footerLinkColor};
                text-decoration: none;
            }

            .custom-footer a:hover {
                text-decoration: underline;
            }
            ` : ''}

            /* Custom watermark styling */
            ${this.config.branding.customWatermark.enabled ? `
            .custom-watermark {
                position: fixed;
                ${this.config.branding.customWatermark.position.includes('bottom') ? 'bottom: 10px;' : 'top: 10px;'}
                ${this.config.branding.customWatermark.position.includes('right') ? 'right: 10px;' : 'left: 10px;'}
                color: ${styling.watermarkColor};
                opacity: ${this.config.branding.customWatermark.opacity};
                font-size: 0.875rem;
                pointer-events: none;
                z-index: 9999;
            }
            ` : ''}

            /* Hide all branding if configured */
            ${this.config.advanced.hideAllBranding ? `
            [class*="brand"],
            [class*="credit"],
            [class*="powered"],
            [data-brand],
            [data-credit] {
                display: none !important;
            }
            ` : ''}

            /* Custom CSS from config */
            ${styling.customCSS}
        `;

        return css;
    }

    /**
     * Clean up resources when plugin is disabled
     */
    cleanup() {
        console.log('[CustomBranding] Plugin cleanup completed');
    }
}

// Export plugin instance
module.exports = new CustomBrandingPlugin();
