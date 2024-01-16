import 'package:animated_item_action/animated_item_action.dart';
import 'package:example/data/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    required this.price,
    required this.qty,
    required this.onQtyChange,
    super.key,
  });

  final int price;
  final int qty;
  final ValueSetter<int> onQtyChange;

  @override
  Widget build(BuildContext context) {
    final duration = Duration(milliseconds: 400);

    return AnimatedItemAction(
      duration: duration,
      borderColor: Colors.grey,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      onSelectedChanged: (value) {
        if (!value) onQtyChange(1);
      },
      startActions: [
        btn(
          icon: CupertinoIcons.pen,
          onPressed: () {},
        ),
        btn(
          color: Colors.red,
          icon: CupertinoIcons.trash,
          onPressed: () {},
        ),
      ],
      endActions: [
        btn(
          icon: CupertinoIcons.add,
          onPressed: () => onQtyChange(qty + 1),
        ),
        btn(
          icon: CupertinoIcons.minus,
          onPressed: qty == 0 ? null : () => onQtyChange(qty - 1),
        ),
      ],
      builder: (context, isSelected) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'iPhone 15 Pro Max',
            style: context.bodyMedium.scale(.9),
          ),
          Text(
            '\$$price',
            style: context.bodyMedium.scale(.7).textColor(Colors.grey),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 15),
              if (isSelected)
                Text(
                  'x $qty',
                  style: context.bodySmall.medium.scale(.9),
                ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  price.format,
                  style: context.bodySmall.medium,
                ),
              ),
              if (isSelected)
                Text(
                  (qty * price).format,
                  style: context.bodySmall.medium.textColor(context.primary),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget btn({
    required IconData icon,
    required VoidCallback? onPressed,
    Color? color,
  }) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        padding: EdgeInsets.zero,
        minimumSize: Size(20, 20),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: CircleBorder(
          side: BorderSide(color: color ?? Color(0xFF000000)),
        ),
      ),
      onPressed: onPressed,
      child: Icon(icon, size: 13),
    );
  }
}
