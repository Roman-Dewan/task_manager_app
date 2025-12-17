import 'package:flutter/material.dart';
import 'package:task_manage_updated/data/models/task_model.dart';
import 'package:task_manage_updated/data/services/network_caller.dart';
import 'package:task_manage_updated/data/utils/urls.dart';

class NewTaskListProvider extends ChangeNotifier {
  bool _getNewTaskListInProgress = false;
  String? _errorMessage;
  List<TaskModel> _newTaskList = [];

  bool get getNewTaskListInProgress => _getNewTaskListInProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get newTaskList => _newTaskList;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;

    _getNewTaskListInProgress = true;
    notifyListeners();

    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.newTaskListUrl,
    );

    if (response.isSuccess) {
      List<TaskModel> list = [];

      for (Map<String, dynamic> jsonData in response.body['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }

      _newTaskList = list;
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.error;
    }

    _getNewTaskListInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
