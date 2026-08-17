---
name: meal-plan
description: Use this skill whenever the user wants to plan meals for the next several days, decide what to cook before a shopping trip, mix recipes across multiple stored cookbooks, or generate a shopping list from a meal plan. Trigger on requests like "plan meals for the next few days", "what should I cook this week", "help me pick dinners before I shop", "build a shopping list", "what's on the menu", or when the user mentions an upcoming shopping trip and wants to decide meals first. Depends on recipes already archived via the store-cookbook skill and on pantry.md for staples tracking.
---

# Meal Plan

Turn the recipe archive under `cookbooks/` into a short, concrete meal plan (typically 3-4 days, matching Tim's regular shopping cadence) plus a shopping list scoped to exactly what's missing, plus a phone-ready quick-cook reference for each night.

## Why this structure

The point isn't a big master menu — it's picking a handful of meals right before a shopping trip, pulling freely from whichever cookbooks are on hand, and buying only what those meals need beyond what's already in the pantry. Small trips stay small when the list is generated instead of guessed.

Two things matter most day-to-day: (1) the perishables bought for the trip should all get used up within the 3-4 day window, not go bad in the fridge after one meal used half of them; (2) at cook time, Tim wants to pull up just tonight's meal and get short, phone-typeable instructions, not the full recipe file with source notes and narrative. See `preferences.md` for his standing cooking profile (protein/fat/method/flavor philosophy) — weight recipe choices toward it by default.

## Where things live

```
CookingSkills/
├── pantry.md                     # current staples and stock status
├── cookbooks/                    # per-book recipe archives (see store-cookbook skill)
└── meal-plans/
    └── <start-date>-to-<end-date>.md   # one file per planning cycle
```

## Workflow

1. **Read `pantry.md` first** to see what's stocked, low, or out. This determines what the shopping list needs to cover.

2. **Default to a 3-4 day plan** unless the user states otherwise, and ask about any constraints — dietary needs, how many people, or a mood/craving.

3. **Browse `cookbooks/`** across all archived books. Don't default to one book — mix freely across whichever cookbooks have recipes fitting the season/occasion, unless the user asks to stick to one. If a cookbook is referenced but has no archived recipes yet, mention that it needs to be digitized first (via the store-cookbook skill) before it can be planned from.

4. **Propose a shortlist** of specific recipes (one per meal), each naming its source book, and let the user swap any before finalizing. When choosing between otherwise-equal options, prefer meals that share perishable ingredients across the plan window (e.g. a produce item or protein cut used in two meals instead of one-offs) — the goal is that everything bought for the trip gets used up within the 3-4 days, not partially used and forgotten in the fridge.

5. **Write the plan** to `meal-plans/<start-date>-to-<end-date>.md` using `assets/meal-plan-template.md`, linking each meal to its recipe file path.

6. **Write a "Quick cook" block for each meal**: a condensed, phone-ready version of that recipe — just the ingredient list with quantities and short numbered steps, no source notes or narrative. This is what gets pulled up at cook time; keep it short enough to key into a phone.

7. **Build the shopping list**: aggregate ingredients from every chosen recipe, then drop anything marked `stocked` in `pantry.md`. Keep `low` items on the list with a note, and always include `out` items if a recipe needs them. Group the final list by store section (produce, meat/fish, dairy, pantry, other) so it's easy to shop with. Double-check that every perishable on the list is actually called for across at least one meal in the plan — if a recipe only needs half of something perishable (half an onion, a partial bunch of herbs), flag it in Notes rather than let it go unused.

8. **After the trip or after cooking**, offer to update `pantry.md` (mark restocked items `stocked`, mark used-up staples `low`/`out`) and mark meals in the plan file as cooked.

## Notes

- Never invent a recipe that isn't archived under `cookbooks/` — if nothing fits, say so and suggest digitizing a relevant book/recipe first rather than fabricating one.
- Keep the shopping list tight: the goal is a small, targeted trip, not a generic grocery run.
- Default plan length is 3-4 days to match Tim's actual shopping cadence — don't default to a longer window unless asked.
