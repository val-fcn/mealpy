import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/menu.dart';
import '../services/menu_service.dart';
import '../themes/theme.dart';

class PlanningList extends StatefulWidget {
  const PlanningList({super.key});

  @override
  State<PlanningList> createState() => _PlanningListState();
}

class _PlanningListState extends State<PlanningList> {
  final MenuService _menuService = MenuService();
  late DateTime _selectedDay;
  List<Menu> _menus = [];
  Menu? _currentMenu;
  bool _isLoading = true;

  String get _userId => FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _loadMenu();
    _loadMenus();
  }

  Future<void> _loadMenus() async {
    _menus = await _menuService.getMenusForDateRange(
      _userId,
      _getCurrentWeekDays().first,
      _getCurrentWeekDays().last,
    );
  }

  Future<void> _loadMenu() async {
    if (_userId.isEmpty) {
      print('Pas d\'utilisateur connecté');
      setState(() => _isLoading = false);
      return;
    }

    setState(() => _isLoading = true);
    try {
      // Vérification de l'authentification
      final currentUser = FirebaseAuth.instance.currentUser;

      final menu = await _menuService.getMenuForDate(_userId, _selectedDay);

      setState(() {
        _currentMenu = menu;
        _isLoading = false;
      });
    } catch (e, stackTrace) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDateSlider(),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildMenuContent(),
        ),
      ],
    );
  }

  Widget _buildDateSlider() {
    return Container(
      height: 100,
      color: AppTheme.primaryColor.withOpacity(0.3),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          final weekDays = _getCurrentWeekDays();
          final day = weekDays[index];
          final isSelected = day.year == _selectedDay.year &&
              day.month == _selectedDay.month &&
              day.day == _selectedDay.day;

          return GestureDetector(
            onTap: () async {
              setState(() {
                _selectedDay = day;
              });
              await _loadMenu(); // Charger le menu du jour sélectionné
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 7,
              margin: const EdgeInsets.symmetric(horizontal: 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.primaryColor.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: isSelected
                          ? Border.all(color: AppTheme.primaryColor)
                          : null,
                    ),
                    child: Column(
                      children: [
                        Text(
                          day.day.toString(),
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        Text(
                          DateFormat('EEE', 'fr_FR').format(day),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        if (_menus.any((menu) =>
                            menu.date.day == day.day &&
                            menu.date.month == day.month &&
                            menu.date.year == day.year))
                          const Icon(Icons.circle,
                              size: 8, color: AppTheme.primaryColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuContent() {
    if (_currentMenu == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Aucun menu prévu pour ce jour'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Créer un menu'),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ..._buildMealsByType(MealType.breakfast, 'Petit déjeuner'),
        ..._buildMealsByType(MealType.lunch, 'Déjeuner'),
        ..._buildMealsByType(MealType.snack, 'Goûter'),
        ..._buildMealsByType(MealType.dinner, 'Dîner'),
        ..._buildMealsByType(MealType.dessert, 'Dessert'),
      ],
    );
  }

  List<Widget> _buildMealsByType(MealType type, String title) {
    final meals =
        _currentMenu?.meals.where((meal) => meal.type == type).toList() ?? [];

    if (meals.isEmpty) return [];

    return [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      ...meals.expand((meal) => meal.recipes.map(
            (recipe) => Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: recipe.imageUrl != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(recipe.imageUrl!),
                      )
                    : const CircleAvatar(
                        child: Icon(Icons.restaurant),
                      ),
                title: Text(recipe.name),
                subtitle: Text(
                  '${recipe.preparationTime + recipe.cookingTime} min • ${recipe.servings} pers.',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Navigation vers le détail de la recette
                },
              ),
            ),
          )),
    ];
  }

  List<DateTime> _getCurrentWeekDays() {
    final now = _selectedDay;
    final monday = now.subtract(Duration(days: now.weekday - 1));
    return List.generate(7, (index) => monday.add(Duration(days: index)));
  }
}
