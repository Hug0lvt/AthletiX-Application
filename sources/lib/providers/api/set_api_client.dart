import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../exceptions/not_found_exception.dart';
import 'api_client.dart';
import '../../model/set.dart';

mixin SetApiClient on ApiClient {

  Future<Set> createSet(Set set) async {
    final response = await http.post(
      Uri.parse('$baseUrl/sets'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(set.toJson()),
    );

    switch (response.statusCode) {
      case 201:
        return Set.fromJson(json.decode(response.body));
      default:
        throw Exception('Failed to create set');
    }
  }

  Future<List<Set>> getAllSets() async {
    final response = await http.get(Uri.parse('$baseUrl/sets'));

    switch (response.statusCode) {
      case 200:
        List<dynamic> setsJson = json.decode(response.body);
        return setsJson.map((json) => Set.fromJson(json)).toList();
      default:
        throw Exception('Failed to fetch sets');
    }
  }

  Future<Set> getSetById(int setId) async {
    final response = await http.get(Uri.parse('$baseUrl/sets/$setId'));

    switch (response.statusCode) {
      case 200:
        return Set.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Set not found');
      default:
        throw Exception('Failed to fetch set');
    }
  }

  Future<Set> updateSet(int setId, Set updatedSet) async {
    final response = await http.put(
      Uri.parse('$baseUrl/sets/$setId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedSet.toJson()),
    );

    switch (response.statusCode) {
      case 200:
        return Set.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Set not found');
      default:
        throw Exception('Failed to update set');
    }
  }

  Future<Set> deleteSet(int setId) async {
    final response = await http.delete(Uri.parse('$baseUrl/sets/$setId'));

    switch (response.statusCode) {
      case 200:
        return Set.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Set not found');
      default:
        throw Exception('Failed to delete set');
    }
  }
}
