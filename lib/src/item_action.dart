import 'package:animated_item_menu/animated_item_menu.dart';
import 'package:flutter/material.dart';

class ItemAction extends StatelessWidget {
  const ItemAction({
    required this.isSelected,
    required this.actions,
    required this.position,
    super.key,
  });

  final bool isSelected;
  final List<ActionBtn> actions;
  final ActionPosition position;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).highlightColor;

    final side = BorderSide(color: color);
    const sideNone = BorderSide.none;

    final radius = Radius.circular(5);
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
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      duration: Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            axis: Axis.horizontal,
            child: child,
          ),
        );
      },
      child: !isSelected
          ? SizedBox()
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
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
