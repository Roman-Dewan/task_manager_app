import 'package:flutter/material.dart';
import 'package:task_manage_updated/data/services/network_caller.dart';
import 'package:task_manage_updated/data/utils/urls.dart';

class ForgetPasswordEmailProvider extends ChangeNotifier {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> forgetPasswordProvider(String email) async {
    bool isSuccess = false;

    _inProgress = true;
    notifyListeners();

    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.forgetPasswordEmailUrl(email),
    );

    _inProgress = false;
    notifyListeners();

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.error;
    }

    return isSuccess;
  }
}