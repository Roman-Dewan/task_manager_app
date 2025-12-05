import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:task_manage_updated/ui/controller/auth_controller.dart';

class NetworkCaller {
  // get request
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);

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
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          error: "Un-othorized",
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
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          error: "Un-othorized",
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

  // Future<void> _onUnAuthorized() async {
  //   await AuthController.clearUserData();
  //   Navigator.pushNamed(
  //     TaskManagerApp.NavigatorKey.currentIndex!,
  //     SignInScreen.name,
  //   );
  // }

  static void _logRequest(String url, {Map<String, dynamic>? body}) {
    debugPrint(
      "Url: $url\n"
      "body: $body",
    );
  }

  static void _logResponse(String url, Response response) {
    debugPrint(
      "Url: $url\n"
      "response: ${response.statusCode}",
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
