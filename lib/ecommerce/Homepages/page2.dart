import 'package:firebase_journey/ecommerce/Homepages/components/page.dart';
import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  Page2({super.key});

  var descriptions =
      '100% satisfaction guaranteed or your money back. Shop confidently!';

  @override
  Widget build(BuildContext context) {
    return BuildPage(
      image: 'images/ecommerce_assets/home2.png',
      title: 'Satisfaction Guaranteed',
      description: descriptions,
    );
  }
}
