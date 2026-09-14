# Underwater Desert Blogging

An old man yells at his loopback

This is a static site built with the `seite` CLI tool.

## Commands

```bash
seite build                              # Build the site
seite build --drafts                     # Build including draft content
seite serve                              # Dev server with live reload + REPL
seite serve --open                       # Dev server + open browser
seite serve --port 8080                  # Use a specific port
seite new post "Title"                  # Create new post
seite new page "Title"                  # Create new page
seite new post "Title" --tags rust,web   # Create with tags
seite new post "Title" --draft           # Create as draft
seite new post "Title" --lang es         # Create translation (needs [languages.es] in config)
seite collection list                    # List site collections
seite collection add <preset>            # Add a preset collection (posts, docs, pages, changelog, roadmap, trust)
seite theme list                         # List available themes
seite theme apply <name>                 # Apply a bundled theme (default, minimal, dark, docs, brutalist, bento, landing, terminal, magazine, academic)
seite theme create "coral brutalist"     # Generate a custom theme with AI (requires Claude Code)
seite theme install <url>                # Install theme from URL
seite theme export <name>                # Export current theme for sharing
seite agent                              # Interactive AI agent session
seite agent "write about Rust"           # One-shot AI agent prompt
seite deploy                             # Commit, push, build, and deploy
seite deploy --no-commit                 # Deploy without auto-commit/push
seite completions bash                   # Generate shell completions
```

### Dev Server REPL

`seite serve` starts a dev server with live reload and an interactive REPL:

```
new <collection> <title> [--lang <code>]  Create new content
agent [prompt]                           Start AI agent or run one-shot
theme <name>                             Apply a theme
build [--drafts]                         Rebuild the site
status                                   Show server info
stop                                     Stop and exit
```

## Project Structure

```
content/posts/    # Posts content (markdown + YAML frontmatter)
content/pages/    # Pages content (markdown + YAML frontmatter)
templates/       # Tera (Jinja2-compatible) HTML templates
static/          # Static assets (copied as-is to dist/)
data/            # Data files (YAML/JSON/TOML) → {{ data.filename }} in templates
dist/            # Build output (generated, do not edit)
seite.toml        # Site configuration
```

## Collections

### Posts
- Directory: `content/posts/`
- URL prefix: `/posts`
- Template: `post.html`
- Date-based: yes (filename format: `YYYY-MM-DD-slug.md`)
- Included in RSS feed (`/feed.xml`) and Atom feed (`/atom.xml`)

### Pages
- Directory: `content/pages/`
- URL prefix: `(root)`
- Template: `page.html`
- Date-based: no (filename format: `slug.md`)

## Content Format

Content files are markdown with YAML frontmatter:

```yaml
---
title: "Post Title"
date: 2025-01-15        # required for dated collections
description: "Optional"  # page description — used in meta/OG/Twitter/JSON-LD
image: /static/og.png    # optional social-preview image (og:image / twitter:image)
updated: 2025-06-01      # optional last-modified date → JSON-LD dateModified
tags:                     # optional
  - tag1
  - tag2
draft: true              # optional, hides from default build
slug: custom-slug        # optional, overrides auto-generated slug
template: custom.html    # optional, overrides collection default template
robots: noindex          # optional, per-page <meta name="robots">
weight: 1                # optional, sort order for non-date collections (lower first)
aliases:                 # optional, old URLs that redirect to this page
  - /old-url
extra:                   # optional, arbitrary data → {{ page.extra.field }}
  key: value
---

Markdown content here.
```

Use `<!-- more -->` in content to mark the excerpt boundary. Without it, the first paragraph is used as the excerpt.

### Homepage

To add custom content to the homepage, create `content/pages/index.md`. Its rendered content will appear above the collection listings on the index page. The homepage is injected as `{{ page.content }}` in the index template.

### Landing Page Builder Skill

Run `/landing-page` to start a guided flow for creating or redesigning any landing page — the site homepage, a product page, a launch page, or any standalone marketing page. The skill walks through messaging and positioning first (audience, value prop, voice, differentiation), drafts the actual copy for approval, then proposes page structure and builds the content file and Tera template. Iterates until you are happy with the result.

## MCP Server

An MCP server is configured in `.claude/settings.json` and starts automatically.
Resources: `seite://config`, `seite://content`, `seite://docs`, `seite://themes`
Tools: `seite_build`, `seite_create_content`, `seite_search`, `seite_apply_theme`, `seite_lookup_docs`

## Contact Forms

Contact forms are available via the `{{< contact_form() >}}` shortcode.
Run `seite contact setup` to configure a provider (Formspree, Web3Forms, Netlify Forms, HubSpot, Typeform).

### Theme Builder Skill

Run `/theme-builder` to create or customize your site's theme interactively. The skill walks through site purpose, audience, and visual direction first (mood, references, screenshots, colors, typography, layout), then generates a complete `templates/base.html` with all SEO, accessibility, search, pagination, and i18n requirements built in. Iterates until you are happy with the result.

### Brand Identity Builder Skill

Run `/brand-identity` to create a visual identity for your site — logo (SVG), color palette, and favicon. The skill walks through brand personality, audience, and visual preferences first, then generates an SVG logo, a color system saved to `data/brand.yaml`, and a favicon. Colors are available in templates as `{{ data.brand.colors.primary }}`. Optionally applies the palette to your site theme.

## Key Conventions

- Run `seite build` after creating or editing content to regenerate the site
- URLs are clean (no extension): `/{collection-url-prefix}/hello-world` on disk is `dist/{collection-url-prefix}/hello-world.html` (e.g. `/blog/hello-world`)
- Templates use Tera syntax and extend `base.html`
- Use `{{ page.content | safe }}` to render HTML content (the `safe` filter is required)
- Themes only replace `base.html` — collection templates (`post.html`, `doc.html`, `page.html`) are separate
- The `static/` directory is copied as-is to `dist/static/` during build
- Pagination: add `paginate = 10` to a `[[collections]]` block in `seite.toml` to generate paginated index pages (e.g. `/blog/`, `/blog/page/2/`, etc.)
  Use `{% if pagination %}<nav>...</nav>{% endif %}` in templates; variables: `pagination.current_page`, `pagination.total_pages`, `pagination.prev_url`, `pagination.next_url`
- Search is always enabled: `dist/search-index.json` is generated every build. All bundled themes include a search box wired to it. No config needed.
- Custom theme: `seite theme create "your design description"` generates `templates/base.html` with Claude (requires Claude Code)
- Deploy auto-commits and pushes before deploying. On non-main branches, it auto-uses preview mode. Disable with `auto_commit = false` in `[deploy]` or `--no-commit` flag

## Context Rules

Detailed guides for templates, SEO, i18n, data files, shortcodes, configuration, and more are in `.claude/rules/` and load automatically when working with matching files.

## Documentation

Full documentation: <https://seite.sh/docs/getting-started>

- [Getting Started](https://seite.sh/docs/getting-started) — install and create your first site
- [Configuration](https://seite.sh/docs/configuration) — full `seite.toml` reference
- [Templates & Themes](https://seite.sh/docs/templates) — customize templates and themes
- [Shortcodes](https://seite.sh/docs/shortcodes) — reusable content components
- [CLI Reference](https://seite.sh/docs/cli-reference) — all commands and flags
- [AI Agent](https://seite.sh/docs/agent) — using the AI assistant
