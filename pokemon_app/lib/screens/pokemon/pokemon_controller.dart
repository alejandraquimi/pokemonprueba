import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pokemon_app/models/pokemon.dart';
import 'package:pokemon_app/providers/pokemon_provider.dart';
import 'package:pokemon_app/providers/user_provider.dart';
import 'package:pokemon_app/screens/login/login_controller.dart';

class PokemonController extends GetxController {
  Rxn<Pokemon> pokemonSelected = Rxn<Pokemon>();

  List<String> evolutionChain = [];
  int currentEvolutionIndex = 0;

  @override
  void onInit() {
    obtenerPokemon();
    super.onInit();
  }

  void obtenerPokemon() {
    final arguments = Get.rootDelegate.arguments();
    if (arguments != null) {
      pokemonSelected.value = arguments as Pokemon?;
      if (pokemonSelected.value?.id != null) {
        loadEvolutionChain(pokemonSelected.value!.id!);
      }
    }
  }

  Future<void> loadEvolutionChain(int pokemonId) async {
    final pokemonProvider = Get.find<PokemonProvider>();
    final evolutionData = await pokemonProvider.fetchEvolutionChain(pokemonId);
    if (evolutionData != null) {
      processEvolutionChain(evolutionData);
    }
    currentEvolutionIndex = 0;
  }

  void processEvolutionChain(Map<String, dynamic> evolutionData) {
    evolutionChain.clear();
    var chain = evolutionData['chain'];

    evolutionChain.add(chain['species']['name']);

    while (chain['evolves_to'].isNotEmpty) {
      chain = chain['evolves_to'][0];
      evolutionChain.add(chain['species']['name']);
    }

    print('Cadena evolutiva: $evolutionChain');
  }

  String? getNextEvolution() {
    if (currentEvolutionIndex + 1 < evolutionChain.length) {
      currentEvolutionIndex = currentEvolutionIndex + 1;
      return evolutionChain[currentEvolutionIndex];
    } else {
      return null;
    }
  }

  Future<void> evolucionarPokemon() async {
    final nextEvolution = getNextEvolution();
    if (nextEvolution != null) {
      pokemonSelected.value =
          pokemonSelected.value?.copyWith(name: nextEvolution);
      final pokemonProvider = Get.find<PokemonProvider>();
      pokemonSelected.value =
          await pokemonProvider.getSinglePokemon(nextEvolution);
    } else {
      Get.snackbar('Evolución', 'Este Pokémon ya no puede evolucionar más.');
    }
  }

  Future<void> savePokemon() async {
    final body = {
      "id": pokemonSelected.value?.id,
      "name": pokemonSelected.value?.name,
      "url": pokemonSelected.value?.url,
    };
    final userProvider = Get.find<UserProvider>();
    await userProvider.addPokemon(body);
  }
}
