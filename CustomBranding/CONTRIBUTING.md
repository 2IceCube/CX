# Contributing to Custom Branding Plugin

Thank you for your interest in contributing to the Custom Branding Plugin! This document provides guidelines and instructions for contributing.

## Table of Contents

1. [Code of Conduct](#code-of-conduct)
2. [Getting Started](#getting-started)
3. [How to Contribute](#how-to-contribute)
4. [Development Setup](#development-setup)
5. [Coding Standards](#coding-standards)
6. [Testing](#testing)
7. [Submitting Changes](#submitting-changes)
8. [Reporting Bugs](#reporting-bugs)
9. [Suggesting Features](#suggesting-features)

## Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inclusive environment for all contributors. We expect all participants to:

- Be respectful and considerate
- Accept constructive criticism gracefully
- Focus on what's best for the community
- Show empathy towards others

## Getting Started

### Prerequisites

Before contributing, ensure you have:

- Git installed and configured
- Node.js 14.0.0 or higher
- A code editor (VS Code, Sublime, etc.)
- Access to a FeatherPanel test environment
- Basic knowledge of JavaScript and JSON

### Fork and Clone

1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/CX.git
   cd CX
   ```
3. Add upstream remote:
   ```bash
   git remote add upstream https://github.com/2IceCube/CX.git
   ```

## How to Contribute

### Types of Contributions

We welcome various types of contributions:

1. **Bug Fixes** - Fix issues and bugs
2. **Features** - Add new functionality
3. **Documentation** - Improve docs and examples
4. **Testing** - Add or improve tests
5. **Code Quality** - Refactor and optimize
6. **Translations** - Add multi-language support

### Contribution Workflow

1. **Check existing issues** - See if your idea/bug is already tracked
2. **Open an issue** - Discuss your proposal before coding
3. **Create a branch** - Work on a feature branch
4. **Write code** - Follow coding standards
5. **Test thoroughly** - Ensure everything works
6. **Submit PR** - Create a pull request with clear description
7. **Address feedback** - Respond to review comments
8. **Celebrate** - Your contribution is merged! 🎉

## Development Setup

### Setting Up Your Environment

1. **Install dependencies** (if any are added in the future):
   ```bash
   cd CustomBranding
   npm install
   ```

2. **Create a test FeatherPanel instance**:
   - Install FeatherPanel in a development environment
   - Copy the plugin to the plugins directory
   - Enable developer mode if available

3. **Create a test configuration**:
   ```bash
   cp config.example.json config.test.json
   ```

4. **Enable file watching** (optional):
   ```bash
   # Set up file watcher to auto-reload on changes
   npm run watch
   ```

### Directory Structure

Familiarize yourself with the structure:

```
CustomBranding/
├── src/              # Source code
├── assets/           # CSS and static files
├── examples/         # Configuration examples
├── tests/            # Tests (future)
└── docs/             # Documentation
```

## Coding Standards

### JavaScript Style Guide

Follow these conventions for JavaScript code:

#### Formatting
- **Indentation**: 4 spaces (no tabs)
- **Line Length**: Maximum 100 characters
- **Quotes**: Use single quotes for strings
- **Semicolons**: Always use semicolons

#### Naming Conventions
- **Variables**: camelCase (`myVariable`)
- **Functions**: camelCase (`myFunction()`)
- **Classes**: PascalCase (`MyClass`)
- **Constants**: UPPER_SNAKE_CASE (`MY_CONSTANT`)
- **Private methods**: Prefix with underscore (`_privateMethod()`)

#### Example
```javascript
class CustomBrandingPlugin {
    constructor() {
        this.config = null;
        this.CONFIG_PATH = path.join(__dirname, '../config.json');
    }

    /**
     * Load configuration from file
     * @returns {Object} Configuration object
     */
    loadConfig() {
        try {
            const data = fs.readFileSync(this.CONFIG_PATH, 'utf8');
            return JSON.parse(data);
        } catch (error) {
            console.error('Error loading config:', error.message);
            return this._getDefaultConfig();
        }
    }

    _getDefaultConfig() {
        return {
            // Default configuration
        };
    }
}
```

### CSS Style Guide

#### Formatting
- **Indentation**: 4 spaces
- **Selectors**: One selector per line
- **Properties**: One property per line
- **Braces**: Opening brace on same line, closing brace on new line

#### Naming
- Use descriptive class names
- Prefix custom classes with `custom-`
- Use kebab-case for class names

#### Example
```css
.custom-branding-footer {
    width: 100%;
    padding: 1rem 2rem;
    background-color: #1a1a1a;
    color: #ffffff;
}

.custom-branding-footer-link {
    color: #4a9eff;
    text-decoration: none;
    transition: color 0.3s ease;
}
```

### JSON Style Guide

- Use 2 or 4 spaces for indentation (consistent throughout)
- Always validate JSON before committing
- Add comments using `_comment` fields
- Keep configuration options organized

## Testing

### Manual Testing

Before submitting changes:

1. **Test basic functionality**:
   - Plugin loads without errors
   - Configuration is applied correctly
   - UI changes are visible

2. **Test on multiple browsers**:
   - Chrome
   - Firefox
   - Safari
   - Edge

3. **Test responsive design**:
   - Desktop
   - Tablet
   - Mobile

4. **Test configuration options**:
   - Try different combinations
   - Test edge cases
   - Verify error handling

### Testing Checklist

Use the [TESTING.md](TESTING.md) checklist to ensure comprehensive testing.

### Automated Testing (Future)

When automated tests are added:

```bash
npm test           # Run all tests
npm test:unit      # Run unit tests
npm test:e2e       # Run end-to-end tests
npm run coverage   # Generate coverage report
```

## Submitting Changes

### Creating a Branch

Create a descriptive branch name:

```bash
git checkout -b feature/add-theme-presets
git checkout -b fix/footer-alignment-issue
git checkout -b docs/improve-installation-guide
```

Branch naming convention:
- `feature/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation changes
- `refactor/` - Code refactoring
- `test/` - Adding tests

### Commit Messages

Write clear, descriptive commit messages:

#### Format
```
<type>: <subject>

<body>

<footer>
```

#### Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance tasks

#### Examples
```
feat: Add theme preset functionality

Implement a system for loading predefined theme presets.
Users can now select from 5 built-in themes or create custom ones.

Closes #42
```

```
fix: Footer alignment on mobile devices

Fixed an issue where the footer text was not properly centered
on screens smaller than 768px.

Fixes #38
```

### Pull Request Process

1. **Update your branch**:
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Push your changes**:
   ```bash
   git push origin feature/your-feature-name
   ```

3. **Create Pull Request**:
   - Go to GitHub and create a pull request
   - Fill out the PR template
   - Link related issues
   - Add screenshots if UI changes

4. **PR Title Format**:
   ```
   [Type] Brief description
   ```
   Examples:
   - `[Feature] Add multi-language support`
   - `[Fix] Resolve watermark positioning bug`
   - `[Docs] Update installation instructions`

5. **PR Description**:
   Include:
   - What changed
   - Why it changed
   - How to test
   - Screenshots (if applicable)
   - Breaking changes (if any)

### Review Process

- Maintainers will review your PR
- Address feedback promptly
- Make requested changes
- Re-request review when ready

## Reporting Bugs

### Before Reporting

- Check if bug is already reported
- Test on latest version
- Reproduce the bug consistently
- Gather relevant information

### Bug Report Template

```markdown
**Bug Description**
A clear description of the bug.

**To Reproduce**
Steps to reproduce:
1. Go to '...'
2. Click on '...'
3. See error

**Expected Behavior**
What should happen.

**Actual Behavior**
What actually happens.

**Screenshots**
If applicable, add screenshots.

**Environment**
- FeatherPanel Version: [e.g., 1.2.0]
- Plugin Version: [e.g., 1.0.0]
- Browser: [e.g., Chrome 120]
- OS: [e.g., Ubuntu 22.04]

**Additional Context**
Any other relevant information.

**Configuration**
```json
{
  // Your config.json (redact sensitive info)
}
```
```

## Suggesting Features

### Feature Request Template

```markdown
**Feature Description**
Clear description of the proposed feature.

**Problem Statement**
What problem does this solve?

**Proposed Solution**
How should this work?

**Alternatives Considered**
Other approaches you've thought about.

**Additional Context**
Screenshots, mockups, or examples.

**Priority**
- [ ] Low
- [ ] Medium
- [ ] High
```

## Documentation

### Documentation Standards

When updating documentation:

- Use clear, concise language
- Include examples
- Add screenshots for UI features
- Keep formatting consistent
- Update table of contents if needed
- Check for broken links

### Documentation Structure

- **README.md** - Main documentation
- **INSTALLATION.md** - Setup instructions
- **QUICKSTART.md** - Fast start guide
- **TESTING.md** - Testing procedures
- **CHANGELOG.md** - Version history

## Questions?

If you have questions:

1. Check existing documentation
2. Search closed issues
3. Ask on FeatherPanel Discord
4. Open a discussion on GitHub

## Recognition

Contributors will be:

- Listed in CHANGELOG.md
- Mentioned in release notes
- Added to a CONTRIBUTORS.md file (if created)

---

## Quick Reference

### Useful Commands

```bash
# Keep your fork updated
git fetch upstream
git merge upstream/main

# Create a branch
git checkout -b feature/my-feature

# Validate JSON
jq empty config.json

# Stage changes
git add .

# Commit with message
git commit -m "feat: Add new feature"

# Push to your fork
git push origin feature/my-feature
```

### Resources

- [FeatherPanel Documentation](https://featherpanel.com/docs)
- [FeatherPanel Discord](https://discord.mythical.systems)
- [JavaScript MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
- [Git Handbook](https://guides.github.com/introduction/git-handbook/)

---

**Thank you for contributing!** Your help makes this plugin better for everyone. 🎉
