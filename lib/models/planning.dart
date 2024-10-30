import 'package:flutter/material.dart';

class Planning {
  Planning(
      {required this.id,
      required this.name,
      required this.dateRange,
      required this.days});
  final String id;
  final String name;
  final DateTimeRange dateRange;
  final List<PlanningDay> days;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dateRange': dateRange,
      'days': days,
    };
  }

  static Planning fromJson(Map<String, dynamic> json) {
    return Planning(
      id: json['id'],
      name: json['name'],
      dateRange: json['dateRange'],
      days: json['days'],
    );
  }
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
