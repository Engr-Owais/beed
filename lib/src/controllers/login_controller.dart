import 'package:flutter_test_beed/src/pages/home_page.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/user_model.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final RxString email = ''.obs;
  final RxString password = ''.obs;
  final RxBool isLoading = false.obs;

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  Future<void> loginUser() async {
    if (!GetUtils.isEmail(email.value) || password.value.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill all fields correctly.');
      return;
    }

    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      await saveLoginSession(
          userCredential.user!.uid, userCredential.user!.email!);

      isLoading.value = false;
      UserModel user = UserModel(
          id: userCredential.user!.uid, email: userCredential.user!.email!);
      Get.offAll(HomePage());
      print('Login successful: ${user.id}');
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided.');
      } else {
        Fluttertoast.showToast(msg: 'Error: ${e.message}');
      }
    }
  }

  Future<void> saveLoginSession(String userId, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
    prefs.setString('userId', userId);
    prefs.setString('email', email);
  }
}
