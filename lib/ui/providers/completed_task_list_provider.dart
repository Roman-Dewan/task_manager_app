import 'package:flutter/material.dart';
import 'package:task_manage_updated/data/models/task_model.dart';
import 'package:task_manage_updated/data/services/network_caller.dart';
import 'package:task_manage_updated/data/utils/urls.dart';

class CompletedTaskListProvider extends ChangeNotifier {
  bool _getCompletedTaskListInProgress = false;
  String? _errorMessage;
  List<TaskModel> _completedTaskList = [];

  bool get getCompletedTaskListInProgress => _getCompletedTaskListInProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get completedTaskList => _completedTaskList;

  Future<bool> getCompletedTaskList() async {
    bool isSuccess = false;

    _getCompletedTaskListInProgress = true;
    notifyListeners();

    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.completedTaskListUrl,
    );

    if (response.isSuccess) {
      List<TaskModel> list = [];

      for (Map<String, dynamic> jsonData in response.body['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }

      _completedTaskList = list;
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.error;
    }

    _getCompletedTaskListInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
