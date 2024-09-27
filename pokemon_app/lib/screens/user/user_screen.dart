import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_controller.dart';

class UserScreen extends GetView<UserController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.usernameController,
                decoration: InputDecoration(labelText: 'Usuario'),
                validator: (value) {
                  return controller.validateUsername(value!);
                },
                onChanged: (value) {
                  controller.username.value = value;
                },
              ),
              SizedBox(height: 20),
              Obx(() => TextFormField(
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          controller.togglePasswordVisibility();
                        },
                      ),
                    ),
                    obscureText: !controller.isPasswordVisible.value,
                    validator: (value) {
                      return controller.validatePassword(value!);
                    },
                    onChanged: (value) {
                      controller.password.value = value;
                    },
                  )),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    controller.createUser();
                  }
                },
                child: Text('Crear Usuario'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
