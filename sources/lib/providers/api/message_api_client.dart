import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../exceptions/not_found_exception.dart';
import '../../model/message.dart';
import 'api_client.dart';

mixin MessageApiClient on ApiClient {

  Future<Message> createMessage(Message message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/messages'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(message.toJson()),
    );

    switch (response.statusCode) {
      case 201:
        return Message.fromJson(json.decode(response.body));
      default:
        throw Exception('Failed to create message');
    }
  }

  Future<Message> getMessageById(int messageId) async {
    final response = await http.get(Uri.parse('$baseUrl/messages/$messageId'));

    switch (response.statusCode) {
      case 200:
        return Message.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Message not found');
      default:
        throw Exception('Failed to fetch message');
    }
  }

  Future<List<Message>> getAllMessages() async {
    final response = await http.get(Uri.parse('$baseUrl/messages'));

    switch (response.statusCode) {
      case 200:
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Message.fromJson(json)).toList();
      default:
        throw Exception('Failed to fetch messages');
    }
  }

  Future<Message> updateMessage(int messageId, Message updatedMessage) async {
    final response = await http.put(
      Uri.parse('$baseUrl/messages/$messageId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedMessage.toJson()),
    );

    switch (response.statusCode) {
      case 200:
        return Message.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Message not found');
      default:
        throw Exception('Failed to update message');
    }
  }

  Future<Message> deleteMessage(int messageId) async {
    final response = await http.delete(Uri.parse('$baseUrl/messages/$messageId'));

    switch (response.statusCode) {
      case 200:
        return Message.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Message not found');
      default:
        throw Exception('Failed to delete message');
    }
  }
}
