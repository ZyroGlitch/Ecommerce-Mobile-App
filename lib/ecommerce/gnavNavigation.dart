import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'NavigationBar/cart.dart';
import 'NavigationBar/home.dart';
import 'NavigationBar/product.dart';
import 'NavigationBar/profile.dart';

class Gnavigation extends StatefulWidget {
  final int? selectedIndex;

  const Gnavigation({Key? key, this.selectedIndex}) : super(key: key);

  @override
  _GnavigationState createState() => _GnavigationState();
}

class _GnavigationState extends State<Gnavigation> {
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex ?? 0; // Default to 0 if not provided
    super.initState();
  }

  static List<Widget> pages = [
    Homepage(),
    ProductPage(),
    const CartPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: GNav(
        gap: 8,
        backgroundColor: Colors.black,
        color: Colors.white,
        activeColor: Colors.white,
        onTabChange: _onItemTapped,
        selectedIndex: _selectedIndex,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.storefront_rounded,
            text: 'Product',
          ),
          GButton(
            icon: Icons.shopping_cart,
            text: 'Cart',
          ),
          GButton(
            icon: Icons.account_circle,
            text: 'Profile',
          ),
        ],
      ),
    );
  }
}
