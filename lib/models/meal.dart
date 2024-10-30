import 'menu.dart';
import 'recipe.dart';

class Meal {
  final String id;
  final MealType type;
  final List<Recipe> recipes;

  Meal({
    required this.id,
    required this.type,
    required this.recipes,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    try {
      return Meal(
        id: json['id'] as String,
        type: _stringToMealType(json['type'] as String),
        recipes: (json['recipes'] as List)
            .map((recipeJson) =>
                Recipe.fromJson(recipeJson as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      print('Erreur lors de la conversion JSON en Meal:');
      print('JSON reçu: $json');
      print('Erreur: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString().split('.').last,
      'recipes': recipes.map((recipe) => recipe.toJson()).toList(),
    };
  }

  static MealType _stringToMealType(String type) {
    switch (type.toLowerCase()) {
      case 'breakfast':
        return MealType.breakfast;
      case 'lunch':
        return MealType.lunch;
      case 'dinner':
        return MealType.dinner;
      case 'snack':
        return MealType.snack;
      case 'dessert':
        return MealType.dessert;
      default:
        throw Exception('Type de repas inconnu: $type');
    }
  }
}
