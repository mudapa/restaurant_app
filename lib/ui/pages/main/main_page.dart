import 'package:flutter/material.dart';

import '../../../shared/style.dart';
import '../../widgets/find_restaurant_modal.dart';
import 'favorite_page.dart';
import 'home_page.dart';
import 'setting_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _bottomNavIndex = 0;

  final List<Widget> _listWidget = const [
    HomePage(),
    FavoritePage(),
    SettingPage(),
  ];
  final List<BottomNavigationBarItem> _bottomNavBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(
        key: Key('home_page_bottom_nav_item'),
        Icons.home_filled,
      ),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        key: Key('favorite_page_bottom_nav_item'),
        Icons.favorite,
      ),
      label: "Favorite",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        key: Key('setting_page_bottom_nav_item'),
        Icons.settings,
      ),
      label: "Setting",
    ),
  ];

  void modalBottom() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const FindRestaurantModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      floatingActionButton: _bottomNavIndex != 1 && _bottomNavIndex != 2
          ? FloatingActionButton(
              tooltip: 'Search',
              onPressed: () {
                modalBottom();
              },
              child: Icon(
                key: const Key('search_icon'),
                Icons.search,
                color: whiteColor,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        key: const Key('bottom_nav_bar'),
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: (selected) {
          setState(() {
            _bottomNavIndex = selected;
          });
        },
      ),
    );
  }
}
