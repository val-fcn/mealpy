import 'package:flutter/material.dart';

import '../themes/theme.dart';
import '../widgets/new_planning.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FilledButton.icon(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NewPlanning()));
            },
            icon: const Icon(Icons.add),
            label: const Text("Créer un planning"),
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: AppTheme.backgroundColor,
            ),
          )
        ],
      ),
      body: const Center(child: Text('Bienvenue sur l\'application Mealpy !')),
    );
  }
}
