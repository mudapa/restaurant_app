import 'package:flutter/material.dart';

import '../../shared/style.dart';

class Item extends StatelessWidget {
  final List<dynamic> itemCount;
  const Item({
    Key? key,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: lightGreyColor,
                    boxShadow: [
                      BoxShadow(
                        color: greyColor.withOpacity(0.5),
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    itemCount[index].name!,
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
