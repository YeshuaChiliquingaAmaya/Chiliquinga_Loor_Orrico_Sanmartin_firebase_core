// lib/repositories/user_repository.dart
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../models/user_profile.dart';

class UserRepository {
  final AuthService _authService;
  final FirestoreService _firestoreService;

  UserRepository(this._authService, this._firestoreService);

  Stream<User?> get currentUser => _authService.user;

  Future<User?> register(String email, String password) async {
    User? user = await _authService.registerWithEmailAndPassword(email, password);
    if (user != null) {
      await _firestoreService.createUserProfile(user.uid, {'email': email, 'name': '', 'address': '', 'phone': ''});
    }
    return user;
  }

  Future<User?> signIn(String email, String password) async {
    return await _authService.signInWithEmailAndPassword(email, password);
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  Stream<UserProfile?> getUserProfile(String userId) {
    return _firestoreService.getUserProfile(userId);
  }

  Future<void> updateUserProfile(String userId, Map<String, dynamic> data) async {
    await _firestoreService.updateUserProfile(userId, data);
  }
}