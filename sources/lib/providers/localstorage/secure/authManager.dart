import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthManager {
  static final _storage = FlutterSecureStorage();

  static Future<String?> getToken(String key) async {
    return await _storage.read(key: key);
  }

  static Future<void> setToken(String key, String token) async {
    await _storage.write(key: key, value: token);
  }
}