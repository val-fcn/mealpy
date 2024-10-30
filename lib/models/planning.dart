import 'package:flutter/material.dart';

class Planning {
  Planning({required this.id, required this.name, required this.dateRange});
  final String id;
  final String name;
  final DateTimeRange dateRange;
}

class PlanningDay {
  PlanningDay({
    required this.date,
    required this.meals,
    required this.recipes,
    required this.type,
  });
  final DateTime date;
  final List<Meal> meals;
  final List<Recipe> recipes;
  final String type;
}

class Meal {
  Meal({required this.id, required this.name, required this.recipes});
  final String id;
  final String name;
  final List<Recipe> recipes;
}

class Recipe {
  Recipe({required this.id, required this.name, required this.ingredients});
  final String id;
  final String name;
  final List<Ingredient> ingredients;
}

class Ingredient {
  Ingredient(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.unit});
  final String id;
  final String name;
  final double quantity;
  final String unit;
}

class ShoppingItem {
  ShoppingItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.isChecked,
  });
  final String id;
  final String name;
  final double quantity;
  final String unit;
  final bool isChecked;
}
