import 'package:flutter/material.dart';

import '../../models/restaurant_model.dart';
import '../../shared/api_path.dart';
import '../../shared/style.dart';
import '../pages/main/detail_page.dart';

class RestaurantTile extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantTile({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: whiteColor,
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
      ),
    );
  }
}
