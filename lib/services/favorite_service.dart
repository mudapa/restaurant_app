import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/restaurant_model.dart';
import '../shared/helper.dart';
import '../shared/style.dart';

class FavoriteService {
  Future<void> toggleFavorite(Restaurant restaurant) async {
    final prefs = await SharedPreferences.getInstance();
    final key = restaurant.id.toString();

    if (await loadFavoriteStatus(restaurant)) {
      prefs.remove(key);
      toast('Removed from favorite', redColor);
    } else {
      final json = restaurant.toJson();
      final jsonString = jsonEncode(json);
      prefs.setString(key, jsonString);
      toast('Added to favorite', greenColor);
    }
  }

  Future<bool> loadFavoriteStatus(Restaurant restaurant) async {
    final prefs = await SharedPreferences.getInstance();
    final key = restaurant.id.toString();

    return prefs.containsKey(key);
  }

  Future<List<Restaurant>> loadFavoriteRestaurants() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    final List<Restaurant> favorites = [];

    for (String key in keys) {
      if (prefs.containsKey(key)) {
        final jsonString = prefs.getString(key);
        if (jsonString != null) {
          final Map<String, dynamic> json = jsonDecode(jsonString);
          final restaurant = Restaurant.fromJson(json);
          favorites.add(restaurant);
        }
      }
    }

    return favorites;
  }

  Future<void> removeFavorite(Restaurant restaurant) async {
    final prefs = await SharedPreferences.getInstance();
    final key = restaurant.id.toString();

    prefs.remove(key);

    toast('Removed from favorites', redColor);
  }
}
