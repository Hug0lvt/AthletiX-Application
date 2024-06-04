import 'dart:convert';

import 'package:AthletiX/providers/api/clientApi.dart';
import 'package:flutter/services.dart';
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
  
  Future<List<Exercise>> getExercises() async {
    // A revoir
    List<Exercise> exercises = [];
    const int pageSize = 10;
    int pageNumber = 0;
    String jsonReply = await _clientApi.getData('$_endpoint/pages?pageSize=$pageSize&pageNumber=$pageNumber');
    Map<String, dynamic> data = json.decode(jsonReply);
    pageNumber = data["pageNumber"];
    String jsonItems = json.encode(data["items"]);
    exercises.addAll(exerciseListFromJson(jsonItems));
    while(pageNumber != -1){
      String jsonReply = await _clientApi.getData('$_endpoint/pages?pageSize=$pageSize&pageNumber=$pageNumber');
      data = json.decode(jsonReply);
      pageNumber = data["pageNumber"];
      String jsonItems = json.encode(data["items"]);
      exercises.addAll(exerciseListFromJson(jsonItems));
    }
    return exercises;
  }

  Future<List<Exercise>> getExercisesByPage(int pageSize, int pageNumber) async {
    String jsonReply = await _clientApi.getData('$_endpoint/pages?pageSize=$pageSize&pageNumber=$pageNumber');
    Map<String, dynamic> data = json.decode(jsonReply);
    String jsonItems = json.encode(data["items"]);
    return exerciseListFromJson(jsonItems);
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