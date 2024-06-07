import 'package:AthletiX/providers/api/clientApi.dart';
import '../../../model/session.dart';

class SessionClientApi{
  late final ClientApi _clientApi;
  final String _endpoint = 'sessions';

  SessionClientApi(ClientApi cli){
    _clientApi = cli;
  }

  Future<Session> createSession(Session session) async {
    String sesh = sessionToJson(session);
    return sessionFromJson(await _clientApi.postData(_endpoint,sesh));
  }

  Future<Session> getSessionById(int sessionId) async {
    return sessionFromJson(await _clientApi.getDataById(_endpoint, sessionId));
  }

  // TODO LIST
  Future<Session> getSession(String sessionEmail) async {
    return sessionFromJson(await _clientApi.getData(_endpoint));
  }

  Future<Session> updateSession(int sessionId, Session updatedSession) async {
    return sessionFromJson(await _clientApi.putData('$_endpoint/$sessionId', sessionToJson(updatedSession)));
  }

  Future<Session> deleteSession(int sessionId) async {
    return sessionFromJson(await _clientApi.deleteData('$_endpoint/$sessionId'));
  }
}