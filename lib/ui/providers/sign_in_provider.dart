import 'package:flutter/material.dart';
import 'package:task_manage_updated/data/models/user_model.dart';
import 'package:task_manage_updated/data/services/network_caller.dart';
import 'package:task_manage_updated/data/utils/urls.dart';
import 'package:task_manage_updated/ui/controller/auth_controller.dart';

class SignInProvider extends ChangeNotifier {
  bool _signInProgress = false;

  String? _errorMessage;

  bool get signInProgress => _signInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;

    _signInProgress = true;
    notifyListeners();

    Map<String, dynamic> requestBody = {"email": email, "password": password};

    NetworkResponse response = await NetworkCaller.postRequest(
      Urls.loginUrl,
      body: requestBody,
    );

    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(response.body['data']);
      String accessToken = response.body['token'];
      await AuthController.saveUserData(accessToken, userModel);

      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.error;
    }
    _signInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
