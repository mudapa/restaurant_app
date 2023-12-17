import 'dart:convert';

import '../models/review_model.dart';
import 'package:http/http.dart' as http;

import '../shared/api_path.dart';

class ReviewService {
  Future<ReviewModel> createReviews({
    required String id,
    required String name,
    required String review,
  }) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var body = jsonEncode({
        'id': id,
        'name': name,
        'review': review,
      });
      final response = await http.post(
        Uri.parse('${ApiPath.baseUrl}/review'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        return ReviewModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create data');
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
