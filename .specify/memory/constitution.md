# AstroNvim Configuration Constitution

## Core Principles

### I. Lua-First Development
All configuration code written in Lua 5.1 (Neovim runtime); No VimScript unless absolutely necessary for legacy compatibility; Follow idiomatic Lua patterns: `require "module"` not `require("module")`; Use EmmyLua type annotations for clarity

### II. Plugin Structure & Modularity
Each plugin config in `lua/plugins/*.lua` returns a LazySpec table; Files prefixed with `---@type LazySpec` annotation; Community plugins imported via `lua/community.lua`; Custom keymaps/options centralized in `lua/plugins/astrocore.lua`; One concern per file, follow existing patterns

### III. Code Quality (NON-NEGOTIABLE)
StyLua formatting mandatory before commit: `stylua .`; Selene linting required: `selene .`; Zero tolerance for commented-out code - delete it; 120 column width, 4 space indent, double quotes preferred; Test via `:checkhealth` in Neovim before finalizing

### IV. Convention Consistency
Plugin files named lowercase-with-hyphens matching plugin name; Functions use snake_case; Never assume library availability - check package.json/lazy config first; Mimic existing code style in neighboring files; Follow AstroNvim community patterns

### V. Minimalism & Clarity
Avoid comments unless documenting non-obvious behavior; Keep configurations simple and maintainable; No premature optimization; Document "why" not "what" when comments are needed; Prefer built-in Neovim features over external dependencies

## Configuration Management

### Version Control
Never commit secrets or API keys; `.gitignore` enforced for sensitive files; Meaningful commit messages focused on intent; Branch naming: `feature/`, `fix/`, `refactor/` prefixes

### File Organization
`init.lua` is entry point - minimal, delegates to modules; `lua/community.lua` for community plugin imports; `lua/plugins/` for plugin configurations; `lua/lazy_setup.lua` for Lazy.nvim bootstrap; `lua/polish.lua` for post-setup customizations

### Testing & Validation
Run `:checkhealth` after configuration changes; Test keybindings manually before committing; Verify LSP, Treesitter, DAP functionality; Check startup time with `nvim --startuptime startup.log`

## Development Workflow

### Change Process
1. Read existing configs to understand patterns
2. Make minimal, focused changes
3. Run `stylua .` to format
4. Run `selene .` for linting
5. Test with `:checkhealth` and manual verification
6. Reload config with `:source` or `<leader>so`

### SpecKit Integration
Use SpecKit for complex features requiring planning; Skip SpecKit for simple config changes, keybinding additions, or plugin installations; Constitution supersedes SpecKit defaults when conflicts arise

### Breaking Changes
Document breaking changes in commit messages; Update README.md if user-facing behavior changes; Test backward compatibility when possible; Communicate deprecations clearly

## Governance

Constitution is authoritative for all development; Amendments require rationale and approval; All changes must pass formatting and linting; Complexity must be justified; Use AGENTS.md for runtime development guidance

**Version**: 1.0.0 | **Ratified**: 2025-10-17 | **Last Amended**: 2025-10-17
