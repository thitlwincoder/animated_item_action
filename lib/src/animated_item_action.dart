import 'package:animated_item_action/animated_item_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnimatedItemAction extends StatefulWidget {
  const AnimatedItemAction({
    required this.builder,
    super.key,
    this.margin,
    this.padding,
    this.onExit,
    this.onHover,
    this.duration,
    this.isSelected,
    this.endActions,
    this.borderColor,
    this.constraints,
    this.startActions,
    this.backgroundColor,
    this.isSelectOnHover = false,
    this.onSelectedChanged,
    this.switchInCurve = Curves.easeIn,
    this.switchOutCurve = Curves.easeOut,
    this.radius = const Radius.circular(5),
    this.actionTransitionBuilder = ItemAction.defaultTransitionBuilder,
  });

  final Radius radius;

  final bool? isSelected;

  final Duration? duration;

  final bool isSelectOnHover;

  final Color? borderColor;
  final Color? backgroundColor;

  final Curve switchInCurve;
  final Curve switchOutCurve;

  final List<Widget>? endActions;
  final List<Widget>? startActions;

  final WidgetItemBuilder builder;

  final BoxConstraints? constraints;

  final EdgeInsetsGeometry? margin;

  final EdgeInsetsGeometry? padding;

  final ValueChanged<bool>? onSelectedChanged;

  final PointerExitEventListener? onExit;
  final PointerHoverEventListener? onHover;

  final AnimatedSwitcherTransitionBuilder actionTransitionBuilder;

  @override
  State<AnimatedItemAction> createState() => _AnimatedItemActionState();
}

class _AnimatedItemActionState extends State<AnimatedItemAction> {
  late bool isSelected;
  late Duration duration;
  late Radius radius;

  Radius radiusZero = Radius.zero;

  @override
  void initState() {
    super.initState();
    radius = widget.radius;
    isSelected = widget.isSelected ?? false;
    duration = widget.duration ?? Duration(milliseconds: 800);
  }

  @override
  void didUpdateWidget(covariant AnimatedItemAction oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSelected != widget.isSelected) {
      isSelected = widget.isSelected ?? false;
    }

    if (oldWidget.duration != widget.duration) {
      duration = widget.duration ?? Duration(milliseconds: 800);
    }

    if (oldWidget.radius != widget.radius) radius = widget.radius;
  }

  @override
  void dispose() {
    isSelected = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final startActions = widget.startActions;
    final endActions = widget.endActions;

    final haveStart = startActions != null && startActions.isNotEmpty;
    final haveEnd = endActions != null && endActions.isNotEmpty;

    final color = Theme.of(context).highlightColor;
    final cardColor = Theme.of(context).cardColor;

    final borderColor = widget.borderColor ?? color;
    final backgroundColor = widget.backgroundColor ?? cardColor;

    final border = Border.all(color: borderColor);

    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: IntrinsicHeight(
        child: Row(
          children: [
            if (haveStart)
              actionBtn(
                actions: startActions,
                key: ValueKey('start'),
                borderColor: borderColor,
                backgroundColor: backgroundColor,
              ),
            Expanded(
              child: MouseRegion(
                onHover: (event) {
                  if (widget.isSelectOnHover) {
                    isSelected = true;
                    setState(() {});
                  }

                  widget.onHover?.call(event);
                },
                onExit: (event) {
                  if (widget.isSelectOnHover) {
                    isSelected = false;
                    setState(() {});
                  }

                  widget.onExit?.call(event);
                },
                child: GestureDetector(
                  onTap: () {
                    isSelected = !isSelected;
                    setState(() {});

                    widget.onSelectedChanged?.call(isSelected);
                  },
                  child: AnimatedContainer(
                    duration: duration,
                    width: double.infinity,
                    padding: widget.padding,
                    constraints: widget.constraints,
                    decoration: BoxDecoration(
                      border: border,
                      color: backgroundColor,
                      borderRadius: _getBorderRadius(haveStart, haveEnd),
                    ),
                    child: widget.builder(context, isSelected),
                  ),
                ),
              ),
            ),
            if (haveEnd)
              actionBtn(
                actions: endActions,
                key: ValueKey('right'),
                borderColor: borderColor,
                backgroundColor: backgroundColor,
              ),
          ],
        ),
      ),
    );
  }

  Widget actionBtn({
    required Key key,
    required Color borderColor,
    required List<Widget> actions,
    required Color backgroundColor,
  }) {
    return ItemAction(
      key: key,
      radius: radius,
      actions: actions,
      duration: duration,
      isSelected: isSelected,
      borderColor: borderColor,
      position: ActionPosition.left,
      backgroundColor: backgroundColor,
      switchInCurve: widget.switchInCurve,
      switchOutCurve: widget.switchOutCurve,
      transitionBuilder: widget.actionTransitionBuilder,
    );
  }

  BorderRadius _getBorderRadius(bool haveStart, bool haveEnd) {
    if (haveStart && haveEnd) {
      return BorderRadius.all(isSelected ? radiusZero : radius);
    }

    if (haveStart) {
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
