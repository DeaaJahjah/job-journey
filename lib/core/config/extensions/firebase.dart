import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

extension FirebaseContext on BuildContext {
  /// Get user token.
  String? get userToken => FirebaseAuth.instance.currentUser!.displayName;

  /// get user id
  String? get userUid => FirebaseAuth.instance.currentUser!.uid;

  /// get the current user
  User? get firebaseUser => FirebaseAuth.instance.currentUser;

  bool get isCompanyAccount => FirebaseAuth.instance.currentUser!.photoURL == 'company';
}
