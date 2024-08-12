import 'package:firebase_journey/ecommerce/Homepages/components/page.dart';
import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  Page3({super.key});

  var descriptions =
      'Explore glowing reviews from our delighted customers. Shop with confidence knowing others love what they bought!';

  @override
  Widget build(BuildContext context) {
    return BuildPage(
      image: 'images/ecommerce_assets/home3.png',
      title: 'Excellent Reviews',
      description: descriptions,
    );
  }
}
