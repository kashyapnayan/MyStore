import 'package:flutter/material.dart';
import 'package:flutter_default_code/screens/upload_product_form.dart';

import 'bottom_bar.dart';

class MainScreens extends StatelessWidget {
  static const routeName = '/MainScreen';
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [BottomBarScreen(), UploadProductForm()],
    );
  }
}
