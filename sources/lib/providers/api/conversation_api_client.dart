import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../exceptions/not_found_exception.dart';
import '../../model/conversation.dart';
import 'api_client.dart';

mixin ConversationApiClient on ApiClient {

  Future<Conversation> createConversation(Conversation conversation) async {
    final response = await http.post(
      Uri.parse('$baseUrl/conversations'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(conversation.toJson()),
    );

    switch (response.statusCode) {
      case 201:
        return Conversation.fromJson(json.decode(response.body));
      default:
        throw Exception('Failed to create conversation');
    }
  }

  Future<List<Conversation>> getAllConversations() async {
    final response = await http.get(Uri.parse('$baseUrl/conversations'));

    switch (response.statusCode) {
      case 200:
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Conversation.fromJson(json)).toList();
      default:
        throw Exception('Failed to fetch conversations');
    }
  }

  Future<Conversation> getConversationById(int conversationId) async {
    final response = await http.get(Uri.parse('$baseUrl/conversations/$conversationId'));

    switch (response.statusCode) {
      case 200:
        return Conversation.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Conversation not found');
      default:
        throw Exception('Failed to fetch conversation');
    }
  }

  Future<Conversation> deleteConversation(int conversationId) async {
    final response = await http.delete(Uri.parse('$baseUrl/conversations/$conversationId'));

    switch (response.statusCode) {
      case 200:
        return Conversation.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException('Conversation not found');
      default:
        throw Exception('Failed to delete conversation');
    }
  }
}
