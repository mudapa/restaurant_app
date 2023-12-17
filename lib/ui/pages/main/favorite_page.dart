import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../cubit/favorite/favorite_cubit.dart';
import '../../../shared/style.dart';
import '../../widgets/favorite_restaurant_tile.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    context.read<FavoriteCubit>().loadFavoriteRestaurants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Restaurants'),
      ),
      body: _buildFavoriteList(),
    );
  }

  Widget _buildFavoriteList() {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteLoading) {
          return Center(
            child: Lottie.asset(
              'assets/lottie_find.json',
              fit: BoxFit.cover,
              repeat: true,
            ),
          );
        }

        if (state is FavoriteSuccess) {
          final favorites = state.favoriteRestaurants;

          if (favorites.isEmpty) {
            return Center(
              child: Text(
                'No favorite restaurants',
                style: blackTextStyle,
              ),
            );
          }

          return ListView(
            children: favorites
                .map(
                  (restaurant) => FavoriteRestaurantTile(
                    restaurant: restaurant,
                  ),
                )
                .toList(),
          );
        }

        return Container();
      },
    );
  }
}
