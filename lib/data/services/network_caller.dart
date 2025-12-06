import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:task_manage_updated/ui/app.dart';
import 'package:task_manage_updated/ui/controller/auth_controller.dart';
// import 'package:task_manage_updated/ui/screens/new_task_list_screen.dart';
import 'package:task_manage_updated/ui/screens/sign_in_screen.dart';

class NetworkCaller {
  // get request
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);

      // missing check
      if (AuthController.accessToken == null) {
        await AuthController.getUserData();
      }

      Response response = await get(
        uri,
        headers: {'token': AuthController.accessToken ?? ''},
      );

      _logResponse(url, response);
      final decodedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedData,
        );
      } else if (response.statusCode == 401) {
        _onUnothorized();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          error: "Un-authorized",
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          error: decodedData['data'],
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        error: e.toString(),
      );
    }
  }

  // post request
  static Future<NetworkResponse> postRequest(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url, body: body);

      // If the static token is null (due to app restart), try to load it from disk
      if (AuthController.accessToken == null) {
        await AuthController.getUserData();
      }

      Response response = await post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'token': AuthController.accessToken ?? '',
        },
        body: jsonEncode(body),
      );
      _logResponse(url, response);

      final decodedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedData,
        );
      } else if (response.statusCode == 401) {
        _onUnothorized();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          error: "Un-Authorized",
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          error: decodedData['data'],
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        error: e.toString(),
      );
    }
  }

  static Future<void> _onUnothorized() async {
    await AuthController.clearUserData();
    Navigator.pushNamed(MyApp.navigatorKey.currentContext!, SignInScreen.name);
  }

  static void _logRequest(String url, {Map<String, dynamic>? body}) {
    debugPrint(
      "Url: $url\n"
      "body: $body",
    );
  }

  static void _logResponse(String url, Response response) {
    debugPrint(
      "Url: $url\n"
      "response: ${response.statusCode}"
      "Body: ${response.body}",
    );
  }
}

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final dynamic body;
  final String error;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.body,
    this.error = "Something Went Wrong",
  });
}
