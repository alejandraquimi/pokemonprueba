import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginController extends GetxController {
  final Dio _dio = Dio();
  final storage = GetStorage();
  RxBool isLoggedIn = false.obs;
  RxString token = ''.obs;
  RxString userId = ''.obs;
  RxString username = ''.obs;

  final String loginUrl = "http://192.168.0.129:5000/user/login";
  Future<bool> login(String username, String password) async {
    try {
      final response = await _dio.post(
        loginUrl,
        data: {
          "username": username,
          "password": password,
        },
        options: Options(headers: {
          "Content-Type": "application/json",
        }),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        token.value = data['access_token'];
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token.value);
        userId.value = decodedToken['id'].toString();
        this.username.value = decodedToken['username'];

        await storage.write('token', token.value);
        await storage.write('userId', userId.value);
        await storage.write('username', this.username.value);

        isLoggedIn.value = true;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    await storage.remove('token');
    await storage.remove('userId');
    await storage.remove('username');
    token.value = '';
    userId.value = '';
    username.value = '';
    isLoggedIn.value = false;
  }

  String? getStoredToken() {
    return storage.read('token');
  }
}
