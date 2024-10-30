import 'ingredient.dart';

class Recipe {
  final String id;
  final String name;
  final String description;
  final int preparationTime;
  final int cookingTime;
  final int servings;
  final String? imageUrl;
  final List<Ingredient> ingredients;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.preparationTime,
    required this.cookingTime,
    required this.servings,
    this.imageUrl,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    try {
      return Recipe(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        preparationTime: json['preparationTime'] as int,
        cookingTime: json['cookingTime'] as int,
        servings: json['servings'] as int,
        imageUrl: json['imageUrl'] as String?,
        ingredients: (json['ingredients'] as List)
            .map((ingredientJson) =>
                Ingredient.fromJson(ingredientJson as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      print('Erreur lors de la conversion JSON en Recipe:');
      print('JSON reçu: $json');
      print('Erreur: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'preparationTime': preparationTime,
      'cookingTime': cookingTime,
      'servings': servings,
      'imageUrl': imageUrl,
      'ingredients':
          ingredients.map((ingredient) => ingredient.toJson()).toList(),
    };
  }
}
