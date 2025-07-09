// lib/viewmodels/home_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/user_repository.dart';
import '../models/user_profile.dart';

class HomeViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  HomeViewModel(this._userRepository);

  Stream<User?> get currentUser => _userRepository.currentUser;

  Future<void> signOut() async {
    await _userRepository.signOut();
  }

  Stream<UserProfile?> getUserProfile(String userId) {
    return _userRepository.getUserProfile(userId);
  }
}
