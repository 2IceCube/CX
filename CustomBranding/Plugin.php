<?php

namespace Plugins\CustomBranding;

use App\Plugins\PluginBase;
use App\Plugins\PluginSettings;
use Illuminate\Support\Facades\View;
use Illuminate\Support\Facades\Event;

/**
 * Custom Branding Plugin for FeatherPanel v2
 * 
 * Removes default FeatherPanel watermarks and footers, 
 * and allows custom branding configuration.
 * 
 * @package CustomBranding
 * @version 1.0.0
 * @author 2IceCube
 */
class Plugin extends PluginBase
{
    /**
     * Plugin identifier
     * Must match the identifier in conf.yml
     */
    protected string $identifier = 'custom_branding';

    /**
     * Install the plugin
     * 
     * This method is called when the plugin is first installed.
     * It sets up default configurations and prepares the plugin for use.
     * 
     * @return void
     */
    public function install(): void
    {
        // Log plugin installation
        logger()->info('[CustomBranding] Installing Custom Branding Plugin v1.0.0');
        
        // Set default configuration values if not already set
        $this->setDefaultConfig('enable_watermark_removal', true);
        $this->setDefaultConfig('enable_footer_removal', true);
        $this->setDefaultConfig('custom_footer_text', '');
        $this->setDefaultConfig('custom_watermark_text', '');
        $this->setDefaultConfig('custom_logo_url', '');
        $this->setDefaultConfig('copyright_text', '');
        
        logger()->info('[CustomBranding] Plugin installed successfully');
    }

    /**
     * Boot the plugin
     * 
     * This method is called when the plugin is loaded.
     * It registers event listeners and hooks into FeatherPanel.
     * 
     * @return void
     */
    public function boot(): void
    {
        logger()->info('[CustomBranding] Booting Custom Branding Plugin');
        
        // Register event listeners
        $this->registerEventListeners();
        
        // Inject custom CSS for branding removal
        $this->injectCustomCSS();
        
        // Register view composers to modify views
        $this->registerViewComposers();
        
        logger()->info('[CustomBranding] Plugin booted successfully');
    }

    /**
     * Register event listeners for branding modifications
     * 
     * @return void
     */
    protected function registerEventListeners(): void
    {
        // Listen for view rendering events to inject custom branding
        Event::listen('view.rendering', function ($view) {
            $this->handleViewRendering($view);
        });

        // Listen for footer rendering
        Event::listen('featherpanel.footer.rendering', function () {
            return $this->handleFooterRendering();
        });

        // Listen for watermark rendering
        Event::listen('featherpanel.watermark.rendering', function () {
            return $this->handleWatermarkRendering();
        });

        // Listen for branding elements
        Event::listen('featherpanel.branding.rendering', function () {
            return $this->handleBrandingRendering();
        });
    }

    /**
     * Handle view rendering to inject custom branding
     * 
     * @param mixed $view
     * @return void
     */
    protected function handleViewRendering($view): void
    {
        $enableWatermarkRemoval = $this->getSetting('enable_watermark_removal');
        $enableFooterRemoval = $this->getSetting('enable_footer_removal');
        
        // Share branding variables with all views
        View::share('customBranding', [
            'removeWatermark' => $enableWatermarkRemoval === 'true' || $enableWatermarkRemoval === true,
            'removeFooter' => $enableFooterRemoval === 'true' || $enableFooterRemoval === true,
            'customFooterText' => $this->getSetting('custom_footer_text') ?? '',
            'customWatermarkText' => $this->getSetting('custom_watermark_text') ?? '',
            'customLogoUrl' => $this->getSetting('custom_logo_url') ?? '',
            'copyrightText' => $this->getSetting('copyright_text') ?? '',
        ]);
    }

    /**
     * Handle footer rendering
     * 
     * @return string|null
     */
    protected function handleFooterRendering(): ?string
    {
        $enableFooterRemoval = $this->getSetting('enable_footer_removal');
        $customFooterText = $this->getSetting('custom_footer_text');
        
        // If footer removal is enabled and no custom text, return null to hide
        if (($enableFooterRemoval === 'true' || $enableFooterRemoval === true) && empty($customFooterText)) {
            return null;
        }
        
        // If custom footer text is provided, return it
        if (!empty($customFooterText)) {
            $copyrightText = $this->getSetting('copyright_text');
            $year = date('Y');
            
            // Replace year placeholder
            $footerText = str_replace('{year}', $year, $customFooterText);
            
            // Replace copyright placeholder
            if (!empty($copyrightText)) {
                $footerText = str_replace('{copyright}', $copyrightText, $footerText);
            }
            
            return '<div class="custom-branding-footer">' . htmlspecialchars($footerText) . '</div>';
        }
        
        return null;
    }

