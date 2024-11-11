import 'package:flutter/material.dart';

import '../services/auth_services.dart';
import '../themes/theme.dart';
import '../widgets/planning_list.dart';
import '../widgets/shopping_list.dart';
import '../widgets/tabs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {}); // Force le rebuild quand l'onglet change
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {
            setState(() {
              _tabController.index = index;
            });
          },
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_month,
                color: AppTheme.primaryColor,
              ),
              label: 'Mon planning',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                color: AppTheme.primaryColor,
              ),
              label: 'Mes courses',
            ),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            PlanningList(),
            //ShoppingList(),
          ],
        ),
      ),
    );
  }
}
