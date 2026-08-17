# Pantry & Staples

Last updated: 2026-08-16

Tracks what's reliably on hand so shopping lists only include what's actually needed for planned meals. Update this whenever you shop, use up an item, or notice something running low — the `meal-plan` skill reads this file to trim shopping lists.

Status values: `stocked`, `low`, `out`.

## Pantry (shelf-stable)

- olive oil — stocked
- salt — stocked
- black pepper — stocked
- rice — stocked
- pasta — stocked
- canned tomatoes — stocked
- flour — stocked
- sugar — stocked

## Spices & condiments

- garlic — stocked
- onions — stocked
- soy sauce — stocked
- vinegar — stocked

## Fridge / freezer

- butter — stocked
- eggs — stocked

## Seasonal / right now

- Garden tomatoes — abundant (2026-08-17). Favor recipes that use fresh tomatoes while this lasts, e.g. tomates-provencale.md (french-kitchen).

## Notes

Chicken breast is intentionally not listed as a staple here — it's bought fresh each shopping cycle rather than kept stocked, so it should always appear on generated shopping lists.

Add or remove items as your actual staples change — this list is a starting point, not fixed. When the `meal-plan` skill generates a shopping list, it treats `stocked` items as already covered, `low` items as worth double-checking, and `out` items as needed if a planned recipe calls for them.
