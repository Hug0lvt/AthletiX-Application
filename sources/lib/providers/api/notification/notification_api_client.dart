import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../model/profile.dart';
import '../api_client.dart';

mixin NotificationApiClient on ApiClient {

  Future<void> updateUniqueNotificationToken(Profile updatedProfile) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/api/notification/fcm'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedProfile.toJson()),
    );

    switch (response.statusCode) {
      case 200:
        return;
      default:
        throw Exception('Failed to update unique notification token');
    }
  }

  Future<void> sendNotification(String title, String body, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/notification/fcm'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'title': title, 'body': body, 'token': token}),
    );

    switch (response.statusCode) {
      case 200:
        return;
      default:
        throw Exception('Failed to send notification');
    }
  }
}