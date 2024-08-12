import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({super.key});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('TAB BAR'),
          centerTitle: true,
          bottom: ButtonsTabBar(
            elevation: 3,
            contentCenter: true,
            radius: 25,
            contentPadding: EdgeInsets.all(15),
            width: 135,
            height: 60,
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            tabs: [
              Tab(
                icon: Icon(
                  Icons.directions_run,
                ),
                text: 'Favorite',
              ),
              Tab(
                icon: Icon(Icons.settings),
                text: 'Settings',
              ),
              Tab(
                icon: Icon(Icons.account_circle),
                text: 'Profile',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Text('HEART'),
            ),
            Center(
              child: Text('SETTING'),
            ),
            Center(
              child: Text('PROFILE'),
            ),
          ],
        ),
      ),
    );
  }
}
