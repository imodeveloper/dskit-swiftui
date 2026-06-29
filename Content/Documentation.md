# Documentation Workflow

Use this page when changing generated DSKit component docs, Explorer screen docs, examples, or snapshots.

## Source Of Truth

Generated documentation is refreshed from:

- Swift view source comments in [DSKit/Sources/DSKit/Views](../DSKit/Sources/DSKit/Views).
- `Testable_*` examples in DSKit view source files.
- Component snapshots in [DSKitTests/__Snapshots__/DSKitTests](../DSKitTests/__Snapshots__/DSKitTests).
- Explorer screen source in [DSKitExplorer/Screens](../DSKitExplorer/Screens).
- Explorer screen snapshots in [DSKitExplorerTests/__Snapshots__/DSKitExplorerTests](../DSKitExplorerTests/__Snapshots__/DSKitExplorerTests).
- Direct Explorer usage references scanned from `DSKitExplorer/Screens/*.swift`.

## Generated Outputs

Do not hand-edit these generated docs or assets:

- [Views.md](Views.md)
- [Views/](Views/)
- [Views/UsageIndex.md](Views/UsageIndex.md)
- [Screens.md](Screens.md)
- [Screens/](Screens/)
- [Screens/Frames/](Screens/Frames/)
- [Screens/Groups/](Screens/Groups/)

To change generated content, update the source comments, `Testable_*` examples, snapshots, Explorer screen source, or the generator.

## Refresh Command

Run the generator from the scripts folder:

```sh
cd Scripts
./documentation_generator.sh
```

The generator is [Scripts/documentation_generator.sh](../Scripts/documentation_generator.sh), which delegates to [Scripts/generate_view_docs.py](../Scripts/generate_view_docs.py).
The Python generator requires Pillow so it can build flattened screen frame PNGs.

## Validation

After a documentation refresh, check that:

- Every DSKit view has a matching component page and preview snapshot.
- Every generated screen page has at least one matching screen snapshot.
- Every generated screen preview frame is rebuilt from an existing screen snapshot.
- Every generated screen catalog strip is rebuilt from generated screen preview frames.
- Relative links resolve locally.
- No generated Markdown contains local absolute paths.

When component preview snapshots change, also run the focused component snapshot/documentation coverage test before committing.
