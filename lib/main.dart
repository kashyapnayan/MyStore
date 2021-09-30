import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_code/consts/theme_data.dart';
import 'package:flutter_default_code/provider/dark_theme_provider.dart';
import 'package:flutter_default_code/screens/auth/forget_password.dart';
import 'package:flutter_default_code/screens/auth/login.dart';
import 'package:flutter_default_code/screens/auth/sign_up.dart';
import 'package:flutter_default_code/screens/cart/cart.dart';
import 'package:flutter_default_code/screens/feeds.dart';
import 'package:flutter_default_code/screens/product_details.dart';
import 'package:flutter_default_code/screens/wishlist/wishlist.dart';
import 'package:provider/provider.dart';

import 'provider/cart_provider.dart';
import 'provider/fav_provider.dart';
import 'provider/products_provider.dart';
import 'screens/bottom_bar.dart';
import 'screens/inner_screens/brands_navigation_rail.dart';
import 'screens/inner_screens/categories_feeds.dart';
import 'screens/landing_page.dart';
import 'screens/main_screen.dart';
import 'screens/upload_product_form.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
      future: _firebaseInitialization,
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error initializing Firebase'),
              ),
            ),
          );
        } else if(snapshot.connectionState == ConnectionState.waiting){
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) {
              return themeChangeProvider;
            }),
            ChangeNotifierProvider(create: (_) => ProductsProvider(),),
            ChangeNotifierProvider(create: (_) => CartProvider(),),
            ChangeNotifierProvider(create: (_) => FavProvider(),),
          ],
          child: Consumer<DarkThemeProvider>(builder: (context, themeData, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: Styles.themeData(themeChangeProvider.darkTheme, context),
              home: LandingPage(),
              routes: {
                //   '/': (ctx) => LandingPage(),
                BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
                BrandNavigationRailScreen.routeName: (ctx) =>
                    BrandNavigationRailScreen(),
                Cart.routeName: (ctx) => Cart(),
                CategoriesFeeds.routeName: (ctx) => CategoriesFeeds(),
                Feeds.routeName: (ctx) => Feeds(),
                ForgetPassword.routeName: (ctx) => ForgetPassword(),
                LoginScreen.routeName: (ctx) => LoginScreen(),
                MainScreens.routeName: (ctx) => MainScreens(),
                ProductDetails.routeName: (ctx) => ProductDetails(),
                SignUpScreen.routeName: (ctx) => SignUpScreen(),
                UploadProductForm.routeName: (ctx) => UploadProductForm(),
                Wishlist.routeName: (ctx) => Wishlist(),
              },
            );
          }),
        );
      }
    );
  }
}
