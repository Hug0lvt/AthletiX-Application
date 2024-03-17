import 'package:AthletiX/model/authentification/login/login.dart';
import 'package:AthletiX/model/authentification/login/loginResponse.dart';
import 'package:AthletiX/model/authentification/login/refresh.dart';
import 'package:AthletiX/model/authentification/register.dart';
import 'package:AthletiX/model/errors/error.dart';
import 'package:http/http.dart' as http;

class AuthClientApi {
  final String _baseUrl;

  AuthClientApi(this._baseUrl);

  Future<LoginResponse> login(Login identifiers) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: loginToJson(identifiers),
    );
    if (response.statusCode == 200) {
      return loginResponseFromJson(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<bool> register(Register identifiers) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: registerToJson(identifiers),
    );
    switch (response.statusCode) {
      case 200:
        return true;
      case 400:
        throw Exception(errorFromJson(response.body).errors.entries.first);
      default:
        throw Exception('Failed to delete data');
    }
  }

  Future<LoginResponse> refreshToken(Refresh token) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/refresh'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: refreshToJson(token)
    );
    if (response.statusCode == 200) {
      return loginResponseFromJson(response.body);
    } else {
      throw Exception('Failed to refresh token');
    }
  }
}