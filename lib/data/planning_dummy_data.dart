import 'package:flutter/material.dart';
import '../models/planning.dart';

class PlanningDummyData {
  static List<Planning> plannings = [
    Planning(
      id: '1',
      name: 'Planning Semaine 1',
      dateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 6)),
      ),
      days: [
        PlanningDay(
          date: DateTime.parse('2024-10-30 12:46:47.820880'),
          type: 'Régulier',
          meals: [
            Meal(
              id: 'm1',
              name: 'Petit déjeuner',
              recipes: [
                Recipe(
                  id: 'r1',
                  name: 'Porridge aux fruits',
                  ingredients: [
                    Ingredient(
                      id: 'i1',
                      name: 'Flocons d\'avoine',
                      quantity: 50,
                      unit: 'g',
                    ),
                    Ingredient(
                      id: 'i2',
                      name: 'Lait d\'amande',
                      quantity: 200,
                      unit: 'ml',
                    ),
                    Ingredient(
                      id: 'i3',
                      name: 'Fruits rouges',
                      quantity: 100,
                      unit: 'g',
                    ),
                  ],
                ),
              ],
            ),
            Meal(
              id: 'm2',
              name: 'Déjeuner',
              recipes: [
                Recipe(
                  id: 'r2',
                  name: 'Salade Buddha Bowl',
                  ingredients: [
                    Ingredient(
                      id: 'i4',
                      name: 'Quinoa',
                      quantity: 100,
                      unit: 'g',
                    ),
                    Ingredient(
                      id: 'i5',
                      name: 'Avocat',
                      quantity: 1,
                      unit: 'pièce',
                    ),
                    Ingredient(
                      id: 'i6',
                      name: 'Pois chiches',
                      quantity: 150,
                      unit: 'g',
                    ),
                  ],
                ),
              ],
            ),
            Meal(
              id: 'm3',
              name: 'Dîner',
              recipes: [
                Recipe(
                  id: 'r3',
                  name: 'Saumon aux légumes',
                  ingredients: [
                    Ingredient(
                      id: 'i7',
                      name: 'Pavé de saumon',
                      quantity: 150,
                      unit: 'g',
                    ),
                    Ingredient(
                      id: 'i8',
                      name: 'Brocolis',
                      quantity: 200,
                      unit: 'g',
                    ),
                    Ingredient(
                      id: 'i9',
                      name: 'Riz',
                      quantity: 75,
                      unit: 'g',
                    ),
                  ],
                ),
              ],
            ),
          ],
          recipes: [],
        ),
        PlanningDay(
          date: DateTime.parse('2024-10-31 12:47:24.964532'),
          type: 'Végétarien',
          meals: [
            Meal(
              id: 'm4',
              name: 'Petit déjeuner',
              recipes: [
                Recipe(
                  id: 'r4',
                  name: 'Toast à l\'avocat',
                  ingredients: [
                    Ingredient(
                      id: 'i10',
                      name: 'Pain complet',
                      quantity: 2,
                      unit: 'tranches',
                    ),
                    Ingredient(
                      id: 'i11',
                      name: 'Avocat',
                      quantity: 1,
                      unit: 'pièce',
                    ),
                    Ingredient(
                      id: 'i12',
                      name: 'Œufs',
                      quantity: 2,
                      unit: 'pièces',
                    ),
                  ],
                ),
              ],
            ),
            Meal(
              id: 'm5',
              name: 'Déjeuner',
              recipes: [
                Recipe(
                  id: 'r5',
                  name: 'Curry de légumes',
                  ingredients: [
                    Ingredient(
                      id: 'i13',
                      name: 'Lentilles corail',
                      quantity: 150,
                      unit: 'g',
                    ),
                    Ingredient(
                      id: 'i14',
                      name: 'Lait de coco',
                      quantity: 200,
                      unit: 'ml',
                    ),
                    Ingredient(
                      id: 'i15',
                      name: 'Curry en poudre',
                      quantity: 2,
                      unit: 'càc',
                    ),
                  ],
                ),
              ],
            ),
          ],
          recipes: [],
        ),
      ],
    ),
  ];

  static List<ShoppingItem> shoppingList = [
    ShoppingItem(
      id: 'si1',
      name: 'Flocons d\'avoine',
      quantity: 50,
      unit: 'g',
      isChecked: false,
    ),
    ShoppingItem(
      id: 'si2',
      name: 'Lait d\'amande',
      quantity: 200,
      unit: 'ml',
      isChecked: false,
    ),
    ShoppingItem(
      id: 'si3',
      name: 'Fruits rouges',
      quantity: 100,
      unit: 'g',
      isChecked: true,
    ),
    // ... autres items de la liste de courses générés à partir des ingrédients
  ];
}
