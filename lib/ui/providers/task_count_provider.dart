import 'package:flutter/material.dart';
import 'package:task_manage_updated/data/models/task_count_model.dart';
import 'package:task_manage_updated/data/services/network_caller.dart';
import 'package:task_manage_updated/data/utils/urls.dart';

class TaskCountProvider extends ChangeNotifier {
  static List<TaskCountModel> _taskCountList = [];
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;
  List get taskCountList => _taskCountList;

  Future<bool> taskCountProvider() async {
    bool isSuccess = false;

    _inProgress = true;
    notifyListeners();

    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.taskCountUrl,
    );

    _inProgress = false;
    notifyListeners();

    if (response.isSuccess) {
      List<TaskCountModel> list = [];

      for (Map<String, dynamic> jsonData in response.body['data']) {
        list.add(TaskCountModel.fromJson(jsonData));
      }
      _taskCountList = list;

      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.error;
    }

    return isSuccess;
  }
}
