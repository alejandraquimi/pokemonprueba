import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_controller.dart'; // Importar el controlador

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
              // Campo de entrada de Usuario
              TextFormField(
                controller:
                    controller.usernameController, // Usar TextEditingController
                decoration: InputDecoration(labelText: 'Usuario'),
                validator: (value) {
                  return controller.validateUsername(value!);
                },
                onChanged: (value) {
                  controller.username.value =
                      value; // Actualiza el valor en el controlador
                },
              ),
              SizedBox(height: 20),

              // Campo de entrada de Contraseña con "ojito"
              Obx(() => TextFormField(
                    controller: controller
                        .passwordController, // Usar TextEditingController
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

              // Botón para crear el usuario
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
