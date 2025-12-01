import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

// class NetworkCall {
//   // get
//   Future<NetworkResponse> getRequest(String url) async {
//     try {
//       Uri uri = Uri.parse(url);
//       _logRequest(url);
//       Response response = await get(uri);
//
//       _logResponse(url, response);
//       final decodedData = jsonDecode(response.body);
//
//       if (response.statusCode == 200) {
//         return NetworkResponse(
//           isSuccess: true,
//           statusCode: response.statusCode,
//           data: decodedData,
//         );
//       } else {
//         return NetworkResponse(
//           isSuccess: false,
//           statusCode: response.statusCode,
//         );
//       }
//     } catch (e) {
//       return NetworkResponse(isSuccess: false, statusCode: -1);
//     }
//   }
//
//   // post
//
//   Future<NetworkResponse> postRequest(
//     String url,
//     Map<String, dynamic>? body,
//   ) async {
//     try {
//       Uri uri = Uri.parse(url);
//
//       _logRequest(url, body: body);
//
//       Response response = await post(
//         uri,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(body),
//       );
//
//       _logResponse(url, response);
//       final decodedData = jsonDecode(response.body);
//
//       if (response.statusCode == 200) {
//         return NetworkResponse(
//           isSuccess: true,
//           statusCode: response.statusCode,
//           data: decodedData,
//         );
//       } else {
//         return NetworkResponse(
//           isSuccess: false,
//           statusCode: response.statusCode,
//         );
//       }
//     } catch (e) {
//       return NetworkResponse(isSuccess: false, statusCode: -1);
//     }
//   }
//
//   void _logRequest(String url, {Map<String, dynamic>? body}) {
//     debugPrint(
//       "Url: $url"
//       "data: $body",
//     );
//   }
//
//   void _logResponse(String url, Response response) {
//     debugPrint(
//       "Url: $url\n"
//       "status Code : ${response.statusCode}\n"
//       "response: ${response.body}",
//     );
//   }
// }
//
// class NetworkResponse {
//   final bool isSuccess;
//   final int statusCode;
//   final dynamic data;
//   final String? error;
//
//   NetworkResponse({
//     required this.isSuccess,
//     required this.statusCode,
//     this.data,
//     this.error,
//   });
// }

class NetworkCaller {
  // get request
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);

      Response response = await get(uri);
      _logResponse(url, response);
      final decodedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedData,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          error: decodedData['data'],
        );
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, statusCode: -1);
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
        headers: {'Content-Type': 'application/json'},
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
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          error: decodedData['data'],
        );
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, statusCode: -1);
    }
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
