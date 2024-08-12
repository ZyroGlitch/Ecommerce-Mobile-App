import 'dart:async';
import 'package:flutter/material.dart';
import '../Homepages/page1.dart';
import '../Homepages/page2.dart';
import '../Homepages/page3.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final PageController controlPage = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (controlPage.page! < 2) {
        controlPage.nextPage(
            duration: const Duration(milliseconds: 1000), curve: Curves.easeIn);
      } else {
        controlPage.animateToPage(0,
            duration: const Duration(milliseconds: 1000), curve: Curves.easeIn);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    controlPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      controller: controlPage,
      scrollDirection: Axis.vertical,
      children: [
        Page1(),
        Page2(),
        Page3(),
      ],
    ));
  }
}
