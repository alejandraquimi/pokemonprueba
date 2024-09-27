import 'package:get/get.dart';
import 'package:pokemon_app/models/pokemon.dart';
import 'package:pokemon_app/providers/pokemon_provider.dart';
import 'package:pokemon_app/providers/user_provider.dart';
import 'package:pokemon_app/routes/app_page.dart';

class HomeController extends GetxController {
  final pokemons = RxList<Pokemon>([]);
  final pokemosFavorites = RxList<Pokemon>([]); // Lista de favoritos
  var showFavorites = false.obs;
  var isLoading =
      false.obs; // Variable de estado para manejar la carga de datos

  @override
  void onInit() {
    super.onInit();
    loadPokemos();
  }

  Future<void> toggleFavorites() async {
    if (isLoading.value)
      return; // Evitar llamadas múltiples si ya se está cargando
    isLoading.value = true;
    showFavorites.value = !showFavorites.value;

    if (showFavorites.value && pokemosFavorites.isEmpty) {
      // Solo cargar favoritos si no están ya cargados
      await getPokemos();
    }

    isLoading.value = false;
  }

  Future<void> loadPokemos() async {
    final pokemonProvider = Get.find<PokemonProvider>();
    pokemons.value = await pokemonProvider.getPokemons();
  }

  Future<void> getPokemos() async {
    final userProvider = Get.find<UserProvider>();
    pokemosFavorites.value = await userProvider.getPokemons();
  }

  Future<void> pokemonSend(Pokemon pokemon) async {
    try {
      Get.rootDelegate.toNamed(Routes.POKEMON, arguments: pokemon);
    } catch (e) {}
  }
}
