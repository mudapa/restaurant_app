import 'restaurant_model.dart';

class FindRestaurant {
  final bool? error;
  final int? founded;
  final List<Restaurant>? restaurants;

  FindRestaurant({
    this.error,
    this.founded,
    this.restaurants,
  });

  factory FindRestaurant.fromJson(Map<String, dynamic> json) => FindRestaurant(
        error: json["error"],
        founded: json["founded"],
        restaurants: json["restaurants"] == null
            ? []
            : List<Restaurant>.from(
                json["restaurants"]!.map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": restaurants == null
            ? []
            : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
      };
}
