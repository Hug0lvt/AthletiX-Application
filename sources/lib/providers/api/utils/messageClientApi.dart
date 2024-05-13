import 'package:AthletiX/providers/api/clientApi.dart';
import '../../../model/message.dart';

class MessageClientApi{
  late final ClientApi _clientApi;
  final String _endpoint = 'messages';

  MessageClientApi(ClientApi cli){
    _clientApi = cli;
  }

  Future<Message> createMessage(Message message) async {
    return messageFromJson(await _clientApi.postData(_endpoint, messageToJson(message)));
  }

  Future<Message> getMessageById(int messageId) async {
    return messageFromJson(await _clientApi.getDataById(_endpoint, messageId));
  }

  // TODO LIST
  Future<Message> getMessage(String messageEmail) async {
    return messageFromJson(await _clientApi.getData(_endpoint));
  }

  Future<Message> updateMessage(int messageId, Message updatedMessage) async {
    return messageFromJson(await _clientApi.putData('$_endpoint/$messageId', messageToJson(updatedMessage)));
  }

  Future<Message> deleteMessage(int messageId) async {
    return messageFromJson(await _clientApi.deleteData('$_endpoint/$messageId'));
  }
}