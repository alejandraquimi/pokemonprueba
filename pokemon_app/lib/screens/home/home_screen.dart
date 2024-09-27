import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_app/screens/home/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return controller.showFavorites.value
              ? Text('Mis Favoritos')
              : Text('Lista de Pokémon');
        }),
        actions: [
          Obx(() {
            return controller.isLoading.value
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () async {
                      await controller.toggleFavorites();
                    },
                  );
          }),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final currentList = controller.showFavorites.value
            ? controller.pokemosFavorites
            : controller.pokemons;

        if (currentList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: currentList.length,
          itemBuilder: (context, index) {
            final pokemon = currentList[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Container(
                height: 90,
                padding: const EdgeInsets.all(20),
                child: ListTile(
                  leading: Image.network(
                    pokemon.url ?? "",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    pokemon.name ?? "",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    controller.pokemonSend(pokemon);
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
