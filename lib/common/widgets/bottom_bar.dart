import 'package:amazone_clone/constants/global_constants.dart';
import 'package:amazone_clone/features/home/screens/home_screen.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../../features/account/screen/account_screen.dart';

class BottomBar extends StatefulWidget {
  static const routeName = "/bottom";
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _pages = 0;

  void updatePage(int page) {
    setState(() {
      _pages = page;
    });
  }

  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const Center(child: Text("cart Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_pages],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pages,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          //Home
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                  color: _pages == 0
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.backgroundColor,
                  width: bottomBarBorderWidth,
                )),
              ),
              child: const Icon(Icons.home_outlined),
            ),
            label: '',
          ),
          // Account
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                  color: _pages == 1
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.backgroundColor,
                  width: bottomBarBorderWidth,
                )),
              ),
              child: const Icon(Icons.person_outline_outlined),
            ),
            label: '',
          ),
          // NOTIFICATION
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                  color: _pages == 2
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.backgroundColor,
                  width: bottomBarBorderWidth,
                )),
              ),
              child: Badge(
                badgeColor: Colors.white,
                badgeContent: const Text("2"),
                elevation: 0,
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
