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

## Run the CookingSkills app in ChatGPT

The user-facing workflow runs inside ChatGPT with the Google Drive app. Cookbook data stays in Google Drive; the app
does not require a local folder or a Drive desktop sync client.

1. Open the CookingSkills app in ChatGPT and connect **Google Drive** using the user's own Google account.
2. The app uses two Drive folders:
   - **Reference library:** [CookingSkills on Google Drive](https://drive.google.com/drive/folders/1WcyfaUxNbs298Vko669qz_JqajkpXDsa?usp=sharing). This is shared with users as **Viewer** and contains shared cookbooks, skills, and templates.
   - **Personal cookbook library:** a folder owned by the user. It stores that user's recipe documents and meal plans, including any copyrighted cookbooks they have permission to use.
3. Set the Google Drive app permission in ChatGPT to **Any changes**, so the user approves every creation or edit.
4. Ask the app to add recipes, plan meals, or show the current meal. It must read shared material from the reference
   library and write only to the personal cookbook library.

Use these rules in the app or Project instructions:

> Treat the reference library as read-only: never create, edit, move, share, or delete files there. Before creating or
> changing a recipe document, confirm the target is in the user-owned personal cookbook library and ask for approval. Do
> not share, publish, or reuse a user's cookbook content for another user.

`SKILL.md` is reference material in this model; put the operational rules in the app or Project instructions so they
apply to every conversation.

## Deploy the app and bootstrap Google Drive

Deployment copies the shared repository material to the reference Drive folder and creates only the empty starter
structure in the configured user Drive folder. It does not download or synchronize Drive content to the developer's
disk, and it never deletes Drive files.

1. In Google Cloud, enable the **Google Drive API**, configure an OAuth consent screen, and create a **Desktop app**
   OAuth client.
2. Copy `setenv.example.sh` to `setenv.sh`. Set the two folder URLs and the Desktop OAuth client ID and secret. Keep
   `setenv.sh` private; it is ignored by Git.
3. Install the deployment dependencies:

   ```bash
   make install-deploy-deps
   ```

4. Review the planned changes without a Google login or write:

   ```bash
   make dry-run
   ```

5. Deploy:

   ```bash
   make deploy
   ```

   The command opens a Google browser login. Its credentials remain in memory for that deployment and are not written to
   a local token file.

`make deploy` updates the reference folder's `cookbooks/` and `skills/` trees. In the user folder, it creates
`cookbooks/`, `meal-plans/`, and `My CookingSkills Library.md` if they are missing; it leaves existing user recipes
alone. Each app user should have their own `USER_DRIVE_DIR` rather than sharing one writable folder.
