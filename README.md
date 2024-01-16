# animated_item_action

[![pub package](https://img.shields.io/pub/v/animated_item_action.svg?logo=dart&logoColor=00b9fc)](https://pub.dev/packages/animated_item_action)
[![Last Commits](https://img.shields.io/github/last-commit/thitlwincoder/animated_item_action?logo=git&logoColor=white)](https://github.com/thitlwincoder/animated_item_action/commits/master)
[![GitHub repo size](https://img.shields.io/github/repo-size/thitlwincoder/animated_item_action)](https://github.com/thitlwincoder/animated_item_action)
[![License](https://img.shields.io/github/license/thitlwincoder/animated_item_action?logo=open-source-initiative&logoColor=green)](https://github.com/thitlwincoder/animated_item_action/blob/master/LICENSE)
<br>
[![Uploaded By](https://img.shields.io/badge/uploaded%20by-thitlwincoder-blue)](https://github.com/thitlwincoder)


Flutter Package to show animated actions in item.

## Preview

![preview][preview]

## Installation 💻

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  animated_item_action: <latest_version>
```
In your library add the following import:

```dart
import 'package:animated_item_action/animated_item_action.dart';
```

## Getting started

Example:


```dart
AnimatedItemAction(
  startActions: [
    IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.pen)),
    IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.trash)),
  ],
  endActions: [
    IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.add)),
    IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.minus)),
  ],
  builder: (context, isSelected) {
    return ListTile(
      title: Text('Item'),
    );
  },
),
```

## Sponsoring

I'm working on my packages on my free-time, but I don't have as much time as I would. If this package or any other package I created is helping you, please consider to sponsor me so that I can take time to read the issues, fix bugs, merge pull requests and add features to these packages.

## Contributions

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue][issue].  
If you fixed a bug or implemented a feature, please send a [pull request][pr].

<!-- Links -->

[preview]: https://raw.githubusercontent.com/thitlwincoder/animated_item_action/assets/preview.gif
[issue]: https://github.com/thitlwincoder/animated_item_action/issues
[pr]: https://github.com/thitlwincoder/animated_item_action/pulls