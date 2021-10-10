import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_code/consts/firebase_const.dart';
import 'package:flutter_default_code/screens/auth/auth_services/auth_services.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthServices _authService = AuthServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loginWithEmailPassword(
      {required String email, required String password}) async {
    _isLoading = true;
    await _authService.loginUser(email: email, password: password);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> createUserWithEmailPassword(
      {required String emailAddress,
      required String password,
      required File pickedImage,
      required String fullName,
      required int phoneNumber,
      required String joinedAt}) async {
    _isLoading = true;
    final ref = FirebaseStorage.instance
        .ref()
        .child(FirebaseStorageConst.usersImage)
        .child(fullName + '.jpg');
    await ref.putFile(pickedImage);
    String url = await ref.getDownloadURL();
    await _authService.createUser(email: emailAddress, password: password);
    final User? user = _auth.currentUser;
    if (user != null) {
      user.updatePhotoURL(url);
      user.updateDisplayName(fullName);
      user.reload();
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionConst.usersCollection)
          .doc(user.uid)
          .set({
        'id': user.uid,
        'name': fullName,
        'email': emailAddress,
        'phoneNumber': phoneNumber,
        'imageUrl': url,
        'joinedAt': joinedAt,
        'createdAt': Timestamp.now()
      });
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> forgotPasswordWithEmail(
      {required String email}) async {
    _isLoading = true;
    await _authService.forgotPassword(email: email);
    _isLoading = false;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
