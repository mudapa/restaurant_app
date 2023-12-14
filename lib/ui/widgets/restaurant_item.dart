import 'package:flutter/material.dart';

import '../../models/restaurant_model.dart';
import '../../shared/api_path.dart';
import '../../shared/style.dart';
import '../pages/main/detail_page.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantItem({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 32,
        height: 280,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: whiteColor,
          ),
          boxShadow: [
            BoxShadow(
              color: greyColor.withOpacity(0.5),
              offset: const Offset(10, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Hero(
              tag: restaurant.pictureId!,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.network(
                  '${ApiPath.imageMediumUrl}${restaurant.pictureId!}',
                  width: MediaQuery.of(context).size.width / 2 - 24,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name!,
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: redColor,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            restaurant.city!,
                            style: blackTextStyle.copyWith(
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: orangeColor,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            restaurant.rating.toString(),
                            style: blackTextStyle.copyWith(
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    restaurant.description!,
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
