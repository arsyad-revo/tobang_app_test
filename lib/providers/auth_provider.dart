import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tobang_app_test/constants/url_constant.dart';
import 'package:tobang_app_test/models/basic_response_model.dart';
import 'package:tobang_app_test/models/sign_in_model.dart';
import 'package:tobang_app_test/screens/home_screen.dart';
import 'package:tobang_app_test/screens/sign_in_screen.dart';
import 'package:tobang_app_test/services/api_service.dart';
import 'package:tobang_app_test/services/session_service.dart';
import 'package:tobang_app_test/utils/widget_util.dart';

class AuthNotifier with ChangeNotifier {
  bool? isLoading = false;
  BasicResponse authResult = BasicResponse();
  bool? isPasswordShowed = false;
  bool? isRePasswordShowed = false;
  SignInModel? dataUser;
  DateTime selectedDate = DateTime.now();

  Future<BasicResponse> signIn(
      String? username, String? password, context) async {
    isLoading = true;
    authResult = BasicResponse();
    try {
      Map<dynamic, dynamic> params = {
        "username": username,
        "password": password
      };
      final response = await APIService.postData(UrlConstant.signInUrl, params);

      authResult = response;
      log(authResult.data.toString(), name: "Login");
      if (response.statusCode == 200) {
        dataUser = SignInModel.fromJson(authResult.data!);
        Session.data.setString('access_token', dataUser!.accessToken!);
        Session.data.setInt('id', authResult.data!['data']['id']);
        Session.data.setBool('is_login', true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } else {
        showSnackbar(
            context, "Error ${authResult.statusCode} : ${authResult.messages}");
      }
      isLoading = false;
      notifyListeners();
      return authResult;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      isLoading = false;
      notifyListeners();
      return authResult;
    }
  }

  Future<BasicResponse> signUp(
      String? email,
      String? password,
      String? phone,
      String? firstname,
      String? lastname,
      String? birthdate,
      int? gender,
      context) async {
    isLoading = true;
    authResult = BasicResponse();
    try {
      Map<dynamic, dynamic> params = {
        "email": "$email",
        "hp": "$phone",
        "firstname": "$firstname",
        "lastname": "$lastname",
        "grup": "member",
        "tgl_lahir": "$birthdate",
        "jenis_kelamin": gender,
        "password": "$password",
        "strict_password": false
      };
      log(params.toString(), name: 'Param SignUp');
      final response =
          await APIService.postData(UrlConstant.userUrl, params, isJson: true);

      authResult = response;
      log(authResult.data.toString(), name: "Register");
      if (response.statusCode == 200) {
        showSnackbar(context, "Success : ${authResult.messages}");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignIn()),
        );
      } else {
        showSnackbar(
            context, "Error ${authResult.statusCode} : ${authResult.messages}");
      }
      isLoading = false;
      notifyListeners();
      return authResult;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      isLoading = false;
      notifyListeners();
      return authResult;
    }
  }

  Future<String> selectDate(BuildContext context) async {
    String stringDate = '';
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      stringDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
    notifyListeners();
    return stringDate;
  }

  logout(BuildContext ctx) {
    Session.data.remove('access_token');
    Session.data.remove('id');
    Session.data.setBool('is_login', false);
    Navigator.pushReplacement(
      ctx,
      MaterialPageRoute(builder: (ctx) => const SignIn()),
    );
  }

  setShowPassword() {
    isPasswordShowed = !isPasswordShowed!;
    notifyListeners();
  }

  setShowRePassword() {
    isRePasswordShowed = !isRePasswordShowed!;
    notifyListeners();
  }

  resetShowPassword() {
    isPasswordShowed = false;
    isRePasswordShowed = false;
    notifyListeners();
  }
}
