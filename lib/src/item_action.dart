import 'package:animated_item_menu/animated_item_action.dart';
import 'package:flutter/material.dart';

class ItemAction extends StatelessWidget {
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

  final Radius radius;
  final bool isSelected;
  final Duration duration;
  final Color borderColor;
  final Color backgroundColor;

  final Curve switchInCurve;
  final Curve switchOutCurve;

  final List<Widget> actions;
  final ActionPosition position;
  final AnimatedSwitcherTransitionBuilder transitionBuilder;

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
