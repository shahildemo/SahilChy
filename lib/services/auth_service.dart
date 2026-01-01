
import 'dart:developer' as developer;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:futsal_finder/models/user_model.dart';
import 'package:futsal_finder/services/database_service.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth;
  UserModel? _user;

  AuthService({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  UserModel? get user => _user;

  Stream<UserModel?> get userStream {
    return _auth.authStateChanges().asyncMap((user) async {
      if (user != null) {
        return await DatabaseService(uid: user.uid).user.first;
      }
      return null;
    });
  }

  Future<void> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = await DatabaseService(uid: result.user!.uid).user.first;
      notifyListeners();
    } catch (e) {
      developer.log('Sign-in error: $e', name: 'AuthService', error: e);
      rethrow;
    }
  }

  Future<void> signUp(String email, String password, String displayName, String role) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await result.user!.updateDisplayName(displayName);
      await DatabaseService(uid: result.user!.uid).updateUserData(displayName, email, role);
      _user = UserModel(uid: result.user!.uid, email: email, displayName: displayName, role: role);
      notifyListeners();
    } catch (e) {
      developer.log('Sign-up error: $e', name: 'AuthService', error: e);
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }
}
