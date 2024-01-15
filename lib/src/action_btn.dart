import 'package:animated_item_menu/animated_item_menu.dart';
import 'package:flutter/material.dart';

class ActionBtn extends StatelessWidget {
  const ActionBtn.left({
    required this.child,
    this.color,
    this.onPressed,
    this.style,
    super.key,
  }) : position = ActionPosition.left;

  const ActionBtn.right({
    required this.child,
    this.color,
    this.onPressed,
    this.style,
    super.key,
  }) : position = ActionPosition.right;

  final Color? color;
  final Widget child;
  final VoidCallback? onPressed;
  final ActionPosition position;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    final disabledColor = Theme.of(context).disabledColor;

    final isDisabled = onPressed == null;

    return OutlinedButton(
      onPressed: onPressed,
      style: style ?? defaultStyle(isDisabled, disabledColor),
      child: child,
    );
  }

  ButtonStyle defaultStyle(bool isDisabled, Color disabledColor) {
    return OutlinedButton.styleFrom(
      shape: CircleBorder(),
      padding: EdgeInsets.zero,
      minimumSize: Size(25, 25),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: getBorderSide(isDisabled, disabledColor),
    );
  }

  BorderSide? getBorderSide(bool isDisabled, Color disabledColor) {
    if (isDisabled) return BorderSide(color: disabledColor);

    if (color == null) return null;

    return BorderSide(color: color!);
  }
}
