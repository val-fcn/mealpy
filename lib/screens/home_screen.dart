import 'package:flutter/material.dart';

import '../services/auth_services.dart';
import '../themes/theme.dart';
import '../widgets/new_planning.dart';
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
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
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
    return Scaffold(
      bottomNavigationBar: const Tabs(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: AuthServices().signOut,
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                _tabController.index == 0
                    ? Icons.calendar_month
                    : Icons.calendar_month_outlined,
                color: Colors.white,
              ),
              child: const Text(
                'Meals plan',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              icon: Icon(
                _tabController.index == 1
                    ? Icons.shopping_cart
                    : Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
              child: const Text(
                'Shopping list',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(
            child: PlanningList(),
          ),
          Center(
            child: ShoppingList(),
          ),
        ],
      ),
    );
  }
}
