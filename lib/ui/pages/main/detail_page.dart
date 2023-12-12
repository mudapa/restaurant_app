import 'package:flutter/material.dart';

import '../../../models/restaurant_model.dart';
import '../../../shared/style.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/item.dart';

class DetailPage extends StatefulWidget {
  final RestaurantModel restaurant;
  const DetailPage({
    super.key,
    required this.restaurant,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            _buildImage(context),
            _buildAppBar(context),
          ],
        ),
        _buildContent(context),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: transparentColor,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context, isFavorite);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: lightGreyColor.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chevron_left,
                color: whiteColor,
              ),
            ),
          ),
          const Spacer(),
          Text(
            widget.restaurant.name!,
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: lightGreyColor.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? redColor : whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Hero(
      tag: widget.restaurant.pictureId!,
      child: Stack(
        children: [
          Image.network(
            widget.restaurant.pictureId!,
            width: MediaQuery.of(context).size.width,
            height: 270,
            fit: BoxFit.cover,
          ),
          Container(
            height: 270,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: blackColor.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.restaurant.name!,
                  style: blackTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: redColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.restaurant.city!,
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                          ),
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
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                Text(
                  'Description',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.restaurant.description!,
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                Text(
                  'Foods',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 8),
                Item(
                  itemCount: widget.restaurant.menus!.foods!,
                ),
                Text(
                  'Drinks',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 8),
                Item(
                  itemCount: widget.restaurant.menus!.drinks!,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Book Now',
                  color: blueColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
