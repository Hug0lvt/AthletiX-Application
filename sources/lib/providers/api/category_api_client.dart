import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:AthletiX/providers/api/api_client.dart';

import '../../exceptions/not_found_exception.dart';
import '../../model/category.dart';

mixin CategoryApiClient on ApiClient {

  Future<Category> createCategory(Category category) async {
    final response = await http.post(
      Uri.parse('$baseUrl/categories'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(category.toJson()),
    );

    switch (response.statusCode) {
      case 201:
        return Category.fromJson(json.decode(response.body));
      default:
        throw Exception('Failed to create category');
    }
  }

  Future<List<Category>> getAllCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));

    switch (response.statusCode) {
      case 200:
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Category.fromJson(json)).toList();
      default:
        throw Exception('Failed to fetch categories');
    }
  }

  Future<Category> getCategoryById(int categoryId) async {
    final response = await http.get(Uri.parse('$baseUrl/categories/$categoryId'));

    switch (response.statusCode) {
      case 200:
        return Category.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Category not found');
      default:
        throw Exception('Failed to fetch category');
    }
  }

  Future<Category> updateCategory(int categoryId, Category updatedCategory) async {
    final response = await http.put(
      Uri.parse('$baseUrl/categories/$categoryId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedCategory.toJson()),
    );

    switch (response.statusCode) {
      case 200:
        return Category.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Category not found');
      default:
        throw Exception('Failed to update category');
    }
  }

  Future<Category> deleteCategory(int categoryId) async {
    final response = await http.delete(Uri.parse('$baseUrl/categories/$categoryId'));

    switch (response.statusCode) {
      case 200:
        return Category.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Category not found');
      default:
        throw Exception('Failed to delete category');
    }
  }
}
