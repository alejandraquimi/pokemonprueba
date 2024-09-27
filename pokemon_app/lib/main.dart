import 'dart:io';
import 'package:pokemon_app/app_binding.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:pokemon_app/routes/app_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    HttpOverrides.global = MyHttpOverrides();
  }

  await dotenv.load(fileName: ".env");

  Logger.level = Level.debug;

  runApp(GetMaterialApp.router(
    debugShowCheckedModeBanner: false,
    title: 'Pokemon',
    getPages: AppPages.pages,
    initialBinding: AppBinding(),
  ));
}
