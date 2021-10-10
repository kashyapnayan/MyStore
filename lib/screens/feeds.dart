import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_code/consts/colors.dart';
import 'package:flutter_default_code/consts/my_icons.dart';
import 'package:flutter_default_code/models/product.dart';
import 'package:flutter_default_code/provider/cart_provider.dart';
import 'package:flutter_default_code/provider/dark_theme_provider.dart';
import 'package:flutter_default_code/provider/fav_provider.dart';
import 'package:flutter_default_code/provider/products_provider.dart';
import 'package:flutter_default_code/widgets/feeds_products.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import 'cart/cart.dart';
import 'wishlist/wishlist.dart';

class Feeds extends StatefulWidget {
  static const routeName = '/FeedsScreen';
  const Feeds({Key? key}) : super(key: key);

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {

  Future<void> _getProductsOnRefresh() async {
    await Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    final popular = ModalRoute.of(context)!.settings.arguments;
    late List<Product> productsList;
    if(popular == 'popular'){
      productsList = productsProvider.popularProducts;
    }else{
      productsList = productsProvider.products;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: Text('Feeds', style: TextStyle(color: themeState.darkTheme ? Colors.white : Colors.black),),
        actions: [
          Consumer<FavProvider>(
            builder: (_, favs, ch) => Badge(
              badgeColor: ColorsConsts.cartBadgeColor,
              animationType: BadgeAnimationType.slide,
              toAnimate: true,
              position: BadgePosition.topEnd(top: 5, end: 7),
              badgeContent: Text(
                favs.getFavItems.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: IconButton(
                icon: Icon(
                  MyAppIcons.wishlist,
                  color: ColorsConsts.favColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(Wishlist.routeName);
                },
              ),
            ),
          ),
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              badgeColor: ColorsConsts.cartBadgeColor,
              animationType: BadgeAnimationType.slide,
              toAnimate: true,
              position: BadgePosition.topEnd(top: 5, end: 7),
              badgeContent: Text(
                cart.getCartItems.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: IconButton(
                icon: Icon(
                  MyAppIcons.cart,
                  color: ColorsConsts.cartColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(Cart.routeName);
                },
              ),
            ),
          ),
        ],
      ),
      // body: StaggeredGridView.countBuilder(
      //   padding: const EdgeInsets.all(8.0),
      //   crossAxisCount: 6,
      //   itemCount: 8,
      //   itemBuilder: (BuildContext context, int index) => FeedsProducts(),
      //   staggeredTileBuilder: (int index) =>
      //       new StaggeredTile.count(3, index.isEven ? 4 : 5),
      //   mainAxisSpacing: 8.0,
      //   crossAxisSpacing: 6.0,
      // ),
      body: RefreshIndicator(
        onRefresh: _getProductsOnRefresh,
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 240 / 420,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: List.generate(
              productsList.length,
            (index) {return ChangeNotifierProvider.value(
              value: productsList[index],
              child: FeedsProducts(),
            );}
          )
        ),
      ),
    );
  }
}
