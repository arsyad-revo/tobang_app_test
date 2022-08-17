import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tobang_app_test/providers/auth_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "HOME",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthNotifier>().logout(context);
              },
              icon: const Icon(
                Icons.exit_to_app_rounded,
                color: Colors.black,
              ))
        ],
      ),
      body: Container(),
    );
  }
}
