import 'package:flutter/foundation.dart';
import 'package:tobang_app_test/constants/url_constant.dart';
import 'package:tobang_app_test/models/basic_response_model.dart';
import 'package:tobang_app_test/models/sign_in_model.dart';
import 'package:tobang_app_test/services/api_service.dart';
import 'package:tobang_app_test/services/session_service.dart';

class UserNotifier with ChangeNotifier {
  Data? userData;
  bool? loadHome = false;
  BasicResponse userResult = BasicResponse();

  Future<BasicResponse> loadUser() async {
    loadHome = true;
    userResult = BasicResponse();
    try {
      final response = await APIService.getData(
          "${UrlConstant.userUrl}/${Session.data.getInt("id")}?zona_waktu=Asia%2FJakarta&image_quality=thumbnail");

      userResult = response;
      if (response.statusCode == 200) {
        userData = Data.fromJson(userResult.data!['data']);
      }
      loadHome = false;
      notifyListeners();
      return userResult;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      loadHome = false;
      notifyListeners();
      return userResult;
    }
  }
}
