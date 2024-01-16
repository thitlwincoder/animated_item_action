import 'package:animated_item_action/animated_item_action.dart';
import 'package:flutter/material.dart';

/// Item Action Widget
class ItemAction extends StatelessWidget {
  /// Creates a [ItemAction]
  const ItemAction({
    required this.isSelected,
    required this.actions,
    required this.position,
    required this.duration,
    required this.borderColor,
    required this.radius,
    required this.backgroundColor,
    required this.transitionBuilder,
    required this.switchInCurve,
    required this.switchOutCurve,
    super.key,
  });

  /// BorderRadius of the item actions.
  ///
  /// Defaults is [Radius.circular(5)].
  final Radius radius;

  /// Selected value of the item to animated [ItemAction].
  final bool isSelected;

  /// Duration of the animation.
  ///
  /// Default is Duration(milliseconds: 800).
  final Duration duration;

  /// The border color of the item actions.
  final Color borderColor;

  /// The background color of the item actions.
  final Color backgroundColor;

  /// The [switchInCurve] of the items actions animation.
  final Curve switchInCurve;

  /// The [switchOutCurve] of the items actions animation.
  final Curve switchOutCurve;

  /// The widgets list of the item actions.
  final List<Widget> actions;

  /// The position of the item actions.
  final ActionPosition position;

  /// The [transitionBuilder] of the items actions animation.
  final AnimatedSwitcherTransitionBuilder transitionBuilder;

  /// Default transition builder
  static Widget defaultTransitionBuilder(
    Widget child,
    Animation<double> animation,
  ) {
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.horizontal,
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    final side = BorderSide(color: borderColor);
    const sideNone = BorderSide.none;

    const radiusNone = Radius.zero;

    BorderSide getSide(ActionPosition v) {
      if (v == position) return side;
      return sideNone;
    }

    Radius getRadius(ActionPosition v) {
      if (v == position) return radius;
      return radiusNone;
    }

    return AnimatedSwitcher(
      duration: duration,
      reverseDuration: duration,
      switchInCurve: switchInCurve,
      switchOutCurve: switchOutCurve,
      transitionBuilder: transitionBuilder,
      child: !isSelected
          ? SizedBox()
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border(
                  top: side,
                  bottom: side,
                  left: getSide(ActionPosition.left),
                  right: getSide(ActionPosition.right),
                ),
                borderRadius: BorderRadius.horizontal(
                  left: getRadius(ActionPosition.left),
                  right: getRadius(ActionPosition.right),
                ),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: actions,
              ),
            ),
    );
  }
}
