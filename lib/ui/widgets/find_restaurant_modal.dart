import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../cubit/find/find_restaurant_cubit.dart';
import '../../shared/style.dart';
import 'restaurant_tile.dart';

class FindRestaurantModal extends StatefulWidget {
  const FindRestaurantModal({super.key});

  @override
  State<FindRestaurantModal> createState() => _FindRestaurantModalState();
}

class _FindRestaurantModalState extends State<FindRestaurantModal> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<FindRestaurantCubit>().findRestaurant('');
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) {
                    context.read<FindRestaurantCubit>().findRestaurant(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search restaurant',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<FindRestaurantCubit, FindRestaurantState>(
                  builder: (context, state) {
                    if (state is FindRestaurantFailed) {
                      return Center(
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
                                    .read<FindRestaurantCubit>()
                                    .findRestaurant('');
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
                      );
                    }

                    if (state is FindRestaurantLoading) {
                      return Center(
                        child: Lottie.asset(
                          'assets/lottie_find.json',
                          fit: BoxFit.cover,
                          repeat: true,
                        ),
                      );
                    }

                    if (state is FindRestaurantSuccess) {
                      if (state.findRestaurants.restaurants!.isNotEmpty) {
                        return ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: state.findRestaurants.restaurants!
                              .map((restaurant) => RestaurantTile(
                                    restaurant: restaurant,
                                  ))
                              .toList(),
                        );
                      }

                      if (state.findRestaurants.restaurants!.isEmpty) {
                        return const Center(
                          child: Text('Restaurant not found'),
                        );
                      }
                    }

                    return const Center(
                      child: Text('Search favorite restaurant'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
