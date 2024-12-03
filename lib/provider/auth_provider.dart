import 'package:flutter/material.dart';
import 'package:chatbot_agents/models/user.dart';
import 'package:chatbot_agents/di/get_it_instance.dart';

import '../service/auth_service.dart';
import '../service/user_service.dart';

class AuthProvider with ChangeNotifier {
  late final AuthService _authService = GetItInstance.getIt<AuthService>();
  late final UserService _userService = GetItInstance.getIt<UserService>();

  bool _isAuthenticated = false;
  User? _user;

  bool get isAuthenticated => _isAuthenticated;
  User? get user => _user;

  // Register user
  Future<String?> register(String email, String password, String username) {
    return _authService.register(email, password, username);
  }

  // Login user and fetch their data
  Future<String?> login(String email, String password) async {
    final error = await _authService.login(email, password);
    if (error == null) {
      _user = await _userService.fetchCurrentUser();
      if (_user != null ) {
        _isAuthenticated = true;
      }
      notifyListeners();
    }
    return error;
  }

  Future<String?> googleLogin() async {
    final error = await _authService.googleLogin();
    if (error == null) {
      _user = await _userService.fetchCurrentUser();
      if (_user != null ) {
        _isAuthenticated = true;
      }
      notifyListeners();
    }
    return error;
  }

  // Logout user
  Future<void> logout() async {
    await _authService.logout();
    _isAuthenticated = false;
    _user = null; // Clear user data
    notifyListeners();
  }
}
