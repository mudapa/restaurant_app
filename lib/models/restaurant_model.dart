import 'dart:convert';

class RestaurantModel {
  final String? id;
  final String? name;
  final String? description;
  final String? pictureId;
  final String? city;
  final double? rating;
  final Menus? menus;

  RestaurantModel({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menus,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      pictureId: json["pictureId"],
      city: json["city"],
      rating: json["rating"]?.toDouble(),
      menus: json["menus"] == null ? null : Menus.fromJson(json["menus"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
      'menus': menus?.toJson(),
    };
  }
}

class Menus {
  final List<Food>? foods;
  final List<Drink>? drinks;

  Menus({
    this.foods,
    this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: json['foods'] == null
          ? null
          : List<Food>.from(json['foods'].map((x) => Food.fromJson(x))),
      drinks: json['drinks'] == null
          ? null
          : List<Drink>.from(json['drinks'].map((x) => Drink.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'foods': foods?.map((e) => e.toJson()).toList(),
      'drinks': drinks?.map((e) => e.toJson()).toList(),
    };
  }
}

class Drink {
  final String? name;

  Drink({
    this.name,
  });

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}

class Food {
  final String? name;

  Food({
    this.name,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}

List<RestaurantModel> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json);
  return parsed.map((e) => RestaurantModel.fromJson(e)).toList();
}
