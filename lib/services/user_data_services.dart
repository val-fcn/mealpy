import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataService {
  Future<void> createUserData({
    required String? userId,
    required String email,
    required String username,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'email': email,
      'username': username,
    });
  }
}
