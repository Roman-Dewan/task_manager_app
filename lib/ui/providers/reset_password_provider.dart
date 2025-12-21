import 'package:flutter/material.dart';
import 'package:task_manage_updated/data/services/network_caller.dart';
import 'package:task_manage_updated/data/utils/urls.dart';

class ResetPasswordProvider extends ChangeNotifier {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> resetPasswordProvider(String email, String otp, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    notifyListeners();


    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": password,
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      Urls.resetPasswordUrl,
      body: requestBody,
    );
    _inProgress = false;
    notifyListeners();

    if(response.isSuccess){
      isSuccess = true;
      _errorMessage = null;
    } else{
      _errorMessage = response.error;
    }

    return isSuccess;
  }
}