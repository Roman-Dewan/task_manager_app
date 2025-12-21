import 'package:flutter/material.dart';
import 'package:task_manage_updated/data/services/network_caller.dart';
import 'package:task_manage_updated/data/utils/urls.dart';

class OtpVerifyProvider extends ChangeNotifier {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> otpVerifyprovider(String email, String otp) async {
    bool isSuccess = false;
    _inProgress = true;
    notifyListeners();

    NetworkResponse response = await NetworkCaller.getRequest(Urls.forgetOtpVerifyUrl(email, otp));

    _inProgress = false;
    notifyListeners();
    if(response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } 
    else {
      _errorMessage = response.error;
    }

    return isSuccess;
  }

}