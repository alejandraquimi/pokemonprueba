import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_app/providers/user_provider.dart';

class UserController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;

  var isPasswordVisible = false.obs;

  late TextEditingController usernameController;
  late TextEditingController passwordController;

  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  String? validateUsername(String value) {
    if (value.isEmpty) {
      return 'Por favor ingrese un usuario';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Por favor ingrese una contraseña';
    }
    return null;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> createUser() async {
    final body = {
      "username": username.value,
      "password": password.value,
    };
    final userProvider = Get.find<UserProvider>();
    await userProvider.createUser(body);
    username.value = '';
    password.value = '';
    usernameController.clear();
    passwordController.clear();
  }
}
