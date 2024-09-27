import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pokemon_app/models/pokemon.dart';

class PokemonProvider {
  final logger = Logger();
  Dio dio = Dio();
  final String url = "https://pokeapi.co/api/v2";

  Future<List<Pokemon>> getPokemons() async {
    final List<Pokemon> pokemonList = [];
    try {
      for (int i = 1; i <= 20; i++) {
        final response = await dio.get('$url/pokemon/$i');
        if (response.statusCode == 200) {
          var pokemon = Pokemon.fromJson(response.data);
          pokemonList.add(pokemon);
        }
      }
    } catch (e) {
      e.printError();
      Get.snackbar("Error", "No se pudo obtener los Pokemos");
    }

    return pokemonList;
  }

  Future<Pokemon> getSinglePokemon(String name) async {
    try {
      final response = await dio.get('$url/pokemon/$name');
      if (response.statusCode == 200) {
        final pokemon = Pokemon.fromJson(response.data);
        return pokemon;
      } else {
        throw Exception('Failed to load Pokemon');
      }
    } catch (e) {
      e.printError();
      Get.snackbar("Error", "No se pudo obtener los Pokemos");
      throw Exception('Failed to load Pokemon');
    }
  }

  Future<Map<String, dynamic>?> fetchEvolutionChain(int pokemonId) async {
    try {
      final speciesUrl = '$url/pokemon-species/$pokemonId/';
      final responseSpecies = await dio.get(speciesUrl);

      if (responseSpecies.statusCode == 200) {
        final evolutionChainUrl =
            responseSpecies.data['evolution_chain']['url'];

        final responseEvolution = await dio.get(evolutionChainUrl);

        if (responseEvolution.statusCode == 200) {
          return responseEvolution.data;
        } else {
          print(
              'Error al obtener la cadena evolutiva: ${responseEvolution.statusCode}');
        }
      } else {
        print(
            'Error al obtener los datos de la especie: ${responseSpecies.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud: $e');
    }
    return null;
  }
}
