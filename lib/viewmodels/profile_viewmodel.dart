// lib/viewmodels/profile_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/user_repository.dart';
import '../models/user_profile.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  Stream<UserProfile?>? _userProfile;
  String? _currentUserId;

  ProfileViewModel(this._userRepository) {
    _userRepository.currentUser.listen((user) {
      if (user != null) {
        _currentUserId = user.uid;
        _userProfile = _userRepository.getUserProfile(user.uid);
        notifyListeners();
      } else {
        _currentUserId = null;
        _userProfile = Stream.value(null);
        notifyListeners();
      }
    });
  }

  Stream<UserProfile?>? get userProfile => _userProfile;
  String? get currentUserId => _currentUserId;

  Future<bool> updateProfile(String name, String address, String phone) async {
    if (_currentUserId == null) return false;
    try {
      await _userRepository.updateUserProfile(_currentUserId!, {
        'name': name,
        'address': address,
        'phone': phone,
      });
      return true;
    } catch (e) {
      print('Error al actualizar perfil: ${e.toString()}');
      return false;
    }
  }
}