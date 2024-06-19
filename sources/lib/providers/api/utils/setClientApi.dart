import 'dart:convert';

import 'package:AthletiX/providers/api/clientApi.dart';
import '../../../model/set.dart';

class SetClientApi{
  late final ClientApi _clientApi;
  final String _endpoint = 'sets';

  SetClientApi(ClientApi cli){
    _clientApi = cli;
  }

  Future<Set> createSet(Set set, int exerciseId) async {
    String jsonSet = jsonEncode(set.toJsonWithId(exerciseId));
    print(jsonSet);
    return setFromJson(await _clientApi.postData(_endpoint, jsonSet));
  }

  Future<Set> getSetById(int setId) async {
    return setFromJson(await _clientApi.getDataById(_endpoint, setId));
  }

  // TODO LIST
  Future<Set> getSetByEmail(String setEmail) async {
    return setFromJson(await _clientApi.getData(_endpoint));
  }

  Future<Set> updateSet(int setId, Set updatedSet) async {
    return setFromJson(await _clientApi.putData('$_endpoint/$setId', setToJson(updatedSet)));
  }

  Future<Set> deleteSet(int setId) async {
    return setFromJson(await _clientApi.deleteData('$_endpoint/$setId'));
  }
}