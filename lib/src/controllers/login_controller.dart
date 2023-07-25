import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test_beed/src/pages/landing_page.dart';
import 'package:flutter_test_beed/src/pages/login_page.dart';
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
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(msg: 'No internet connection.');
      return;
    }
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
      await saveLoginSession();

      isLoading.value = false;
      UserModel user = UserModel(
          id: userCredential.user!.uid, email: userCredential.user!.email!);
      Get.offAll(LandingPage());
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

  Future<void> signOutUser() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(msg: 'No internet connection.');
      return;
    }
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(LoginPage());
      Fluttertoast.showToast(msg: 'Sign-out successful');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error occurred during sign-out');
      print(e);
    }
  }

  Future<void> saveLoginSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }

  Future<void> deleteLoginSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
  }
}
