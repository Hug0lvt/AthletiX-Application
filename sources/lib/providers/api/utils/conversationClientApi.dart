import 'package:AthletiX/providers/api/clientApi.dart';
import '../../../model/conversation.dart';

class ConversationClientApi{
  late final ClientApi _clientApi;
  final String _endpoint = 'conversations';

  ConversationClientApi(ClientApi cli){
    _clientApi = cli;
  }

  Future<Conversation> createConversation(Conversation conversation) async {
    return conversationFromJson(await _clientApi.postData(_endpoint, conversationToJson(conversation)));
  }

  Future<Conversation> getConversationById(int conversationId) async {
    return conversationFromJson(await _clientApi.getDataById(_endpoint, conversationId));
  }

  // TODO LIST
  Future<Conversation> getConversation(String conversationEmail) async {
    return conversationFromJson(await _clientApi.getData(_endpoint));
  }

  Future<Conversation> deleteConversation(int conversationId) async {
    return conversationFromJson(await _clientApi.deleteData('$_endpoint/$conversationId'));
  }
}