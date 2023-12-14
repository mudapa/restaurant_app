import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/detail_restauraunt_model.dart';
import '../models/find_restaurant.dart';
import '../models/list_restaurant.dart';
import '../shared/api_path.dart';

class RestaurantService {
  Future<ListRestaurant> getListRestaurants() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiPath.baseUrl}/list'),
      );

      if (response.statusCode == 200) {
        return ListRestaurant.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load data');
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<FindRestaurant> getSearchRestaurants(String query) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiPath.baseUrl}/search?q=$query'),
      );

      if (response.statusCode == 200) {
        return FindRestaurant.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load data');
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<DetailRestaurantModel> getDetailRestaurant(String id) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiPath.baseUrl}/detail/$id'),
      );

      if (response.statusCode == 200) {
        return DetailRestaurantModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load data');
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
