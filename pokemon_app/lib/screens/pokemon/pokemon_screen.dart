import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pokemon_controller.dart';

class PokemonScreen extends GetView<PokemonController> {
  const PokemonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Pokémon'),
      ),
      body: Obx(() {
        // Comprobar si `pokemonSelected` es null
        if (controller.pokemonSelected.value == null) {
          return const Center(
            child: Text('No se recibió el Pokémon.'),
          );
        }

        // Si `pokemonSelected` no es null, mostrar la información del Pokémon
        return Center(
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      controller.pokemonSelected.value?.url ?? "",
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Nombre: ${(controller.pokemonSelected.value?.name ?? "").capitalizeFirst ?? ""}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Tipos: ${controller.pokemonSelected.value?.types?.join(", ")}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Habilidades: ${controller.pokemonSelected.value?.abilities?.join(", ")}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  // Botón de Evolucionar
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        controller.evolucionarPokemon();
                      },
                      child: const Text('Evolucionar'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Botón de Guardar
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await controller.savePokemon();
                      },
                      child: const Text('Guardar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
