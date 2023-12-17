import 'package:flutter/material.dart';

import '../../models/restaurant_model.dart';
import '../../shared/api_path.dart';
import '../../shared/style.dart';
import '../pages/main/detail_page.dart';

class FavoriteRestaurantTile extends StatelessWidget {
  final Restaurant restaurant;

  const FavoriteRestaurantTile({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                restaurant: restaurant,
              ),
            ),
          );
        },
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            '${ApiPath.imageSmallUrl}${restaurant.pictureId!}',
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(restaurant.name!),
        subtitle: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: redColor,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(restaurant.city!),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: orangeColor,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(restaurant.rating!.toString()),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: redColor,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
