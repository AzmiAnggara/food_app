import 'package:flutter/material.dart';
import 'package:food_app/config/session.dart';
import 'package:food_app/presentation/controller/c_dashboard.dart';

import 'package:food_app/presentation/page/auth/login_pages.dart';
import 'package:food_app/presentation/page/dashboard/account_page.dart';
import 'package:food_app/presentation/page/dashboard/cart_page.dart';
import 'package:food_app/presentation/page/dashboard/history_page.dart';
import 'package:food_app/presentation/page/dashboard/home_page.dart';
import 'package:food_app/presentation/page/dashboard/order_page.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);

  final List navs = [
    {'icon': Icons.home, 'label': 'Home', 'view': HomePage()},
    {'icon': Icons.shopping_cart, 'label': 'Cart', 'view': CartPage()},
    {'icon': Icons.list, 'label': 'List', 'view': OrderPage()},
    {'icon': Icons.history, 'label': 'History', 'view': HistoryPage()},
    {'icon': Icons.account_circle, 'label': 'Account', 'view': AccountPage()},
  ];

  final cDashboard = Get.put(CDashboard());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return navs[cDashboard.indexNav]['view'];
      }),
      extendBody: true,
      bottomNavigationBar: Obx(() {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Material(
            elevation: 8,
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              currentIndex: cDashboard.indexNav,
              onTap: (newIndex) {
                cDashboard.indexNav = newIndex;
              },
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: List.generate(navs.length, (index) {
                return BottomNavigationBarItem(
                  icon: Icon(navs[index]['icon']),
                  label: navs[index]['label'],
                );
              }),
            ),
          ),
        );
      }),
    );
  }
}
