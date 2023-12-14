import 'restaurant_model.dart';

class ListRestaurant {
  final bool? error;
  final String? message;
  final int? count;
  final List<Restaurant>? restaurants;

  ListRestaurant({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  factory ListRestaurant.fromJson(Map<String, dynamic> json) => ListRestaurant(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: json["restaurants"] == null
            ? []
            : List<Restaurant>.from(
                json["restaurants"]!.map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": restaurants == null
            ? []
            : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
      };
}
