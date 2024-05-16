import 'package:AthletiX/providers/api/clientApi.dart';
import '../../../model/exercise.dart';

class ExerciseClientApi{
  late final ClientApi _clientApi;
  final String _endpoint = 'exercises';

  ExerciseClientApi(ClientApi cli){
    _clientApi = cli;
  }

  Future<Exercise> createExercise(Exercise exercise) async {
    return exerciseFromJson(await _clientApi.postData(_endpoint, exerciseToJson(exercise)));
  }

  Future<Exercise> getExerciseById(int exerciseId) async {
    return exerciseFromJson(await _clientApi.getDataById(_endpoint, exerciseId));
  }
  
  Future<Exercise> getExercise() async {
    return exerciseFromJson(await _clientApi.getData(_endpoint));
  }
  // TODO LIST BY CATEGORY
  Future<Exercise> getExerciseByCategory(String exerciseEmail) async {
    return exerciseFromJson(await _clientApi.getData('$_endpoint/email/$exerciseEmail'));
  }

  Future<Exercise> updateExercise(int exerciseId, Exercise updatedExercise) async {
    return exerciseFromJson(await _clientApi.putData('$_endpoint/$exerciseId', exerciseToJson(updatedExercise)));
  }

  Future<Exercise> deleteExercise(int exerciseId) async {
    return exerciseFromJson(await _clientApi.deleteData('$_endpoint/$exerciseId'));
  }
}