    /**
     * Handle watermark rendering
     * 
     * @return string|null
     */
    protected function handleWatermarkRendering(): ?string
    {
        $enableWatermarkRemoval = $this->getSetting('enable_watermark_removal');
        $customWatermarkText = $this->getSetting('custom_watermark_text');
        
        // If watermark removal is enabled and no custom text, return null to hide
        if (($enableWatermarkRemoval === 'true' || $enableWatermarkRemoval === true) && empty($customWatermarkText)) {
            return null;
        }
        
        // If custom watermark text is provided, return it
        if (!empty($customWatermarkText)) {
            return '<div class="custom-branding-watermark">' . htmlspecialchars($customWatermarkText) . '</div>';
        }
        
        return null;
    }

    /**
     * Handle general branding rendering
     * 
     * @return array|null
     */
    protected function handleBrandingRendering(): ?array
    {
        $customLogoUrl = $this->getSetting('custom_logo_url');
        $copyrightText = $this->getSetting('copyright_text');
        
        $branding = [];
        
        if (!empty($customLogoUrl)) {
            $branding['logo_url'] = $customLogoUrl;
        }
        
        if (!empty($copyrightText)) {
            $branding['copyright'] = $copyrightText;
        }
        
        return !empty($branding) ? $branding : null;
    }

    /**
     * Inject custom CSS to remove default branding
     * 
     * @return void
     */
    protected function injectCustomCSS(): void
    {
        $enableWatermarkRemoval = $this->getSetting('enable_watermark_removal');
        $enableFooterRemoval = $this->getSetting('enable_footer_removal');
        
        $css = '<style id="custom-branding-styles">';
        
        // CSS to remove watermarks
        if ($enableWatermarkRemoval === 'true' || $enableWatermarkRemoval === true) {
            $css .= '
                /* Remove default FeatherPanel watermarks */
                .feather-watermark,
                .fp-watermark,
                [class*="watermark"]:not(.custom-branding-watermark),
                [data-watermark],
                .powered-by-feather,
                .featherpanel-credit {
                    display: none !important;
                    visibility: hidden !important;
                }
            ';
        }
        
        // CSS to remove footer branding
        if ($enableFooterRemoval === 'true' || $enableFooterRemoval === true) {
            $css .= '
                /* Remove default FeatherPanel footer elements */
                .feather-footer .default-branding,
                .fp-footer .default-branding,
                footer .featherpanel-branding,
                footer [class*="feather-credit"]:not(.custom-branding-footer) {
                    display: none !important;
                    visibility: hidden !important;
                }
            ';
        }
        
        // Add styling for custom branding elements
        $css .= '
            /* Custom branding styles */
            .custom-branding-footer {
                padding: 1rem;
                text-align: center;
                background-color: #1a1a1a;
                color: #ffffff;
                width: 100%;
            }
            
            .custom-branding-watermark {
                position: fixed;
                bottom: 10px;
                right: 10px;
                color: #666666;
                opacity: 0.7;
                font-size: 0.875rem;
                pointer-events: none;
                z-index: 9999;
            }
        ';
        
        $css .= '</style>';
        
        // Add CSS to the head section
        add_action('wp_head', function () use ($css) {
            echo $css;
        });
    }

    /**
     * Register view composers to modify views
     * 
     * @return void
     */
    protected function registerViewComposers(): void
    {
        // Compose footer views
        View::composer('*', function ($view) {
            $customFooterText = $this->getSetting('custom_footer_text');
            if (!empty($customFooterText)) {
                $view->with('customFooter', $customFooterText);
            }
        });
        
        // Compose watermark views
        View::composer('*', function ($view) {
            $customWatermarkText = $this->getSetting('custom_watermark_text');
            if (!empty($customWatermarkText)) {
                $view->with('customWatermark', $customWatermarkText);
            }
        });
    }

    /**
     * Get a plugin setting value
     * 
     * @param string $key
     * @return mixed
     */
    protected function getSetting(string $key)
    {
        return PluginSettings::getSetting($this->identifier, $key);
    }

    /**
     * Set a default configuration value if not already set
     * 
     * @param string $key
     * @param mixed $value
     * @return void
     */
    protected function setDefaultConfig(string $key, $value): void
    {
        $existing = PluginSettings::getSetting($this->identifier, $key);
        
        if ($existing === null) {
            PluginSettings::setSetting($this->identifier, $key, $value);
        }
    }

    /**
     * Uninstall the plugin
     * 
     * This method is called when the plugin is uninstalled.
     * It cleans up any resources and removes configurations.
     * 
     * @return void
     */
    public function uninstall(): void
    {
        logger()->info('[CustomBranding] Uninstalling Custom Branding Plugin');
        
        // Clean up plugin settings if needed
        // Note: FeatherPanel may handle this automatically
        
        logger()->info('[CustomBranding] Plugin uninstalled successfully');
    }
}
