import 'package:get/get.dart';
import 'package:pokemon_app/screens/home/home_binding.dart';
import 'package:pokemon_app/screens/home/home_screen.dart';
import 'package:pokemon_app/screens/login/login_binding.dart';
import 'package:pokemon_app/screens/login/login_screen.dart';
import 'package:pokemon_app/screens/pokemon/pokemon_binding.dart';
import 'package:pokemon_app/screens/pokemon/pokemon_screen.dart';
import 'package:pokemon_app/screens/user/user_binding.dart';
import 'package:pokemon_app/screens/user/user_screen.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.LOGIN;

  static final List<GetPage> pages = [
    // GetPage(
    //   name: _Paths.SPLASH,
    //   page: () => const SplashScreen(),
    //   binding: SplashBinding(),
    // ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.USER,
      page: () => UserScreen(),
      binding: UserBinding(),
    ),
    GetPage(
      name: _Paths.POKEMON,
      page: () => const PokemonScreen(),
      binding: PokemonBinding(),
    ),
  ];
}
