import 'package:flutter/material.dart';

/// [WidgetItemBuilder] is a typedef for [AnimatedItemAction.builder]
typedef WidgetItemBuilder = Widget Function(
  BuildContext context,
  bool isSelected,
);
