// import 'package:flutter/material.dart';

// import '../models/menu.dart';
// import '../data/planning_dummy_data.dart';

// class ShoppingList extends StatefulWidget {
//   const ShoppingList({super.key});

//   @override
//   State<ShoppingList> createState() => _ShoppingListState();
// }

// class _ShoppingListState extends State<ShoppingList> {
//   late List<ShoppingItem> _shoppingList;

//   @override
//   void initState() {
//     super.initState();
//     _shoppingList = PlanningDummyData.shoppingList;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: _shoppingList.length,
//       itemBuilder: (context, index) {
//         final shoppingItem = _shoppingList[index];
//         return ListTile(
//           title: Text(shoppingItem.name),
//         );
//       },
//     );
//   }
// }
