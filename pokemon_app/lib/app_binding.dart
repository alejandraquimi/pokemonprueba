import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/instance_manager.dart';
import 'package:pokemon_app/providers/pokemon_provider.dart';
import 'package:pokemon_app/providers/user_provider.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    //Get.put(GlobalData(const FlutterSecureStorage()), permanent: true);
    Get.put(PokemonProvider(), permanent: true);
    Get.put(UserProvider(), permanent: true);
  }
}
