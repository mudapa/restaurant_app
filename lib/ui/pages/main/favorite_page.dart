import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../cubit/favorite/favorite_cubit.dart';
import '../../../shared/style.dart';
import '../../widgets/restaurant_tile.dart';

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
        title: const Row(
          children: [
            Text('Your Favorite Restaurants'),
            SizedBox(width: 8),
            Icon(
              Icons.favorite,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<FavoriteCubit>().loadFavoriteRestaurants();
          },
          child: _buildFavoriteList(),
        ),
      ),
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

        if (state is FavoriteFailed) {
          return Center(
            child: Text(
              state.error,
              style: blackTextStyle,
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
                  (restaurant) => RestaurantTile(
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
