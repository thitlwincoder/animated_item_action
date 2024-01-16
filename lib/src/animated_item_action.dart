import 'package:animated_item_action/animated_item_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Animated Item Action Widget
class AnimatedItemAction extends StatefulWidget {
  /// Creates a [AnimatedItemAction].
  const AnimatedItemAction({
    required this.builder,
    super.key,
    this.margin,
    this.padding,
    this.onExit,
    this.onHover,
    this.endActions,
    this.borderColor,
    this.constraints,
    this.startActions,
    this.backgroundColor,
    this.onSelectedChanged,
    this.initSelected = false,
    this.isSelectOnHover = false,
    this.switchInCurve = Curves.easeIn,
    this.switchOutCurve = Curves.easeOut,
    this.radius = const Radius.circular(5),
    this.duration = const Duration(milliseconds: 800),
    this.actionTransitionBuilder = ItemAction.defaultTransitionBuilder,
  });

  /// BorderRadius of the item actions & child widget
  ///
  /// Defaults is [Radius.circular(5)].
  final Radius radius;

  /// Initial selected state of the item actions.
  ///
  /// Default is false.
  final bool initSelected;

  /// [duration] of the child & items actions animation.
  ///
  /// Default is Duration(milliseconds: 800).
  final Duration duration;

  /// If true, the item will be selected on hover.
  ///
  /// Default is false.
  final bool isSelectOnHover;

  /// The border color of the item actions & child widget.
  final Color? borderColor;

  /// The background color of the item actions & child widget.
  final Color? backgroundColor;

  /// The [switchInCurve] of the child & items actions animation.
  final Curve switchInCurve;

  /// The [switchOutCurve] of the child & items actions animation.
  final Curve switchOutCurve;

  /// The widgets list that show in the end when item is selected.
  final List<Widget>? endActions;

  /// The widgets list that show in the start when item is selected.
  final List<Widget>? startActions;

  /// The builder function that build the child widget.
  final WidgetItemBuilder builder;

  /// The constraints that apply to the child widget.
  final BoxConstraints? constraints;

  /// The margin of the item actions & child widget.
  final EdgeInsetsGeometry? margin;

  /// The padding that apply to the child widget.
  final EdgeInsetsGeometry? padding;

  /// Called when the item selection changed.
  final ValueChanged<bool>? onSelectedChanged;

  /// Called when the pointer is exiting the item.
  final PointerExitEventListener? onExit;

  /// Called when the pointer is hovering over the item.
  final PointerHoverEventListener? onHover;

  /// The [actionTransitionBuilder] of the item actions animation.
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
    duration = widget.duration;
    isSelected = widget.initSelected;
  }

  @override
  void didUpdateWidget(covariant AnimatedItemAction oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.radius != widget.radius) radius = widget.radius;
    if (oldWidget.duration != widget.duration) duration = widget.duration;
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
                position: ActionPosition.start,
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
                position: ActionPosition.end,
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
    required ActionPosition position,
  }) {
    return ItemAction(
      key: key,
      radius: radius,
      actions: actions,
      position: position,
      duration: duration,
      isSelected: isSelected,
      borderColor: borderColor,
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
