import 'package:animated_button/animated_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../cubit/restaurant/restaurant_cubit.dart';
import '../../../models/restaurant_model.dart';
import '../../../shared/style.dart';
import '../../widgets/carousel_image.dart';
import '../../widgets/restaurant_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<RestaurantCubit>().getListRestaurants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<RestaurantCubit>().getListRestaurants();
        },
        child: BlocBuilder<RestaurantCubit, RestaurantState>(
          builder: (context, state) {
            if (state is RestaurantFailed) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset(
                      'assets/lottie_no_internet.json',
                      fit: BoxFit.cover,
                      repeat: true,
                    ),
                  ),
                  AnimatedButton(
                    onPressed: () {
                      context.read<RestaurantCubit>().getListRestaurants();
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
              );
            }

            if (state is RestaurantLoading) {
              return Center(
                child: Lottie.asset(
                  'assets/lottie_find.json',
                  fit: BoxFit.cover,
                  repeat: true,
                ),
              );
            }

            if (state is RestaurantSuccess) {
              return ListView(
                padding: const EdgeInsets.only(
                  bottom: 16,
                ),
                children: [
                  _buildHeader(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Favorite Restaurant',
                          style: blackTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: semiBold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.favorite,
                          color: redColor,
                        ),
                      ],
                    ),
                  ),
                  _buildCarouselImage(state.restaurants.restaurants!),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Explore Restaurant',
                          style: blackTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: semiBold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.search_rounded,
                          size: 32,
                        ),
                      ],
                    ),
                  ),
                  _buildContent(state.restaurants.restaurants!),
                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Restaurant App',
                style: blackTextStyle.copyWith(
                  fontSize: 32,
                  fontWeight: semiBold,
                  shadows: [
                    Shadow(
                      color: greyColor.withOpacity(0.5),
                      offset: const Offset(3, 3),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.restaurant_menu_rounded,
                color: orangeColor,
                size: 32,
              )
            ],
          ),
          Text(
            'Find your favorite restaurant',
            style: greyTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselImage(
    List<Restaurant> restaurants,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
            ),
            items: restaurants.map((restaurant) {
              return CarouselImage(restaurant: restaurant);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    List<Restaurant> restaurants,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        top: 18,
        bottom: 32,
      ),
      child: Center(
        child: Wrap(
          spacing: 20,
          runSpacing: 24,
          children: restaurants.map((restaurant) {
            return RestaurantItem(
              restaurant: restaurant,
            );
          }).toList(),
        ),
      ),
    );
  }
}
