import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/menu.dart';

class MenuService {
  final CollectionReference _menusCollection =
      FirebaseFirestore.instance.collection('menus');

  // Normaliser la date (garder uniquement année-mois-jour)
  String _normalizeDate(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day)
        .toIso8601String()
        .split('T')[0];
    return normalized;
  }

  // Créer un nouveau menu
  Future<void> createMenu(String userId, Menu menu) async {
    try {
      final normalizedDate = _normalizeDate(menu.date);
      await _menusCollection.doc(menu.id).set({
        ...menu.toJson(),
        'userId': userId,
        'normalizedDate': normalizedDate,
      });
    } catch (e) {
      throw Exception('Erreur lors de la création du menu: $e');
    }
  }

  // Supprimer un menu
  Future<void> deleteMenu(String userId, String menuId) async {
    try {
      // Vérifier que le menu appartient bien à l'utilisateur
      DocumentSnapshot doc = await _menusCollection.doc(menuId).get();
      if (doc.exists &&
          (doc.data() as Map<String, dynamic>)['userId'] == userId) {
        await _menusCollection.doc(menuId).delete();
      } else {
        throw Exception('Menu non trouvé ou non autorisé');
      }
    } catch (e) {
      throw Exception('Erreur lors de la suppression du menu: $e');
    }
  }

  // Mettre à jour un menu
  Future<void> updateMenu(String userId, Menu menu) async {
    try {
      // Vérifier que le menu appartient bien à l'utilisateur
      DocumentSnapshot doc = await _menusCollection.doc(menu.id).get();
      if (doc.exists &&
          (doc.data() as Map<String, dynamic>)['userId'] == userId) {
        await _menusCollection.doc(menu.id).update(menu.toJson());
      } else {
        throw Exception('Menu non trouvé ou non autorisé');
      }
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour du menu: $e');
    }
  }

  // Récupérer tous les menus d'un utilisateur
  Future<List<Menu>> getAllMenus(String userId) async {
    try {
      QuerySnapshot querySnapshot =
          await _menusCollection.where('userId', isEqualTo: userId).get();

      return querySnapshot.docs
          .map((doc) => Menu.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des menus: $e');
    }
  }

  // Récupérer un menu par son ID
  Future<Menu?> getMenuById(String userId, String menuId) async {
    try {
      DocumentSnapshot doc = await _menusCollection.doc(menuId).get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        // Vérifier que le menu appartient à l'utilisateur
        if (data['userId'] == userId) {
          return Menu.fromJson(data);
        }
      }
      return null;
    } catch (e) {
      throw Exception('Erreur lors de la récupération du menu: $e');
    }
  }

  // Récupérer le menu pour une date spécifique
  Future<Menu?> getMenuForDate(String userId, DateTime date) async {
    try {
      final normalizedDate = _normalizeDate(date);

      print('Recherche avec les paramètres suivants:'); // Debug
      print('userId: $userId');
      print('normalizedDate: $normalizedDate');

      // Modification de la requête pour utiliser l'index correctement
      final QuerySnapshot querySnapshot = await _menusCollection
          .where('userId', isEqualTo: userId)
          .where('normalizedDate', isEqualTo: normalizedDate)
          .limit(1) // Limite à 1 résultat
          .get();

      print('Documents trouvés: ${querySnapshot.docs.length}'); // Debug

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
        print('Document trouvé: $data'); // Debug
        return Menu.fromJson(data);
      }

      print('Aucun menu trouvé pour cette date'); // Debug
      return null;
    } catch (e, stackTrace) {
      print('Erreur complète:'); // Debug
      print(e);
      print(stackTrace);
      throw Exception('Erreur lors de la récupération du menu du jour: $e');
    }
  }

  // Récupérer les menus pour une période donnée
  Future<List<Menu>> getMenusForDateRange(
      String userId, DateTime start, DateTime end) async {
    try {
      final startDate = _normalizeDate(start);
      final endDate = _normalizeDate(end);

      print('Recherche des menus entre $startDate et $endDate'); // Debug

      QuerySnapshot querySnapshot = await _menusCollection
          .where('userId', isEqualTo: userId)
          .where('normalizedDate', isGreaterThanOrEqualTo: startDate)
          .where('normalizedDate', isLessThanOrEqualTo: endDate)
          .get();

      return querySnapshot.docs
          .map((doc) => Menu.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Erreur dans getMenusForDateRange: $e');
      throw Exception('Erreur lors de la récupération des menus par date: $e');
    }
  }

  // Récupérer les menus pour un mois spécifique
  Future<List<Menu>> getMenusForMonth(
      String userId, int year, int month) async {
    try {
      DateTime startDate = DateTime(year, month, 1);
      DateTime endDate = DateTime(year, month + 1, 0);

      return await getMenusForDateRange(userId, startDate, endDate);
    } catch (e) {
      throw Exception('Erreur lors de la récupération des menus du mois: $e');
    }
  }
}
