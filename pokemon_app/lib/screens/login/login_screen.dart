import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_app/routes/app_page.dart';
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _SignInPage1State();
}

class _SignInPage1State extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  final LoginController controller = Get.put(LoginController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, dynamic> _datosobtenidos = {
    'username': '',
    'password': '',
  };

  @override
  void initState() {
    super.initState();
    resetFields();
  }

  void resetFields() {
    setState(() {
      _datosobtenidos['username'] = '';
      _datosobtenidos['password'] = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Card(
            elevation: 8,
            child: Container(
              padding: const EdgeInsets.all(32.0),
              constraints: const BoxConstraints(maxWidth: 350),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person_pin, color: Colors.blue, size: 100),
                    _gap(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Bienvenido",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Ingrese su usuario y contraseña para continuar.",
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese texto';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _datosobtenidos['username'] = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Usuario',
                        hintText: 'Ingrese Usuario',
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese contraseña';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _datosobtenidos['password'] = value;
                        });
                      },
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        hintText: 'Ingrese contraseña',
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () async {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    _gap(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Ingresar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            final username = _datosobtenidos["username"];
                            final password = _datosobtenidos["password"];
                            bool success =
                                await controller.login(username, password);
                            if (success) {
                              Get.rootDelegate.toNamed(Routes.HOME);
                            } else {
                              Get.snackbar("Error", "Credenciales incorrectas");
                            }
                          }
                        },
                      ),
                    ),
                    _gap(),
                    TextButton(
                      onPressed: () {
                        Get.rootDelegate.toNamed(Routes.USER);
                      },
                      child: const Text(
                        'Crear usuario',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
