class Ingredient {
  final String id;
  final String name;
  final double quantity;
  final String unit; // g, ml, pièce, etc.

  Ingredient({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    try {
      final dynamic rawQuantity = json['quantity'];
      final double quantity =
          rawQuantity is int ? rawQuantity.toDouble() : rawQuantity;

      return Ingredient(
        id: json['id'] as String,
        name: json['name'] as String,
        quantity: quantity,
        unit: json['unit'] as String,
      );
    } catch (e) {
      print('Erreur lors de la conversion JSON en Ingredient:');
      print('JSON reçu: $json');
      print('Erreur: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'unit': unit,
    };
  }
}
