import 'package:flutter/material.dart';
import 'package:task_manage_updated/data/models/task_model.dart';
import 'package:task_manage_updated/data/services/network_caller.dart';
import 'package:task_manage_updated/data/utils/urls.dart';

class CancelledTaskListProvider extends ChangeNotifier {
  bool _getCancelledTaskListInProgress = false;
  String? _errorMessage;
  List<TaskModel> _cancelledTaskList = [];

  bool get getCancelledTaskListInProgress => _getCancelledTaskListInProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get cancelledTaskList => _cancelledTaskList;

  Future<bool> getCancelledTaskList() async {
    bool isSuccess = false;

    _getCancelledTaskListInProgress = true;
    notifyListeners();

    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.cancelledTaskListUrl,
    );

    if (response.isSuccess) {
      List<TaskModel> list = [];

      for (Map<String, dynamic> jsonData in response.body['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }

      _cancelledTaskList = list;
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.error;
    }

    _getCancelledTaskListInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
