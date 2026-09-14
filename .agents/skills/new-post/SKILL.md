---
name: new-post
description: Create a new Seité blog post with a relevant Unsplash cover image, attribution, a starting sentence, and the site's `~ # ~` signoff. Use when the user asks to create, draft, or start a post.
---

# New Post

Create posts using the site's established Seité conventions.

## Workflow

1. Read `seite.toml`, `templates/post.html`, and `content/archive/2020-04-11-resilience-is-not-insurance.md` before creating anything.
2. Create the post with Seité's CLI. Do not create the Markdown file by hand.

   ```bash
   seite new post "Post Title"
   ```

3. Find a specific, relevant photo on Unsplash. Do not use a random-image endpoint. Record the photographer's displayed name and `@username` from the Unsplash photo page.
4. Download the chosen image into `static/img/YYYY/slug.jpg` and use that local path in frontmatter. Do not leave the cover dependent on an Unsplash hotlink.
5. Replace the generated frontmatter with the site's post shape:

   ```yaml
   ---
   date: YYYY-MM-DD
   title: "Post Title"
   description: "A concise description for search and social previews."
   image: /static/img/YYYY/slug.jpg
   extra:
     coverAttribution:
       photog: "Photographer Name"
       username: "@username"
   tags:
     - relevant-tag
   ---
   ```

   `image` is Seité's supported cover and social-preview field. Keep custom image attribution under `extra.coverAttribution` so `templates/post.html` can render it.
6. Add one simple opening sentence that gives the author something concrete to continue from. Do not write a full draft unless asked.
7. End the post with the exact signoff on its own line:

   ```markdown
   ~ # ~
   ```

8. Run `pnpm build` and confirm the hero image and cover attribution render in the generated post.

## Constraints

- Use Node for any script work. Do not use Python.
- Use the local image path in `image:`; do not use unsupported top-level `cover` or `coverAttribution` fields.
- Keep cover attribution accurate and linkable through the photographer's Unsplash username.
- Preserve the post's generated filename and date unless the user asks otherwise.
