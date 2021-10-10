import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser(
      {required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUser(
      {required String email, required String password}) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}
