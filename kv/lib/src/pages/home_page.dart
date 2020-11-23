import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kv/src/block/provider.dart';
import 'package:kv/src/models/product_model.dart';
import 'package:kv/src/pages/chat_page.dart';
import 'package:kv/src/pages/new_poduct_page.dart';
import 'package:kv/src/pages/product_list_page.dart';
import 'package:kv/src/pages/search_page.dart';
import 'package:kv/src/pages/user_page.dart';
import 'package:kv/src/providers/product_provider.dart';
import 'package:kv/src/utils/utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _lastPageIndex = 0;
  int _pageindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: _selectPage(_pageindex),
      bottomNavigationBar: _bottomNavigatioBar(),
    );
  }

  Widget _selectPage(int index) {
    switch (index) {
      case 0:
        return ProductListPage();
      case 1:
        return SearchPage();
      case 2:
        return null;
      case 3:
        return ChatPage();
      case 4:
        return UserPage();
      default:
        return ProductListPage();
    }
  }

  Widget _bottomNavigatioBar() {
    return BottomNavigationBar(
      selectedItemColor: Color.fromRGBO(200, 0, 100, 1),
      currentIndex: _pageindex,
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      onTap: (index) {
        setState(() {
          _lastPageIndex = _pageindex;
          _pageindex = index;
          if (_pageindex == 2) {
            Navigator.of(context).push(animatonUpRoute());
            _pageindex = _lastPageIndex;
          }
        });
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Search'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              color: Color.fromRGBO(200, 0, 100, 0.88),
              size: 33,
            ),
            label: 'Sell'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
            ),
            label: 'Chat'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile'),
      ],
    );
  }
}
