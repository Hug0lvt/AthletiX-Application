import 'dart:convert';

import 'package:AthletiX/providers/api/clientApi.dart';
import 'package:AthletiX/model/session.dart';

class TrainingClientApi{
  late final ClientApi _clientApi;
  final String _endpoint = 'sessions';

  TrainingClientApi(ClientApi cli){
    _clientApi = cli;
  }

  Future<List<Session>> getPastSessionsOfUser(int? profileId) async {
    if(profileId != null) {
      String jsonReply = await _clientApi.getData('$_endpoint/user/$profileId');
      Map<String, dynamic> data = json.decode(jsonReply);
      String jsonItems = json.encode(data["items"]);
      //return sessionListFromJson(jsonItems);
      return sessionListFromJson(jsonItems);
    }
    return [];
  }

  Future<List<Session>> getProgramsOfUser(int? profileId) async {
    if(profileId != null) {
      String jsonReply = await _clientApi.getData('$_endpoint/user/$profileId');
      Map<String, dynamic> data = json.decode(jsonReply);
      String jsonItems = json.encode(data["items"]);
      return sessionListFromJson(jsonItems);
    }
    return [];
  }

  Future<List<Session>> getProgramsOfUserWithEx(int? profileId) async {
    if(profileId != null) {
      String jsonReply = await _clientApi.getData('$_endpoint/user/$profileId?includeExercise=true');
      Map<String, dynamic> data = json.decode(jsonReply);
      String jsonItems = json.encode(data["items"]);
      return sessionListFromJson(jsonItems);
    }
    return [];
  }


/*  Future<Profile> createProfile(Profile profile) async {
    return profileFromJson(await _clientApi.postData(_endpoint, profileToJson(profile)));
  }

  Future<Profile> getProfileById(int profileId) async {
    return profileFromJson(await _clientApi.getDataById(_endpoint, profileId));
  }

  Future<Profile> getProfileByEmail(String profileEmail) async {
    return profileFromJson(await _clientApi.getData('$_endpoint/email/$profileEmail'));
  }

  Future<Profile> updateProfile(int profileId, Profile updatedProfile) async {
    return profileFromJson(await _clientApi.putData('$_endpoint/$profileId', profileToJson(updatedProfile)));
  }*/

  Future<void> deleteSession(int sessionId) async {
    await _clientApi.deleteData('$_endpoint/$sessionId');
  }
}