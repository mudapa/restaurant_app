import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/models/review_model.dart';
import 'package:restaurant_app/services/review_service.dart';
import 'package:restaurant_app/shared/api_path.dart';

import 'review_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final client = MockClient();
  ReviewService? review;

  setUp(() {
    review = ReviewService();
  });

  test('Create Reviews', () async {
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'id': 'rqdv5juczeskfw1e867',
      'name': 'Anon',
      'review': 'Mantap',
    });
    when(
      client.post(
        Uri.parse('${ApiPath.baseUrl}/review'),
        headers: headers,
        body: body,
      ),
    ).thenAnswer(
      (_) async => http.Response(
          '{"error": false,"message": "success","customerReviews": [{"name": "Dicoding","review": "Mantap","date": "13 November 2019"}]}',
          201),
    );

    expect(
        await review!.createReviews(
          id: 'rqdv5juczeskfw1e867',
          name: 'Anon',
          review: 'Mantap',
          client: client,
        ),
        isA<ReviewModel>());
  });
}
