import 'package:flutter/material.dart';
import 'package:flutter_default_code/widgets/feeds_products.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Feeds extends StatelessWidget {
  static const routeName = '/FeedsScreen';
  const Feeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          childAspectRatio: 250/400,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: List.generate(
            20,
            (index) {return FeedsProducts();}
          )
      ),
    );
  }
}
