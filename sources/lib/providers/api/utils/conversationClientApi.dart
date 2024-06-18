import 'dart:convert';

import 'package:AthletiX/providers/api/clientApi.dart';
import '../../../model/conversation.dart';

class ConversationClientApi {
  late final ClientApi _clientApi;
  final String _endpoint = 'conversations';

  ConversationClientApi(ClientApi cli) {
    _clientApi = cli;
  }

  Future<Conversation> createConversation(Conversation conversation) async {
    return conversationFromJson(await _clientApi.postData(_endpoint, conversationToJson(conversation)));
  }

  Future<Conversation> getConversationById(int conversationId) async {
    return conversationFromJson(await _clientApi.getDataById(_endpoint, conversationId));
  }

  Future<List<Conversation>> getConversationsByUserId(int userId) async {
    final response = await _clientApi.getData('$_endpoint/user/$userId?includeProfiles=true&includeMessages=false');
    List<dynamic> data = json.decode(response)['items'];
    return data.map((item) => Conversation.fromJson(item)).toList();
  }

  Future<Conversation> deleteConversation(int conversationId) async {
    return conversationFromJson(await _clientApi.deleteData('$_endpoint/$conversationId'));
  }
}
