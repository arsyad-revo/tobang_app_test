import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:tobang_app_test/providers/auth_provider.dart';
import 'package:tobang_app_test/providers/user_provider.dart';
import 'package:tobang_app_test/screens/home_screen.dart';
import 'package:tobang_app_test/screens/sign_in_screen.dart';
import 'package:tobang_app_test/services/http_overrides.dart';
import 'package:tobang_app_test/services/session_service.dart';
import 'package:tobang_app_test/themes/app_theme.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  HttpOverrides.global = MyHttpOverrides();
  await Session.initLocalStorage();
  initialization();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppTheme>(create: (context) => AppTheme()),
      ChangeNotifierProvider<AuthNotifier>(create: (context) => AuthNotifier()),
      ChangeNotifierProvider<UserNotifier>(create: (context) => UserNotifier())
    ],
    child: const MyApp(),
  ));
}

void initialization() async {
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final bool? isLogin = Session.data.getBool('is_login');
    return Consumer<AppTheme>(
      builder: (context, value, child) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: value.getTheme(),
        home: isLogin! ? const Home() : const SignIn(),
      ),
    );
  }
}
