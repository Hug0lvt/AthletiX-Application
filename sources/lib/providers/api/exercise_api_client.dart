import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../exceptions/not_found_exception.dart';
import '../../model/exercise.dart';
import 'api_client.dart';

mixin ExerciseApiClient on ApiClient {

  Future<Exercise> createExercise(Exercise exercise) async {
    final response = await http.post(
      Uri.parse('$baseUrl/exercises'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(exercise.toJson()),
    );

    switch (response.statusCode) {
      case 201:
        return Exercise.fromJson(json.decode(response.body));
      default:
        throw Exception('Failed to create exercise');
    }
  }

  Future<Exercise> getExerciseById(int exerciseId) async {
    final response = await http.get(Uri.parse('$baseUrl/exercises/$exerciseId'));

    switch (response.statusCode) {
      case 200:
        return Exercise.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Exercise not found');
      default:
        throw Exception('Failed to fetch exercise');
    }
  }

  Future<List<Exercise>> getExercisesByCategory(int categoryId, int index, int number) async {
    final response = await http.get(Uri.parse('$baseUrl/exercises/$categoryId/category?index=$index&number=$number'));

    switch (response.statusCode) {
      case 200:
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Exercise.fromJson(json)).toList();
      default:
        throw Exception('Failed to fetch exercises by category');
    }
  }

  Future<Exercise> updateExercise(int exerciseId, Exercise updatedExercise) async {
    final response = await http.put(
      Uri.parse('$baseUrl/exercises/$exerciseId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedExercise.toJson()),
    );

    switch (response.statusCode) {
      case 200:
        return Exercise.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Exercise not found');
      default:
        throw Exception('Failed to update exercise');
    }
  }

  Future<Exercise> deleteExercise(int exerciseId) async {
    final response = await http.delete(Uri.parse('$baseUrl/exercises/$exerciseId'));

    switch (response.statusCode) {
      case 200:
        return Exercise.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Exercise not found');
      default:
        throw Exception('Failed to delete exercise');
    }
  }
}
