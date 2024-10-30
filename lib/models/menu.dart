import 'meal.dart';

enum MealType { breakfast, lunch, dinner, snack, dessert }

class Menu {
  final String id;
  final String userId;
  final DateTime date;
  final String normalizedDate;
  final List<Meal> meals;

  Menu({
    required this.id,
    required this.userId,
    required this.date,
    required this.meals,
    required this.normalizedDate,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    try {
      print('Conversion JSON en Menu:'); // Debug
      print('- ID: ${json['id']}');
      print('- UserID: ${json['userId']}');
      print('- Date: ${json['date']}');
      print('- NormalizedDate: ${json['normalizedDate']}');
      print('- Meals count: ${(json['meals'] as List).length}');

      return Menu(
        id: json['id'] as String,
        userId: json['userId'] as String,
        date: DateTime.parse(json['date']),
        normalizedDate: json['normalizedDate'] as String,
        meals: (json['meals'] as List)
            .map((mealJson) => Meal.fromJson(mealJson as Map<String, dynamic>))
            .toList(),
      );
    } catch (e, stackTrace) {
      print('Erreur lors de la conversion JSON en Menu:');
      print('JSON reçu: $json');
      print('Erreur: $e');
      print('StackTrace: $stackTrace');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'normalizedDate': normalizedDate,
      'meals': meals.map((meal) => meal.toJson()).toList(),
    };
  }
}
