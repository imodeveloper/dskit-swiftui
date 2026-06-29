# DSKitExplorer/Screens/FoodCategoriesScreen1.swift

- source_path: `DSKitExplorer/Screens/FoodCategoriesScreen1.swift`
- memory_limit: `300 lines`
- ordering: `newest entries first`

## Changes

### 2026-06-29 16:48:51 EEST (`pending`)

- task_or_issue: `food-categories-image-height`

#### Request
Fix the Food Categories screen preview where category images rendered as thin strips.

#### Change Summary
Set a fixed DSKit height on each category `DSImageView` so category cards reserve enough vertical space for the food image.

#### Rationale
The generated screen catalog uses snapshot previews from this screen. Without an explicit image height, the cards can render the image as a narrow strip and make the screen preview misleading.

#### Invariants
Keep the screen deterministic for snapshot tests. If card layout changes, refresh `DSKitExplorerTests/__Snapshots__/DSKitExplorerTests/FoodCategoriesScreen1.snapshot.png`.

#### Tests Or Evidence
Recorded the focused FoodCategories snapshot once, then reran `DSKitExplorerTests/DSKitExplorerTests/testFoodCategoriesScreen1` without record mode through XcodeBuildMCP; the focused snapshot test passed.

#### Related Files
`DSKitExplorerTests/__Snapshots__/DSKitExplorerTests/FoodCategoriesScreen1.snapshot.png`, `Content/Screens.md`, `Scripts/generate_view_docs.py`.

#### Follow-up Risks
If `DSImageView` default sizing changes, re-check this screen and snapshot because the explicit height may need tuning.
