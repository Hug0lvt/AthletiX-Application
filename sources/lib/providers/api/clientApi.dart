import 'dart:convert';
import 'package:AthletiX/providers/localstorage/secure/authKeys.dart';
import 'package:AthletiX/providers/localstorage/secure/authManager.dart';
import 'package:http/http.dart' as http;

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
    final token = await AuthManager.getToken(AuthKeys.ATH_BEARER_TOKEN_API.name);
    if (token != null) {
      headers['Authorization'] = token;
    }
    return headers;
  }

  Future<dynamic> getData(String endpoint) async {
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
      default:
        throw Exception('Failed to load data');
    }
  }

  Future<dynamic> getDataById(String endpoint, int id) async {
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
      default:
        throw Exception('Failed to load data');
    }
  }

  Future<dynamic> postData(String endpoint, String data) async {
    final headers = await _buildHeaders();
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: headers,
      body: data,
    );

    switch (response.statusCode) {
      case 201:
        return response.body;
      case 401:
        throw UnauthorizedException('Unauthorized');
      default:
        throw Exception('Failed to post data');
    }
  }

  Future<dynamic> putData(String endpoint, String data) async {
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
      default:
        throw Exception('Failed to put data');
    }
  }

  Future<dynamic> deleteData(String endpoint) async {
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
      default:
        throw Exception('Failed to delete data');
    }
  }

  Future<dynamic> patchData(String endpoint, String data) async {
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
      default:
        throw Exception('Failed to patch data');
    }
  }

}
