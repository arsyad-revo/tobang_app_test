import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tobang_app_test/providers/auth_provider.dart';
import 'package:tobang_app_test/screens/sign_in_screen.dart';
import 'package:tobang_app_test/services/http_overrides.dart';
import 'package:tobang_app_test/services/session_service.dart';
import 'package:tobang_app_test/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Session.initLocalStorage();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppTheme>(create: (context) => AppTheme()),
      ChangeNotifierProvider<AuthNotifier>(create: (context) => AuthNotifier())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (context, value, child) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: value.getTheme(),
        home: const SignIn(),
      ),
    );
  }
}
