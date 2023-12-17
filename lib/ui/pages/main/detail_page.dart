import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';

import '../../../cubit/detail/detail_restaurant_cubit.dart';
import '../../../cubit/favorite/favorite_cubit.dart';
import '../../../models/restaurant_model.dart';
import '../../../shared/api_path.dart';
import '../../../shared/helper.dart';
import '../../../shared/style.dart';
import '../../widgets/card_customer_review.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_form_review.dart';
import '../../widgets/item.dart';

class DetailPage extends StatefulWidget {
  final Restaurant restaurant;
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
  void initState() {
    context.read<DetailRestaurantCubit>().getDetailRestaurant(
          widget.restaurant.id!,
        );
    _checkFavoriteStatus();
    super.initState();
  }

  Future<void> _checkFavoriteStatus() async {
    final isFavorite = await context
        .read<FavoriteCubit>()
        .loadFavoriteStatus(widget.restaurant);
    setState(() {
      this.isFavorite = isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<DetailRestaurantCubit>().getDetailRestaurant(
                widget.restaurant.id!,
              );
        },
        child: SafeArea(
          child: _buildBody(context),
        ),
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
              Navigator.pop(context);
              context.read<FavoriteCubit>().loadFavoriteRestaurants();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: lightGreyColor.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chevron_left_rounded,
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
              shadows: [
                Shadow(
                  color: greyColor.withOpacity(0.5),
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          BlocConsumer<FavoriteCubit, FavoriteState>(
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: lightGreyColor.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
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
            '${ApiPath.imageLargeUrl}${widget.restaurant.pictureId!}',
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
    return BlocBuilder<DetailRestaurantCubit, DetailRestaurantState>(
      builder: (context, state) {
        if (state is DetailRestaurantFailed) {
          return Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Lottie.asset(
                      'assets/lottie_no_internet.json',
                      fit: BoxFit.cover,
                      repeat: true,
                    ),
                    AnimatedButton(
                      onPressed: () {
                        context
                            .read<DetailRestaurantCubit>()
                            .getDetailRestaurant(
                              widget.restaurant.id!,
                            );
                      },
                      color: blueColor,
                      width: 200,
                      height: 50,
                      child: Text(
                        'Refresh',
                        style: whiteTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (state is DetailRestaurantLoading) {
          return Center(
            child: Lottie.asset(
              'assets/lottie_find.json',
              fit: BoxFit.cover,
              repeat: true,
            ),
          );
        }

        if (state is DetailRestaurantSuccess) {
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
                        state.detailRestaurant.restaurant!.name!,
                        style: blackTextStyle.copyWith(
                          fontSize: 24,
                          fontWeight: semiBold,
                        ),
                        overflow: TextOverflow.ellipsis,
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.detailRestaurant.restaurant!.city!,
                                    style: blackTextStyle.copyWith(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    state.detailRestaurant.restaurant!.address!,
                                    style: blackTextStyle,
                                  ),
                                ],
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
                      ReadMoreText(
                        state.detailRestaurant.restaurant!.description!,
                        trimLines: 4,
                        colorClickableText: blueColor,
                        trimMode: TrimMode.Length,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: ' Show less',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                        ),
                        moreStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: semiBold,
                          color: blueColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 8),
                      Text(
                        'Categories',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Item(
                        itemCount:
                            state.detailRestaurant.restaurant!.categories!,
                      ),
                      Text(
                        'Foods',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Item(
                        itemCount:
                            state.detailRestaurant.restaurant!.menus!.foods!,
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
                        itemCount:
                            state.detailRestaurant.restaurant!.menus!.drinks!,
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 8),
                      Text(
                        'Reviews',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: state
                              .detailRestaurant.restaurant!.customerReviews!
                              .map((review) {
                            return CardCustomerReview(
                              review: review,
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomButton(
                            onPressed: () {
                              toast(
                                'Feature Coming Soon!',
                                orangeColor,
                              );
                            },
                            text: 'Book Now',
                            color: blueColor,
                          ),
                          CustomButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => CustomFormReview(
                                  detailRestaurant:
                                      state.detailRestaurant.restaurant!,
                                ),
                              );
                            },
                            text: 'Review',
                            color: orangeColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
