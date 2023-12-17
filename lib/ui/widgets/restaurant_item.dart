import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/favorite/favorite_cubit.dart';
import '../../models/restaurant_model.dart';
import '../../shared/api_path.dart';
import '../../shared/style.dart';
import '../pages/main/detail_page.dart';

class RestaurantItem extends StatefulWidget {
  final Restaurant restaurant;
  const RestaurantItem({
    super.key,
    required this.restaurant,
  });

  @override
  State<RestaurantItem> createState() => _RestaurantItemState();
}

class _RestaurantItemState extends State<RestaurantItem> {
  bool isFavorite = false;

  @override
  void initState() {
    context.read<FavoriteCubit>().loadFavoriteRestaurants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              restaurant: widget.restaurant,
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 24,
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
              tag: widget.restaurant.pictureId!,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Stack(
                  children: [
                    Image.network(
                      '${ApiPath.imageMediumUrl}${widget.restaurant.pictureId!}',
                      width: MediaQuery.of(context).size.width / 2 - 24,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width / 2 - 24,
                      decoration: BoxDecoration(
                        color: blackColor.withOpacity(0.4),
                      ),
                    ),
                    BlocConsumer<FavoriteCubit, FavoriteState>(
                      listener: (context, state) {
                        if (state is FavoriteSuccess) {
                          setState(() {
                            isFavorite = state.favoriteRestaurants.any(
                                (element) =>
                                    element.id == widget.restaurant.id);
                          });
                        }
                      },
                      builder: (context, state) {
                        return Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            decoration: BoxDecoration(
                              color: whiteColor.withOpacity(0.5),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                              ),
                            ),
                            child: IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite ? redColor : whiteColor,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      isFavorite
                                          ? 'Remove from favorite?'
                                          : 'Add to favorite?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context
                                              .read<FavoriteCubit>()
                                              .toggleFavorite(
                                                  widget.restaurant);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
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
                    widget.restaurant.name!,
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
                            widget.restaurant.city!,
                            style: blackTextStyle.copyWith(
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const Spacer(),
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
                            widget.restaurant.rating.toString(),
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
                    widget.restaurant.description!,
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
