import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_journey/features/auth/screens/login_screen.dart';

// import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart'
//     as streamSdk;

class FlutterFireAuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut(context) async {
    await _firebaseAuth.signOut();
    // await streamSdk.StreamChatCore.of(context).client.disconnectUser();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  Future<UserCredential?> signIn(
      {required String email, required String password, required BuildContext context}) async {
    try {
      UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      } else {
        print('Failed to sign in: $e');
      }
      final snakBar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snakBar);
    }

    return null;
  }

  Future<UserCredential?> signUp(
      {required String email, required String password, required BuildContext context}) async {
    try {
      var user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      return user;
    } on FirebaseAuthException catch (e) {
      final snakBar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snakBar);
    }
    return null;
  }
}
