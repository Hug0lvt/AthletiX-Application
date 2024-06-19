import 'package:AthletiX/model/practicalExercise.dart';
import 'package:AthletiX/providers/api/clientApi.dart';

class PracticalExerciseClientApi{
  late final ClientApi _clientApi;
  final String _endpoint = 'practicalexercise';

  PracticalExerciseClientApi(ClientApi cli){
    _clientApi = cli;
  }

  Future<PracticalExercise> createPracticalExercise(int sessionId, int exerciseId) async {
    return practicalexerciseFromJson(await _clientApi.postData('$_endpoint?sessionId=$sessionId&exerciseId=$exerciseId', ''));
  }

  Future<PracticalExercise> getPracticalExerciseById(int exerciseId) async {
    return practicalexerciseFromJson(await _clientApi.getDataById(_endpoint, exerciseId));
  }
  
  Future<List<PracticalExercise>> getPracticalExercise() async {
    return practicalexerciseListFromJson(await _clientApi.getData(_endpoint));
  }
  // TODO LIST BY CATEGORY
  Future<PracticalExercise> getPracticalExerciseByCategory(String exerciseEmail) async {
    return practicalexerciseFromJson(await _clientApi.getData('$_endpoint/email/$exerciseEmail'));
  }

  Future<PracticalExercise> updatePracticalExercise(int exerciseId, PracticalExercise updatedExercise) async {
    return practicalexerciseFromJson(await _clientApi.putData('$_endpoint/$exerciseId', practicalexerciseToJson(updatedExercise)));
  }

  Future<PracticalExercise> deletePracticalExercise(int exerciseId) async {
    return practicalexerciseFromJson(await _clientApi.deleteData('$_endpoint/$exerciseId'));
  }
}