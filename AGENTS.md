# Agent Guidelines for AstroNvim Configuration

## Build/Lint/Test Commands
- **Lint**: `stylua --check .` (format: `stylua .`)
- **Lint Lua**: `selene .` (static analysis)
- **Test**: This is a Neovim config - test by running `:checkhealth` in Neovim
- **Reload**: `:source` or `<leader>so` after editing

## Code Style
- **Language**: Lua 5.1 (Neovim runtime)
- **Formatter**: StyLua with config in `.stylua.toml`
- **Indent**: 4 spaces, Unix line endings, 120 column width
- **Quotes**: Auto-prefer double quotes
- **Call parentheses**: None (Lua style: `require "module"` not `require("module")`)
- **Comments**: Use `--` for single line, avoid unless necessary
- **Type annotations**: Use EmmyLua annotations (`---@type`, `---@param`)

## File Structure
- Plugin configs in `lua/plugins/*.lua` - each returns a LazySpec table
- Use `---@type LazySpec` annotation at top of plugin files
- Import community plugins in `lua/community.lua`
- Custom keymaps/options in `lua/plugins/astrocore.lua`

## Naming & Conventions
- Plugin files: lowercase with hyphens matching plugin name
- Functions: snake_case
- Never commit commented code - remove it
- Follow existing patterns from neighboring files before adding new code

## SpecKit Slash Commands

The agent has access to the following slash commands for specification-driven development:

### `/speckit.specify <feature description>`
Create or update feature specification from natural language.
- Generates spec.md with user stories, requirements, success criteria
- Creates branch and checklist for validation
- Use for: Starting new features, documenting requirements

### `/speckit.clarify [context]`
Identify and resolve spec ambiguities (up to 5 targeted questions).
- Detects missing decisions, vague requirements, edge cases
- Updates spec.md with clarifications
- Use after: `/speckit.specify`, before `/speckit.plan`

### `/speckit.plan [context]`
Generate technical implementation plan from spec.
- Creates plan.md, data-model.md, contracts/, research.md
- Resolves technical unknowns through research
- Use after: `/speckit.clarify` (or `/speckit.specify` if no ambiguities)

### `/speckit.tasks [context]`
Generate dependency-ordered implementation tasks from plan.
- Creates tasks.md organized by user story
- Identifies parallel execution opportunities
- Use after: `/speckit.plan`

### `/speckit.checklist <type> [options]`
Generate custom checklist for requirements validation.
- Types: ux, api, security, performance, etc.
- Tests requirement quality (completeness, clarity, consistency)
- Use: Any time to validate spec quality before implementation

### `/speckit.analyze [context]`
Cross-artifact consistency analysis (spec, plan, tasks).
- Detects duplications, conflicts, coverage gaps
- Validates constitution alignment
- Use after: `/speckit.tasks`, before `/speckit.implement`

### `/speckit.implement [context]`
Execute implementation plan by processing tasks.md.
- Checks checklist completion status
- Follows TDD if tests specified
- Creates ignore files, implements features phase-by-phase
- Use after: `/speckit.tasks` (and optionally `/speckit.analyze`)

### `/speckit.constitution [principles]`
Create or update project constitution (governance and principles).
- Defines non-negotiable development rules
- Syncs with spec/plan/task templates
- Use: Project setup or when changing core principles

### Command Flow
```
/speckit.specify → /speckit.clarify → /speckit.plan → /speckit.tasks → /speckit.analyze → /speckit.implement
                     (optional)                        (optional)     (optional)
```

### When to Use SpecKit Commands
Use for:
- Feature development requiring clear requirements
- Complex features needing structured planning
- Team projects requiring shared understanding
- Features with multiple user stories or phases

Skip for:
- Small bug fixes
- Simple refactoring
- Configuration changes
- Trivial updates
