import 'dart:convert';
import 'package:AthletiX/exceptions/not_found_exception.dart';
import 'package:AthletiX/providers/localstorage/secure/authKeys.dart';
import 'package:AthletiX/providers/localstorage/secure/authManager.dart';
import 'package:http/http.dart' as http;

import '../../model/authentification/login/loginResponse.dart';
import '../../model/authentification/login/refresh.dart';
import '../exceptions/unauthorized_exception.dart';
import 'utils/authClientApi.dart';

class ClientApi {
  late final String _baseUrl;
  late final AuthClientApi authClientApi;

  ClientApi(String baseUriApi, String baseUriAuth){
    _baseUrl = baseUriApi;
    authClientApi = AuthClientApi(baseUriAuth);
  }

  Future<Map<String, String>> _buildHeaders() async {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    String? token = await AuthManager.getToken(AuthKeys.ATH_BEARER_TOKEN_API.name);
    String? refreshToken = await AuthManager.getToken(AuthKeys.ATH_BEARER_REFRESH_TOKEN_API.name);
    DateTime? expireAt = DateTime.tryParse(await AuthManager.getToken(AuthKeys.ATH_END_OF_BEARER_TOKEN_API.name) ?? "");
    if(token != null && refreshToken != null){
      if(expireAt != null && expireAt.isBefore(DateTime.now())){
        try {
          LoginResponse loginResponse = await authClientApi.refreshToken(Refresh(refreshToken: refreshToken));
          await AuthManager.setToken(AuthKeys.ATH_BEARER_TOKEN_API.name, loginResponse.accessToken);
          await AuthManager.setToken(AuthKeys.ATH_BEARER_REFRESH_TOKEN_API.name, loginResponse.refreshToken);
          await AuthManager.setToken(AuthKeys.ATH_END_OF_BEARER_TOKEN_API.name, DateTime.now().add(const Duration(seconds: 3500)).toString());
        } catch (ignored) {}
      }
    }

    final validToken = await AuthManager.getToken(AuthKeys.ATH_BEARER_TOKEN_API.name);
    if (token != null) {
      headers['Authorization'] = 'Bearer $validToken';
    }
    return headers;
  }

  Future<String> getData(String endpoint) async {
    final headers = await _buildHeaders();
    final response = await http.get(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: headers,
    );

    switch (response.statusCode) {
      case 200:
        return response.body;
      case 401:
        throw UnauthorizedException('Unauthorized');
      case 404:
        throw NotFoundException('Not Found');
      default:
        throw Exception('Failed to load data');
    }
  }

  Future<String> getDataById(String endpoint, int id) async {
    final headers = await _buildHeaders();
    final response = await http.get(
      Uri.parse('$_baseUrl/$endpoint/$id'),
      headers: headers,
    );

    switch (response.statusCode) {
      case 200:
        return response.body;
      case 401:
        throw UnauthorizedException('Unauthorized');
      case 404:
        throw NotFoundException('Not Found');
      default:
        throw Exception('Failed to load data');
    }
  }

  Future<String> postData(String endpoint, String data) async {
    final headers = await _buildHeaders();
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: headers,
      body: data,
    );

    switch (response.statusCode) {
      case 200:
      case 201:
        return response.body;
      case 401:
        throw UnauthorizedException('Unauthorized');
      case 404:
        throw NotFoundException('Not Found');
      default:
        throw Exception('Failed to post data');
    }
  }

  Future<String> putData(String endpoint, String data) async {
    final headers = await _buildHeaders();
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: headers,
      body: data,
    );

    switch (response.statusCode) {
      case 200:
        return response.body;
      case 401:
        throw UnauthorizedException('Unauthorized');
      case 404:
        throw NotFoundException('Not Found');
      default:
        throw Exception('Failed to put data');
    }
  }

  Future<String> deleteData(String endpoint) async {
    final headers = await _buildHeaders();
    final response = await http.delete(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: headers
    );

    switch (response.statusCode) {
      case 200:
        return response.body;
      case 401:
        throw UnauthorizedException('Unauthorized');
      case 404:
        throw NotFoundException('Not Found');
      default:
        throw Exception('Failed to delete data');
    }
  }

  Future<String> patchData(String endpoint, String data) async {
    final headers = await _buildHeaders();
    final response = await http.patch(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: headers,
      body: data,
    );

    switch (response.statusCode) {
      case 200:
        return response.body;
      case 401:
        throw UnauthorizedException('Unauthorized');
      case 404:
        throw NotFoundException('Not Found');
      default:
        throw Exception('Failed to patch data');
    }
  }

}
