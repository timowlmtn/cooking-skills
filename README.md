# CookingSkills

A personal, file-based system for archiving recipes, planning meals around what's actually in the fridge, and cooking from short phone-ready instructions. Everything is plain markdown — no app, no database — so it's easy to read, edit, or grep by hand if you ever want to.

## What's in here

```
CookingSkills/
├── README.md              # this file
├── preferences.md         # your standing cooking profile (protein, method, flavor style)
├── pantry.md              # what staples are on hand right now (stocked / low / out)
├── cookbooks/              # one folder per cookbook, full of transcribed/original recipes
│   ├── simple-italian-kitchen/
│   ├── swedish-kitchen/
│   └── french-kitchen/
├── meal-plans/             # one file per planning cycle, with quick-cook + shopping list
└── skills/
    ├── store-cookbook/     # instructions for archiving recipes into cookbooks/
    └── meal-plan/          # instructions for turning cookbooks/ + pantry.md into a plan
```

Two "skills" (in `skills/`) describe how this project should be used — they're written for an AI assistant (Claude) to follow, but they double as documentation of the intended workflow.

## The three things you'll actually do

### 1. Add recipes to your collection

Whenever you get a new cookbook, want to save recipes from an existing one, or want to log a family recipe (like a parent's handwritten notes), just say so:

> "Add these recipes from [book name]" — paste text or a photo of the page.

This uses the `store-cookbook` skill. It creates (or adds to) a folder under `cookbooks/<book-slug>/`, with one file per recipe, organized however the source organizes itself (course, season, chapter). Quantities and instructions are transcribed exactly as given — nothing is invented, and anything unclear from a photo is marked rather than guessed.

Family notes work exactly the same way — they just become their own "cookbook" folder (e.g. `cookbooks/moms-notebook/`), fully searchable alongside published books.

### 2. Plan the next few days and shop

Before a grocery trip, ask for a plan:

> "Plan meals for the next few days" or "What should I cook this week?"

This uses the `meal-plan` skill. It will:

1. Read `pantry.md` to see what's already stocked.
2. Pull recipes from across all your cookbooks — mixing freely, not sticking to one book — weighted toward `preferences.md` (chicken breast, olive oil, cast iron, simple flavors, jarred sauce only for Italian).
3. Propose a shortlist of meals, usually 3-4 days at a time, choosing recipes that share perishable ingredients so nothing you buy goes bad before it's used.
4. Write everything to `meal-plans/<start>-to-<end>.md`: the day-by-day menu, a shopping list grouped by store section (only what you don't already have), and a **Quick cook** block for every meal.

### 3. Cook from your phone

At dinner time, just ask:

> "What's for dinner tonight, and how do I make it?"

You'll get back just that day's **Quick cook** block from the current plan file — ingredients with quantities and short numbered steps, nothing else. Short enough to copy into your phone's notes app and follow at the stove, no need to pull up the full recipe file.

### Afterward: keep pantry.md honest

Once you're back from the store or done cooking, say so:

> "I'm back from shopping" or "Just finished dinner, mark it done."

`pantry.md` gets updated (restocked items marked `stocked`, used-up staples marked `low`/`out`), and the meal plan file gets that night's meal checked off.

## A few things worth knowing

- Nothing here is ever invented. If a recipe isn't archived yet, you'll be told to digitize it first rather than getting a fabricated one.
- `preferences.md` is meant to evolve — update it any time your staples or tastes change, and future plans will follow.
- The `Seasonal / right now` section of `pantry.md` is where a garden glut (like tomatoes) gets flagged so meal plans lean into using it up.
