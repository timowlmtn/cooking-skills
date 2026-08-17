---
name: store-cookbook
description: Use this skill whenever the user wants to store, catalog, digitize, or archive a cookbook's recipes into the CookingSkills project. Trigger on requests like "add this cookbook to my collection", "store these recipes from [book]", "digitize my cookbook", "save the recipes from [title]", "catalog this cookbook", or when the user pastes/uploads recipe text or a photo of a cookbook page and wants it kept for later. Also trigger if the user references a cookbook by name (e.g., "the Timberline Lodge Cookbook") and asks to save, log, or record recipes from it. Handles both physical books the user is transcribing and text/images they provide directly.
---

# Store Cookbook

Build a personal, searchable archive of full recipes from a cookbook inside this project, organized by book and then by
season/category. Each cookbook gets its own folder with a metadata file plus one markdown file per recipe. The goal is a
library the user (or a future Claude session) can browse, grep, or read straight through — not just a note that a book
exists.

## Why this structure

Recipes get more useful the more consistently they're captured — ingredients in a scannable list, instructions numbered,
source always traceable back to the book and page. A flat pile of pasted text degrades over time; one file per recipe
with consistent fields makes it possible to search across the whole collection later (e.g. "what uses buttermilk") or
hand a single file to someone else.

## Where things live

```
CookingSkills/
└── cookbooks/
    └── <book-slug>/
        ├── book.md              # metadata about the cookbook itself
        └── recipes/
            ├── spring/
            ├── summer/
            ├── fall/
            ├── winter/
            └── uncategorized/    # use if the book isn't organized by season
                └── <recipe-slug>.md
```

`<book-slug>` is the title in lowercase-hyphenated form, e.g. `timberline-lodge-cookbook`. If the book organizes recipes
by something other than season (course, region, chapter name), mirror that folder structure instead of forcing seasons —
the point is to match the book's own organization so it stays recognizable.

## Workflow

1. **Check for an existing book folder.** Before creating anything, look under `cookbooks/` for a folder that matches
   the book. If it exists, add to it rather than starting over.

2. **Create or update `book.md`** using `assets/book-template.md`. Fill in whatever is known (title, author, publisher,
   year, edition, ISBN) and leave the rest blank rather than guessing. If details are uncertain, say so in the file
   instead of stating them as fact.

3. **For each recipe**, create one file at `recipes/<season-or-category>/<recipe-slug>.md` using
   `assets/recipe-template.md`. Transcribe faithfully:
    - Keep ingredient quantities and units exactly as written in the source.
    - Number the instructions in the order given.
    - Note the source page number when known — this is what makes the archive trustworthy later.
    - If the user only has a photo or partial text, capture what's legible and mark anything uncertain or missing rather
      than inventing it.

4. **Slug filenames** consistently: lowercase, hyphens instead of spaces, no punctuation (e.g.
   `alpenglow-berry-soup.md`).

5. **After adding recipes**, briefly confirm what was saved and where — the user shouldn't have to go digging to find
   out.

## Extracting from images or messy text

If the user provides a photo of a cookbook page, read it carefully before transcribing — cookbook scans often have
ingredients in a sidebar and instructions in a separate column, easy to merge in the wrong order. If any word is
unclear, write `[unclear: best guess]` rather than silently normalizing it.

## When information is incomplete

Don't fabricate missing fields (page numbers, exact quantities, publication year, etc.). Leave them blank or mark them
`unknown` — a gap is more useful than a confident wrong answer, since this archive is meant to be a reliable reference.
