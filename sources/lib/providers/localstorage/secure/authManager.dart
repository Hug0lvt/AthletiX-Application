import 'package:AthletiX/model/profile.dart';
import 'package:AthletiX/providers/localstorage/secure/authKeys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthManager {
  static final _storage = FlutterSecureStorage();

  static Future<String?> getToken(String key) async {
    return await _storage.read(key: key);
  }

  static Future<void> setToken(String key, String token) async {
    await _storage.write(key: key, value: token);
  }

  static Future<Profile?> getProfile() async {
    String? profileJson = await _storage.read(key: AuthKeys.ATH_PROFILE.name);
    if (profileJson != null) {
      return profileFromJson(profileJson);
    } else {
      return null;
    }
  }


  static Future<void> setProfile(Profile profile) async {
    await _storage.write(key: AuthKeys.ATH_PROFILE.name, value: profileToJson(profile));
  }
}