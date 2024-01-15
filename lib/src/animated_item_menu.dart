import 'package:animated_item_menu/animated_item_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedItemMenu extends StatefulWidget {
  const AnimatedItemMenu({
    required this.builder,
    super.key,
    this.actions,
    this.isSelected,
    this.margin,
    this.padding,
    this.borderColor,
    this.constraints,
  });

  final bool? isSelected;

  final Color? borderColor;

  final List<ActionBtn>? actions;

  final BoxConstraints? constraints;

  final EdgeInsetsGeometry? margin;

  final EdgeInsetsGeometry? padding;

  final WidgetItemBuilder builder;

  @override
  State<AnimatedItemMenu> createState() => _AnimatedItemMenuState();
}

class _AnimatedItemMenuState extends State<AnimatedItemMenu> {
  late bool isSelected;
  late List<ActionBtn>? actions;

  @override
  void initState() {
    super.initState();
    actions = widget.actions;
    isSelected = widget.isSelected ?? false;
  }

  @override
  void didUpdateWidget(covariant AnimatedItemMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSelected != widget.isSelected) {
      isSelected = widget.isSelected ?? false;
    }
    if (oldWidget.actions != widget.actions) {
      actions = widget.actions;
    }
  }

  @override
  void dispose() {
    isSelected = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).highlightColor;

    final border = Border.all(color: widget.borderColor ?? color);

    final haveLeft = actions?.any((e) => e.position.isLeft) ?? false;
    final haveRight = actions?.any((e) => e.position.isRight) ?? false;

    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: IntrinsicHeight(
        child: Row(
          children: [
            if (haveLeft)
              ItemAction(
                isSelected: isSelected,
                position: ActionPosition.left,
                actions: actions!.where((e) => e.position.isLeft).toList(),
              ),
            Expanded(
              child: CupertinoButton(
                minSize: 0,
                padding: EdgeInsets.zero,
                onPressed: () {
                  isSelected = !isSelected;
                  setState(() {});
                },
                child: AnimatedContainer(
                  width: double.infinity,
                  padding: widget.padding,
                  constraints: widget.constraints,
                  duration: Duration(milliseconds: 800),
                  decoration: BoxDecoration(
                    border: border,
                    borderRadius: _getBorderRadius(haveLeft, haveRight),
                  ),
                  child: widget.builder(context, isSelected),
                ),
              ),
            ),
            if (haveRight)
              ItemAction(
                isSelected: isSelected,
                position: ActionPosition.right,
                actions: actions!.where((e) => e.position.isRight).toList(),
              ),
          ],
        ),
      ),
    );
  }

  BorderRadius _getBorderRadius(bool haveLeft, bool haveRight) {
    final radius = Radius.circular(5);
    const radiusZero = Radius.zero;

    if (haveLeft && haveRight) {
      return BorderRadius.all(isSelected ? radiusZero : radius);
    }

    if (haveLeft) {
      return BorderRadius.horizontal(
        right: radius,
        left: isSelected ? radiusZero : radius,
      );
    }

    return BorderRadius.horizontal(
      left: radius,
      right: isSelected ? radiusZero : radius,
    );
  }
}
