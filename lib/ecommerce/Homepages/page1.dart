import 'package:flutter/material.dart';
import 'components/page.dart';

class Page1 extends StatelessWidget {
  Page1({super.key});

  var descriptions =
      'Your ultimate mobile shopping destination designed to make your online buying experience fast, easy, and enjoyable.';

  @override
  Widget build(BuildContext context) {
    return BuildPage(
      image: 'images/ecommerce_assets/home1.png',
      title: 'ShopEase',
      description: descriptions,
    );
  }
}
