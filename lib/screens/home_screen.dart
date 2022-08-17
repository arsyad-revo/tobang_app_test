import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tobang_app_test/constants/url_constant.dart';
import 'package:tobang_app_test/providers/auth_provider.dart';
import 'package:tobang_app_test/providers/user_provider.dart';
import 'package:tobang_app_test/utils/widget_util.dart';
import 'package:tobang_app_test/widgets/cached_image.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<UserNotifier>().loadUser();
  }

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
      body: Consumer<UserNotifier>(
        builder: (context, value, child) {
          return Center(
            child: value.loadHome!
                ? customLoading()
                : ListView(
                    padding: const EdgeInsets.all(15),
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: CachedImage(
                                imgUrl:
                                    "${UrlConstant.baseUrl}/static${value.userData?.photo?.uri}"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                              "Hi, ${value.userData?.firstname} ${value.userData?.lastname}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              )),
                          const Text("Welcome Back!",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                      ListTile(
                        title: const Text("Email Address"),
                        subtitle: Text("${value.userData?.email}"),
                      ),
                      ListTile(
                        title: const Text("Phone Number"),
                        subtitle: Text("${value.userData?.hp}"),
                      ),
                      ListTile(
                        title: const Text("First Name"),
                        subtitle: Text("${value.userData?.firstname}"),
                      ),
                      ListTile(
                        title: const Text("Last Name"),
                        subtitle: Text("${value.userData?.lastname}"),
                      ),
                      ListTile(
                        title: const Text("Group"),
                        subtitle:
                            Text("${value.userData?.grup?.toUpperCase()}"),
                      ),
                      ListTile(
                        title: const Text("Birth Date"),
                        subtitle: Text("${value.userData?.tglLahir}"),
                      ),
                      ListTile(
                        title: const Text("Gender"),
                        subtitle: Text(
                            "${value.userData?.jenisKelamin['keterangan'].toString().toUpperCase()}"),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
