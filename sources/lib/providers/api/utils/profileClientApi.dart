import 'package:AthletiX/providers/api/clientApi.dart';
import '../../../model/profile.dart';

class ProfileClientApi{
  late final ClientApi _clientApi;
  final String _endpoint = '/profiles';

  ProfileClientApi(ClientApi cli){
    _clientApi = cli;
  }

  Future<Profile> createProfile(Profile profile) async {
    return profileFromJson(_clientApi.postData(_endpoint, profileToJson(profile)).toString());
  }

  Future<Profile> getProfileById(int profileId) async {
    return profileFromJson(_clientApi.getDataById(_endpoint, profileId).toString());
  }

  Future<Profile> getProfileByEmail(String profileEmail) async {
    return profileFromJson(_clientApi.getData('$_endpoint/email/$profileEmail').toString());
  }

  Future<Profile> updateProfile(int profileId, Profile updatedProfile) async {
    return profileFromJson(_clientApi.putData('$_endpoint/$profileId', profileToJson(updatedProfile)).toString());
  }

  Future<Profile> deleteProfile(int profileId) async {
    return profileFromJson(_clientApi.deleteData('$_endpoint/$profileId').toString());
  }
}