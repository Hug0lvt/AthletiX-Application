import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../exceptions/not_found_exception.dart';
import '../../model/profile.dart';
import 'api_client.dart';

mixin ProfileApiClient on ApiClient {

  Future<Profile> createProfile(Profile profile) async {
    final response = await http.post(
      Uri.parse('$baseUrl/profiles'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(profile.toJson()),
    );

    switch (response.statusCode) {
      case 201:
        return Profile.fromJson(json.decode(response.body));
      default:
        throw Exception('Failed to create profile');
    }
  }

  Future<Profile> getProfileById(int profileId) async {
    final response = await http.get(Uri.parse('$baseUrl/profiles/$profileId'));

    switch (response.statusCode) {
      case 200:
        return Profile.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Profile not found');
      default:
        throw Exception('Failed to fetch profile');
    }
  }

  Future<Profile> getProfileByEmail(String profileEmail) async {
    final response = await http.get(Uri.parse('$baseUrl/profiles/email/$profileEmail'));

    switch (response.statusCode) {
      case 200:
        return Profile.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Profile not found');
      default:
        throw Exception('Failed to fetch profile by email');
    }
  }

  Future<Profile> updateProfile(int profileId, Profile updatedProfile) async {
    final response = await http.put(
      Uri.parse('$baseUrl/profiles/$profileId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedProfile.toJson()),
    );

    switch (response.statusCode) {
      case 200:
        return Profile.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Profile not found');
      default:
        throw Exception('Failed to update profile');
    }
  }

  Future<Profile> deleteProfile(int profileId) async {
    final response = await http.delete(Uri.parse('$baseUrl/profiles/$profileId'));

    switch (response.statusCode) {
      case 200:
        return Profile.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Profile not found');
      default:
        throw Exception('Failed to delete profile');
    }
  }
}
