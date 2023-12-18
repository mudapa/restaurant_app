import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/favorite/favorite_cubit.dart';
import '../../models/restaurant_model.dart';
import '../../shared/api_path.dart';
import '../../shared/helper.dart';
import '../../shared/navigation.dart';
import '../../shared/style.dart';

class RestaurantTile extends StatefulWidget {
  final Restaurant restaurant;
  const RestaurantTile({
    super.key,
    required this.restaurant,
  });

  @override
  State<RestaurantTile> createState() => _RestaurantTileState();
}

class _RestaurantTileState extends State<RestaurantTile> {
  bool isFavorite = false;

  @override
  void initState() {
    context.read<FavoriteCubit>().loadFavoriteRestaurants();
    super.initState();
  }

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
            color: greyColor.withOpacity(0.5),
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          Navigation.intentWithData('/detail_restaurant', widget.restaurant);
        },
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: widget.restaurant.pictureId != null
              ? Image.network(
                  '${ApiPath.imageSmallUrl}${widget.restaurant.pictureId!}',
                  width: 100,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/empty_image.jpg',
                  width: 100,
                  fit: BoxFit.cover,
                ),
        ),
        title: Text(
          widget.restaurant.name!,
          style: blackTextStyle.copyWith(
            fontWeight: semiBold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: redColor,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  widget.restaurant.city!,
                  style: greyTextStyle.copyWith(
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: orangeColor,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  widget.restaurant.rating!.toString(),
                  style: blackTextStyle.copyWith(
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
        trailing: BlocConsumer<FavoriteCubit, FavoriteState>(
          listener: (context, state) {
            if (state is FavoriteSuccess) {
              setState(() {
                isFavorite = state.favoriteRestaurants
                    .any((element) => element.id == widget.restaurant.id);
              });
            }

            if (state is FavoriteFailed) {
              toast(
                state.error,
                redColor,
              );
            }
          },
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                color: redColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: redColor,
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
                                .toggleFavorite(widget.restaurant);
                            Navigator.pop(context);
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
