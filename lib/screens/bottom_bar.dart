import 'package:flutter/material.dart';
import 'package:flutter_default_code/consts/my_icons.dart';
import 'package:flutter_default_code/screens/search.dart';

import 'cart/cart.dart';
import 'feeds.dart';
import 'home.dart';
import 'user_info.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarScreen';
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  var _pages;
  int _selectedPageIndex = 1;
  late List<Object> pages;
  @override
  void initState() {
    // pages = [
    //   Home(),
    //   Feeds(),
    //   Search(),
    //   Cart(),
    //   UserInfo(),
    // ];
    _pages = [
      {
        'page': Home(),
        'title': 'Home'
      },
      {
        'page': Feeds(),
        'title': 'Feeds'
      },
      {
        'page': Search(),
        'title': 'Search'
      },
      {
        'page': Cart(),
        'title': 'Cart'
      },
      {
        'page': UserInfo(),
        'title': 'User Info'
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: _pages[_selectedPageIndex]['title'],),
      // body: pages[_selectedPageIndex],
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomAppBar(
        // color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight * 0.98,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              onTap: _selectPage,
              backgroundColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.black26,
              selectedItemColor: Colors.teal,
              currentIndex: _selectedPageIndex,
              selectedLabelStyle: TextStyle(color: Colors.black26),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(MyAppIcons.home),
                  // title: Text('Home'),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(MyAppIcons.rss), label: 'Feeds'),
                BottomNavigationBarItem(
                    activeIcon: null, icon: Icon(null), label: 'Search'),
                BottomNavigationBarItem(
                    icon: Icon(
                      MyAppIcons.bag,
                    ),
                    label: 'Cart'),
                BottomNavigationBarItem(
                    icon: Icon(MyAppIcons.user), label: 'User'),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.teal,
          hoverElevation: 10,
          splashColor: Colors.grey,
          tooltip: 'Search',
          elevation: 4,
          child: Icon(MyAppIcons.search),
          onPressed: () => setState(() {
            _selectedPageIndex = 2;
          }),
        ),
      ),
    );
  }
}