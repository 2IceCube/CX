<?php

namespace Plugins\CustomBranding\Events;

use App\Plugins\PluginSettings;
use Illuminate\Support\Facades\View;

/**
 * Branding Events Handler
 * 
 * Handles all branding-related events for the Custom Branding plugin.
 * This includes watermark removal, footer modification, and custom branding injection.
 * 
 * @package CustomBranding\Events
 * @version 1.0.0
 * @author 2IceCube
 */
class BrandingEvents
{
    /**
     * Plugin identifier
     */
    protected string $pluginId = 'custom_branding';

    /**
     * Handle watermark removal event
     * 
     * @return string|null Returns null to remove watermark, or custom HTML
     */
    public function onWatermarkRender(): ?string
    {
        $removeWatermark = $this->getSetting('enable_watermark_removal');
        $customWatermark = $this->getSetting('custom_watermark_text');
        
        // Remove default watermark if enabled
        if ($this->isEnabled($removeWatermark)) {
            // If custom watermark text is provided, show it
            if (!empty($customWatermark)) {
                return $this->renderCustomWatermark($customWatermark);
            }
            
            // Otherwise, remove watermark entirely
            return null;
        }
        
        // Return default watermark (don't modify)
        return 'default';
    }

    /**
     * Handle footer removal event
     * 
     * @return string|null Returns null to remove footer, or custom HTML
     */
    public function onFooterRender(): ?string
    {
        $removeFooter = $this->getSetting('enable_footer_removal');
        $customFooter = $this->getSetting('custom_footer_text');
        
        // Remove default footer if enabled
        if ($this->isEnabled($removeFooter)) {
            // If custom footer text is provided, show it
            if (!empty($customFooter)) {
                return $this->renderCustomFooter($customFooter);
            }
            
            // Otherwise, remove footer entirely
            return null;
        }
        
        // Return default footer (don't modify)
        return 'default';
    }

    /**
     * Handle logo customization event
     * 
     * @return array|null Returns logo configuration or null for default
     */
    public function onLogoRender(): ?array
    {
        $customLogoUrl = $this->getSetting('custom_logo_url');
        
        if (!empty($customLogoUrl)) {
            return [
                'url' => $customLogoUrl,
                'alt' => 'Custom Logo',
                'custom' => true,
            ];
        }
        
        return null;
    }

    /**
     * Handle branding elements event
     * 
     * @return array Custom branding configuration
     */
    public function onBrandingRender(): array
    {
        $copyrightText = $this->getSetting('copyright_text');
        $customLogoUrl = $this->getSetting('custom_logo_url');
        
        $branding = [];
        
        if (!empty($copyrightText)) {
            $branding['copyright'] = $this->processCopyrightText($copyrightText);
        }
        
        if (!empty($customLogoUrl)) {
            $branding['logo'] = $customLogoUrl;
        }
        
        return $branding;
    }

    /**
     * Render custom watermark HTML
     * 
     * @param string $text Watermark text
     * @return string HTML for custom watermark
     */
    protected function renderCustomWatermark(string $text): string
    {
        $safeText = htmlspecialchars($text, ENT_QUOTES, 'UTF-8');
        
        return sprintf(
            '<div class="custom-branding-watermark" style="position:fixed;bottom:10px;right:10px;color:#666;opacity:0.7;font-size:0.875rem;pointer-events:none;z-index:9999;">%s</div>',
            $safeText
        );
    }

    /**
     * Render custom footer HTML
     * 
     * @param string $text Footer text
     * @return string HTML for custom footer
     */
    protected function renderCustomFooter(string $text): string
    {
        $copyrightText = $this->getSetting('copyright_text');
        
        // Process text with replacements
        $processedText = $this->processFooterText($text, $copyrightText);
        $safeText = htmlspecialchars($processedText, ENT_QUOTES, 'UTF-8');
        
        return sprintf(
            '<div class="custom-branding-footer" style="padding:1rem;text-align:center;background-color:#1a1a1a;color:#fff;width:100%%;">%s</div>',
            $safeText
        );
    }

    /**
     * Process footer text with variable replacements
     * 
     * @param string $text Footer text
     * @param string|null $copyrightText Copyright text
     * @return string Processed text
     */
    protected function processFooterText(string $text, ?string $copyrightText = null): string
    {
        $processed = $text;
        
        // Replace {year} with current year
        $processed = str_replace('{year}', date('Y'), $processed);
        
        // Replace {copyright} with copyright text
        if (!empty($copyrightText)) {
            $processed = str_replace('{copyright}', $copyrightText, $processed);
        }
        
        return $processed;
    }

    /**
     * Process copyright text with variable replacements
     * 
     * @param string $text Copyright text
     * @return string Processed text
     */
    protected function processCopyrightText(string $text): string
    {
        // Replace {year} with current year
        return str_replace('{year}', date('Y'), $text);
    }

    /**
     * Get plugin setting
     * 
     * @param string $key Setting key
     * @return mixed Setting value
     */
    protected function getSetting(string $key)
    {
        return PluginSettings::getSetting($this->pluginId, $key);
    }

    /**
     * Check if a boolean setting is enabled
     * 
     * @param mixed $value Setting value
     * @return bool True if enabled
     */
    protected function isEnabled($value): bool
    {
        return $value === 'true' || $value === true || $value === 1 || $value === '1';
    }

    /**
     * Inject CSS to remove default branding elements
     * 
     * @return string CSS code
     */
    public function getCustomCSS(): string
    {
        $removeWatermark = $this->isEnabled($this->getSetting('enable_watermark_removal'));
        $removeFooter = $this->isEnabled($this->getSetting('enable_footer_removal'));
        
        $css = '';
        
        if ($removeWatermark) {
            $css .= '
                /* Remove default FeatherPanel watermarks */
                .feather-watermark,
                .fp-watermark,
                [class*="watermark"]:not(.custom-branding-watermark),
                [data-watermark],
                .powered-by-feather,
                .featherpanel-credit,
                .mystics-watermark {
                    display: none !important;
                    visibility: hidden !important;
                    opacity: 0 !important;
                }
            ';
        }
        
        if ($removeFooter) {
            $css .= '
                /* Remove default FeatherPanel footer elements */
                .feather-footer .default-branding,
                .fp-footer .default-branding,
                footer .featherpanel-branding,
                footer [class*="feather-credit"]:not(.custom-branding-footer),
                footer .mystics-footer {
                    display: none !important;
                    visibility: hidden !important;
                    opacity: 0 !important;
                }
            ';
        }
        
        // Add custom branding styles
        $css .= '
            /* Custom branding element styles */
            .custom-branding-footer {
                padding: 1rem;
                text-align: center;
                background-color: #1a1a1a;
                color: #ffffff;
                width: 100%;
                margin: 0;
            }
            
            .custom-branding-footer a {
                color: #4a9eff;
                text-decoration: none;
            }
            
            .custom-branding-footer a:hover {
                text-decoration: underline;
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
                font-family: system-ui, -apple-system, sans-serif;
            }
        ';
        
        return $css;
    }
}
