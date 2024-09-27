import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:pokemon_app/models/pokemon.dart';
import 'package:pokemon_app/screens/login/login_controller.dart';

class UserProvider {
  final logger = Logger();
  Dio dio = Dio();
  final String url = "http://192.168.1.221:5000";

  Future<void> createUser(body) async {
    try {
      final response = await dio.post(
        "$url/user/register",
        data: jsonEncode(body), // Cuerpo de la solicitud en formato JSON
        options: Options(headers: {
          "Content-Type": "application/json",
        }),
      );
      if (response.statusCode == 201) {
        Get.snackbar('Éxito', 'Usuario creado exitosamente');
      } else {
        Get.snackbar('Error', 'No se pudo crear el usuario');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error de conexión');
    }
  }

  final storage = GetStorage();

  Future<bool> addPokemon(body) async {
    String? token = storage.read('token');

    if (token == null) {
      Get.snackbar('Error', 'Usuario no autenticado');
      return false;
    }

    try {
      final response = await dio.post(
        "$url/pokemon/add_pokemon",
        data: jsonEncode(body),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Éxito", "Pokemon agregado correctamente");
        return true;
      } else {
        Get.snackbar("Error", "No se pudo agregar el pokemon");
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "Hubo un problema al agregar el pokemon");
      return false;
    }
  }

  Future<List<Pokemon>> getPokemons() async {
    String? token = storage.read('token');
    if (token == null) {
      Get.snackbar('Error', 'Usuario no autenticado');
      return [];
    }

    try {
      final response = await dio.get(
        "$url/pokemon/pokemons",
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['pokemons'];

        return data.map((pokemon) => Pokemon.fromJson(pokemon)).toList();
      }
    } catch (e) {
      Get.snackbar("Error", "Hubo un problema al agregar el pokemon");
      return [];
    }
    return [];
  }
}
