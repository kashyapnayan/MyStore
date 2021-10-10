import 'package:flutter/material.dart';
import 'package:flutter_default_code/provider/products_provider.dart';
import 'package:flutter_default_code/widgets/feeds_products.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ionicons/ionicons.dart';
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

      body: (productsList.isEmpty)?Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Ionicons.cloud, size: 80,),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Text('No Products available related to this category!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18)),
          ),
        ],
      ):GridView.count(
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
