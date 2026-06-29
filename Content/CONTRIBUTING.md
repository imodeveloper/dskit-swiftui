DSKit is developed completely in the open, and contributions are welcome.

Before changing DSKit, spend a few minutes with the repo-native docs:

- [README.md](../README.md) for setup and documentation entry points.
- [Views.md](Views.md) for generated component references.
- [Screens.md](Screens.md) for generated DSKitExplorer screen references.
- [docs/WORKFLOWS.md](../docs/WORKFLOWS.md) for build, test, snapshot, and documentation generation commands.

Generated docs are not edited by hand. Update Swift source comments, `Testable_*` examples, snapshots, or the generator, then run:

```sh
cd Scripts
./documentation_generator.sh
```

This project does not come with GitHub Issues-based support. Users are encouraged to become active participants by fixing bugs they encounter or improving documentation wherever it is lacking.

If you wish to make a change, open a [Pull Request](https://github.com/imodeveloper/dskit-swiftui/pulls), even if it just contains a draft of the changes you are planning or a test that reproduces an issue.
