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
      return sessionListFromJson(
          await _clientApi.getDataById(_endpoint, profileId!));
    }
    return [];
  }
  Future<List<Session>> getProgramsOfUser(int? profileId) async {
    if(profileId != null) {
      return sessionListFromJson(
          await _clientApi.getDataById(_endpoint, profileId!));
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
  }

  Future<Profile> deleteProfile(int profileId) async {
    return profileFromJson(await _clientApi.deleteData('$_endpoint/$profileId'));
  }*/
}