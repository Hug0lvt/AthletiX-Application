import 'package:AthletiX/providers/api/clientApi.dart';
import '../../../model/profile.dart';

class ProfileApiClient{
  late final ClientApi clientApi;
  final String _endpoint = '/profiles';

  ProfileApiClient(ClientApi cli){
    clientApi = cli;
  }

  Future<Profile> createProfile(Profile profile) async {
    return profileFromJson(clientApi.postData(_endpoint, profileToJson(profile)).toString());
  }

  Future<Profile> getProfileById(int profileId) async {
    return profileFromJson(clientApi.getDataById(_endpoint, profileId).toString());
  }

  Future<Profile> getProfileByEmail(String profileEmail) async {
    return profileFromJson(clientApi.getData('$_endpoint/email/$profileEmail').toString());
  }

  Future<Profile> updateProfile(int profileId, Profile updatedProfile) async {
    return profileFromJson(clientApi.putData('$_endpoint/$profileId', profileToJson(updatedProfile)).toString());
  }

  Future<Profile> deleteProfile(int profileId) async {
    return profileFromJson(clientApi.deleteData('$_endpoint/$profileId').toString());
  }
}