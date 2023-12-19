import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/models/detail_restauraunt_model.dart';
import 'package:restaurant_app/models/find_restaurant.dart';
import 'package:restaurant_app/models/list_restaurant.dart';
import 'package:restaurant_app/services/restaurant_service.dart';
import 'package:restaurant_app/shared/api_path.dart';

import 'restaurant_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Test Restaurant Service', () {
    final client = MockClient();
    RestaurantService? restaurant;

    setUp(() {
      restaurant = RestaurantService();
    });

    test('Get List Restaurants', () async {
      when(client.get(Uri.parse('${ApiPath.baseUrl}/list'))).thenAnswer(
        (_) async => http.Response(
            '{"error": false,"message": "success","count": 20,"restaurants": [{"id": "rqdv5juczeskfw1e867","name": "Melting Pot","description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...","pictureId": "14","city": "Medan","rating": 4.2}]}',
            200),
      );

      expect(
          await restaurant!.getListRestaurants(client), isA<ListRestaurant>());
    });

    test('Get Search Restaurants', () async {
      when(client.get(Uri.parse('${ApiPath.baseUrl}/search?q=Melting%20Pot')))
          .thenAnswer(
        (_) async => http.Response(
            '{"error": false,"founded": 1,"restaurants": [{"id": "rqdv5juczeskfw1e867","name": "Melting Pot","description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...","pictureId": "14","city": "Medan","rating": 4.2}]}',
            200),
      );

      expect(await restaurant!.getSearchRestaurants('Melting Pot', client),
          isA<FindRestaurant>());
    });

    test('Get Detail Restaurant', () async {
      when(client
              .get(Uri.parse('${ApiPath.baseUrl}/detail/rqdv5juczeskfw1e867')))
          .thenAnswer(
        (_) async => http.Response(
            '{"error": false,"message": "success","restaurant": {"id": "rqdv5juczeskfw1e867","name": "Melting Pot","description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...","city": "Medan","address": "Jln. Pandeglang no 19","pictureId": "14","categories": [{"name": "Italia"},{"name": "Modern"}],"menus": {"foods": [{"name": "Paket rosemary"},{"name": "Toastie salmon"},{"name": "Bebek crepes"},{"name": "Salad lengkeng"},{"name": "Tumis leek"},{"name": "Salmon steak"}],"drinks": [{"name": "Es krim"},{"name": "Sirup"},{"name": "Jus apel"},{"name": "Jus jeruk"},{"name": "Coklat panas"},{"name": "Air"}]},"rating": 4.2,"customerReviews": [{"name": "Ahmad","review": "Tidak rekomendasi untuk pelajar!","date": "13 November 2019"},{"name": "Arif","review": "Tempatnya bagus namun menurut saya masih sedikit mahal.","date": "13 November 2019"},{"name": "Gilang","review": "Harga rasa kualitas, pelayanan, tempat semuanya oke","date": "13 November 2019"}]}}',
            200),
      );

      expect(
          await restaurant!.getDetailRestaurant('rqdv5juczeskfw1e867', client),
          isA<DetailRestaurantModel>());
    });
  });
}
