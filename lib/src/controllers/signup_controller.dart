import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test_beed/src/pages/login_page.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../data/models/user_model.dart';

class SignupController extends GetxController {
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

  Future<void> signupUser() async {
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
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      isLoading.value = false;
      UserModel user = UserModel(
          id: userCredential.user!.uid, email: userCredential.user!.email!);
      Get.to(LoginPage());
      print('Signup successful: ${user.id}');
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'Email is already in use.');
      } else {
        Fluttertoast.showToast(msg: 'Error: ${e.message}');
      }
    }
  }
}
