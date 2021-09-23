import 'package:flutter/material.dart';
import 'package:flutter_default_code/models/product.dart';
import 'package:flutter_default_code/provider/products.dart';
import 'package:flutter_default_code/widgets/feeds_products.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class CategoriesFeeds extends StatelessWidget {
  static const routeName = '/CategoriesFeedsScreen';
  const CategoriesFeeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context, listen: false);
    final categoryName = ModalRoute.of(context)!.settings.arguments as String;
    final productsList = productsProvider.findByCategory(categoryName);
    return Scaffold(
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

      body: GridView.count(
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
    );
  }
}
