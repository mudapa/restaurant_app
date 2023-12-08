import 'package:flutter/material.dart';

import '../../../models/restaurant_model.dart';
import '../../../shared/style.dart';
import '../../widgets/restaurant_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  late List<RestaurantModel> filteredRestaurants = [];
  late List<RestaurantModel> allRestaurants = [];

  bool changeColor = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
    searchController.addListener(_updateFilteredRestaurants);
  }

  Future<void> _initializeData() async {
    final data = await fetchRestaurantData();
    setState(() {
      allRestaurants = parseRestaurant(data);
      filteredRestaurants = allRestaurants;
    });
  }

  Future<String> fetchRestaurantData() async {
    return DefaultAssetBundle.of(context)
        .loadString('assets/local_restaurant.json');
  }

  void _updateFilteredRestaurants() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredRestaurants = allRestaurants
          .where((r) => r.name!.toLowerCase().contains(query))
          .toList();

      if (query.isNotEmpty) {
        changeColor = true;
      } else {
        changeColor = false;
      }
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_updateFilteredRestaurants);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 50),
              itemCount: filteredRestaurants.isNotEmpty
                  ? filteredRestaurants.length
                  : allRestaurants.length,
              itemBuilder: (context, index) {
                if (filteredRestaurants.isEmpty &&
                    searchController.text.isNotEmpty) {
                  return Container();
                }
                return _buildItem(
                  context,
                  filteredRestaurants.isNotEmpty
                      ? filteredRestaurants[index]
                      : allRestaurants[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    RestaurantModel restaurant,
  ) {
    return Wrap(
      children: [
        RestaurantItem(restaurant: restaurant),
      ],
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildAppBarText(),
          _buildSearchTextField(),
        ],
      ),
    );
  }

  Widget _buildAppBarText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Restaurant App',
          style: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semiBold,
            shadows: [
              Shadow(
                color: greyColor.withOpacity(0.5),
                offset: const Offset(2, 2),
              ),
            ],
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          'Find your favorite restaurant',
          style: greyTextStyle.copyWith(
            fontSize: 12,
            fontWeight: medium,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildSearchTextField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 40,
      decoration: BoxDecoration(
        color: changeColor == false ? lightGreyColor : whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: greyColor,
        ),
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.5),
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: _buildTextField(),
    );
  }

  Widget _buildTextField() {
    return TextFormField(
      controller: searchController,
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(
          Icons.search,
          color: greyColor,
        ),
        hintText: 'Search',
        hintStyle: greyTextStyle.copyWith(
          fontSize: 14,
          fontWeight: regular,
        ),
      ),
    );
  }
}
