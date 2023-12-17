import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/models/detail_restauraunt_model.dart';
import 'package:restaurant_app/models/find_restaurant.dart';
import 'package:restaurant_app/models/list_restaurant.dart';
import 'package:restaurant_app/models/review_model.dart';
import 'package:restaurant_app/services/restaurant_service.dart';
import 'package:restaurant_app/services/review_service.dart';
import 'package:restaurant_app/shared/api_path.dart';

import 'restaurant_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('restaurant test', () {
    RestaurantService? restaurantService;
    ReviewService? reviewService;
    MockClient? mockClient;

    setUp(() {
      mockClient = MockClient();
      restaurantService = RestaurantService();
      reviewService = ReviewService();
    });

    test('get list restaurants', () async {
      restaurantService!.getListRestaurants();

      when(mockClient!.get(Uri.parse('${ApiPath.baseUrl}/list'))).thenAnswer(
          (_) async => http.Response(
              '{"error": false, "message": "success", "count": 20, "restaurants": [{"id": "rqdv5juczeskfw1e867", "name": "Melting Pot", "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.", "pictureId": "14", "city": "Medan", "rating": 4.2}]}',
              200));

      expect(
          await restaurantService!.getListRestaurants(), isA<ListRestaurant>());
    });

    test('get search restaurants', () async {
      restaurantService!.getSearchRestaurants('melting pot');

      when(mockClient!
              .get(Uri.parse('${ApiPath.baseUrl}/search?q=melting pot')))
          .thenAnswer((_) async => http.Response(
              '{"error": false, "founded": 1, "restaurants": [{"id": "rqdv5juczeskfw1e867", "name": "Melting Pot"}]}',
              200));

      expect(await restaurantService!.getSearchRestaurants('melting pot'),
          isA<FindRestaurant>());
    });

    test('get detail restaurants', () async {
      restaurantService!.getDetailRestaurant('rqdv5juczeskfw1e867');

      when(mockClient!
              .get(Uri.parse('${ApiPath.baseUrl}/detail/rqdv5juczeskfw1e867')))
          .thenAnswer((_) async => http.Response(
              '{"error": false, "message": "success", "restaurant": {"id": "rqdv5juczeskfw1e867", "name": "Melting Pot", "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.", "city": "Medan", "address": "Jln. Pandeglang no 19", "pictureId": "14", "categories": [{"name": "Italia"}, {"name": "Modern"}], "menus": {"foods": [{"name": "Paket rosemary"}, {"name": "Toastie salmon"}, {"name": "Bebek crepes"}, {"name": "Salad lengkeng"}, {"name": "Tumis leek"}, {"name": "Salmon steak"}, {"name": "Napolitana"}, {"name": "Daging Sapi"}], "drinks": [{"name": "Jus tomat"}, {"name": "Minuman soda"}, {"name": "Jus apel"}, {"name": "Jus mangga"}, {"name": "Es krim"}, {"name": "Kopi espresso"}, {"name": "Jus alpukat"}, {"name": "Coklat panas"}, {"name": "Es kopi"}, {"name": "Teh manis"}, {"name": "Sirup"}, {"name": "Jus jeruk"}]}, "rating": 4.2, "customerReviews": [{"name": "Ahmad", "review": "Tidak rekomendasi untuk pelajar!", "date": "13 November 2019"}, {"name": "Arif", "review": "Tempatnya bagus namun menurut saya masih sedikit mahal.", "date": "13 November 2019"}, {"name": "Gilang", "review": "Harga rasa kualitas, tempatnya juga nyaman.", "date": "13 November 2019"}]}}',
              200));

      expect(
          await restaurantService!.getDetailRestaurant('rqdv5juczeskfw1e867'),
          isA<DetailRestaurantModel>());
    });

    test('create review restaurants', () async {
      reviewService!.createReviews(
          id: 'rqdv5juczeskfw1e867', name: 'test', review: 'test2');

      when(mockClient!.post(Uri.parse('${ApiPath.baseUrl}/review'), body: {
        'id': 'rqdv5juczeskfw1e867',
        'name': 'test',
        'review': 'test2'
      })).thenAnswer((_) async => http.Response(
          '{"error": false, "message": "success", "customerReviews": [{"name": "Ahmad", "review": "Tidak rekomendasi untuk pelajar!", "date": "13 November 2019"}]}',
          201));

      expect(
          await reviewService!.createReviews(
              id: 'rqdv5juczeskfw1e867', name: 'test', review: 'test2'),
          isA<ReviewModel>());
    });
  });
}
