import 'package:flutter/material.dart';
import 'package:flutter_default_code/consts/theme_data.dart';
import 'package:flutter_default_code/provider/dark_theme_provider.dart';
import 'package:flutter_default_code/provider/products.dart';
import 'package:flutter_default_code/screens/cart/cart.dart';
import 'package:flutter_default_code/screens/feeds.dart';
import 'package:flutter_default_code/screens/product_details.dart';
import 'package:flutter_default_code/screens/wishlist/wishlist.dart';
import 'package:provider/provider.dart';

import 'screens/bottom_bar.dart';
import 'screens/inner_screens/brands_navigation_rail_copy.dart';
import 'screens/inner_screens/categories_feeds.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme = await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        }),
        ChangeNotifierProvider(create: (_) => ProductsProvider(),)
      ],
      child: Consumer<DarkThemeProvider>(builder: (context, themeData, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: Styles.themeData(themeChangeProvider.darkTheme, context),
          home: BottomBarScreen(),
          routes: {
            //   '/': (ctx) => LandingPage(),
            BrandNavigationRailScreen.routeName: (ctx) =>
                BrandNavigationRailScreen(),
            Cart.routeName: (ctx) => Cart(),
            Feeds.routeName: (ctx) => Feeds(),
            Wishlist.routeName: (ctx) => Wishlist(),
            ProductDetails.routeName: (ctx) => ProductDetails(),
            BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
            CategoriesFeeds.routeName: (ctx) => CategoriesFeeds(),
          },
        );
      }),
    );
  }
}
