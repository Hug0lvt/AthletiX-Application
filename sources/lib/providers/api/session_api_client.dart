import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../exceptions/not_found_exception.dart';
import '../../model/session.dart';
import 'api_client.dart';

mixin SessionApiClient on ApiClient {

  Future<Session> createSession(Session session) async {
    final response = await http.post(
      Uri.parse('$baseUrl/sessions'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(session.toJson()),
    );

    switch (response.statusCode) {
      case 201:
        return Session.fromJson(json.decode(response.body));
      default:
        throw Exception('Failed to create session');
    }
  }

  Future<List<Session>> getAllSessions() async {
    final response = await http.get(Uri.parse('$baseUrl/sessions'));

    switch (response.statusCode) {
      case 200:
        List<dynamic> sessionsJson = json.decode(response.body);
        return sessionsJson.map((json) => Session.fromJson(json)).toList();
      default:
        throw Exception('Failed to fetch sessions');
    }
  }

  Future<Session> getSessionById(int sessionId) async {
    final response = await http.get(Uri.parse('$baseUrl/sessions/$sessionId'));

    switch (response.statusCode) {
      case 200:
        return Session.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Session not found');
      default:
        throw Exception('Failed to fetch session');
    }
  }

  Future<Session> updateSession(int sessionId, Session updatedSession) async {
    final response = await http.put(
      Uri.parse('$baseUrl/sessions/$sessionId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedSession.toJson()),
    );

    switch (response.statusCode) {
      case 200:
        return Session.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Session not found');
      default:
        throw Exception('Failed to update session');
    }
  }

  Future<Session> deleteSession(int sessionId) async {
    final response = await http.delete(Uri.parse('$baseUrl/sessions/$sessionId'));

    switch (response.statusCode) {
      case 200:
        return Session.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Session not found');
      default:
        throw Exception('Failed to delete session');
    }
  }
}
