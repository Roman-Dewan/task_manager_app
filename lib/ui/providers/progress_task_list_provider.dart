import 'package:flutter/material.dart';
import 'package:task_manage_updated/data/models/task_model.dart';
import 'package:task_manage_updated/data/services/network_caller.dart';
import 'package:task_manage_updated/data/utils/urls.dart';

class ProgressTaskListProvider extends ChangeNotifier {
  bool _getProgressTaskListInProgress = false;
  String? _errorMessage;
  List<TaskModel> _progressTaskList = [];

  bool get getProgressTaskListInProgress => _getProgressTaskListInProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get progressTaskList => _progressTaskList;

  Future<bool> getProgressTaskList() async {
    bool isSuccess = false;

    _getProgressTaskListInProgress = true;
    notifyListeners();

    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.progressTaskListUrl,
    );

    if (response.isSuccess) {
      List<TaskModel> list = [];

      for (Map<String, dynamic> jsonData in response.body['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }

      _progressTaskList = list;
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.error;
    }

    _getProgressTaskListInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
