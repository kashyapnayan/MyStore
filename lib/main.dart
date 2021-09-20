import 'package:flutter/material.dart';
import 'package:flutter_default_code/screens/cart.dart';
import 'package:flutter_default_code/screens/feeds.dart';

import 'screens/bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: BottomBarScreen(),
      routes: {
        //   '/': (ctx) => LandingPage(),
        Cart.routeName: (ctx) => Cart(),
        Feeds.routeName: (ctx) => Feeds(),
        BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
      },
    );
  }
}
