import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tobang_app_test/models/basic_response_model.dart';
import 'package:tobang_app_test/services/session_service.dart';

class APIService {
  static Future<BasicResponse> getData(String? url) async {
    BasicResponse result = BasicResponse();
    int timeout = 15;
    try {
      http.Response response = await http.get(Uri.parse(url!), headers: {
        if (Session.data.getBool('is_login')!)
          'Authorization': 'Bearer ${Session.data.getString('access_token')}',
      }).timeout(Duration(seconds: timeout));
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        result = BasicResponse(
            messages: "Success", data: data, statusCode: response.statusCode);
      } else {
        result = BasicResponse(
            messages: data['status_message'],
            data: data,
            statusCode: response.statusCode);
      }
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print('Timeout Error: $e');
      }
      result = BasicResponse(
          messages: "Request Time Out",
          data: {"error": e.message},
          statusCode: 408);
    } on SocketException catch (e) {
      if (kDebugMode) {
        print('Socket Error: $e');
      }
      result = BasicResponse(
          messages: "Connection Failed",
          data: {"error": e.message},
          statusCode: 502);
    } on Error catch (e) {
      if (kDebugMode) {
        print('General Error: $e');
      }
      result = BasicResponse(
          messages: "Unknown Error Occured",
          data: {"error": e.toString()},
          statusCode: 404);
    }
    return result;
  }

  static Future<BasicResponse> postData(
      String? url, Map<dynamic, dynamic>? params) async {
    BasicResponse result = BasicResponse();
    int timeout = 15;
    try {
      http.Response response = await http
          .post(Uri.parse(url!),
              headers: <String, String>{
                'Accept': 'application/json',
                'Content-Type':
                    'application/x-www-form-urlencoded; charset=UTF-8',
                if (Session.data.getBool('is_login')!)
                  'Authorization':
                      'Bearer ${Session.data.getString('access_token')}',
              },
              body: params)
          .timeout(Duration(seconds: timeout));
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        result = BasicResponse(
            messages: "Success", data: data, statusCode: response.statusCode);
      } else {
        result = BasicResponse(
            messages: data['status']['keterangan'],
            data: data,
            statusCode: response.statusCode);
      }
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print('Timeout Error: $e');
      }
      result = BasicResponse(
          messages: "Request Time Out",
          data: {"error": e.message},
          statusCode: 408);
    } on SocketException catch (e) {
      if (kDebugMode) {
        print('Socket Error: $e');
      }
      result = BasicResponse(
          messages: "Connection Failed",
          data: {"error": e.message},
          statusCode: 502);
    } on Error catch (e) {
      if (kDebugMode) {
        print('General Error: $e');
      }
      result = BasicResponse(
          messages: "Unknown Error Occured",
          data: {"error": e.toString()},
          statusCode: 404);
    }
    return result;
  }
}
