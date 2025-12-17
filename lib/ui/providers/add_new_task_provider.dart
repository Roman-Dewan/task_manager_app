import 'package:flutter/material.dart';
import 'package:task_manage_updated/data/services/network_caller.dart';
import 'package:task_manage_updated/data/utils/urls.dart';

class AddNewTaskProvider extends ChangeNotifier {
  bool _addNewTaskInProgress = false;

  String? _errorMessage;

  bool get addNewTaskInProgress => _addNewTaskInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> addNewTask(
    String title,
    String description,
  ) async {
    bool isSuccess = false;

    _addNewTaskInProgress = true;
    notifyListeners();

    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New",
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
      Urls.createNewTaskUrl,
      body: requestBody,
    );

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.error;
    }
    _addNewTaskInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
