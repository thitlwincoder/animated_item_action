import 'package:animated_item_menu/animated_item_menu.dart';
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
    return AnimatedItemMenu(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      actions: [
        ActionBtn.right(
          child: Icon(CupertinoIcons.add, size: 13),
          onPressed: () => onQtyChange(qty + 1),
        ),
        ActionBtn.right(
          child: Icon(CupertinoIcons.minus, size: 13),
          onPressed: () => onQtyChange(qty - 1),
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
}
