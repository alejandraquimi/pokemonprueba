// import 'package:pokemon_app/providers/bodega_provider.dart';
import 'package:pokemon_app/screens/home/home_controller.dart';

import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    // Get.put(BodegaProvider(Get.find()));
  }
}
