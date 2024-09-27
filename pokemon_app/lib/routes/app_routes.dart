// ignore_for_file: constant_identifier_names

part of 'app_page.dart';

abstract class Routes {
  Routes._();

  static const LOGIN = _Paths.LOGIN;

  static const HOME = _Paths.HOME;
  static const USER = _Paths.USER;

  static const POKEMON = _Paths.POKEMON;
}

abstract class _Paths {
  _Paths._();
  static const LOGIN = '/login';
  static const HOME = '/home';
  static const USER = '/user';

  static const POKEMON = '/pokemon';
}
