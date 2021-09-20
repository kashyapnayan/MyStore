import 'package:flutter/material.dart';
import 'package:flutter_default_code/consts/theme_data.dart';
import 'package:flutter_default_code/provider/dark_theme_provider.dart';
import 'package:flutter_default_code/screens/cart.dart';
import 'package:flutter_default_code/screens/feeds.dart';
import 'package:provider/provider.dart';

import 'screens/bottom_bar.dart';

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
        })
      ],
      child: Consumer<DarkThemeProvider>(builder: (context, themeData, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: Styles.themeData(themeChangeProvider.darkTheme, context),
          home: BottomBarScreen(),
          routes: {
            //   '/': (ctx) => LandingPage(),
            Cart.routeName: (ctx) => Cart(),
            Feeds.routeName: (ctx) => Feeds(),
            BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
          },
        );
      }),
    );
  }
}
