import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tobang_app_test/providers/auth_provider.dart';
import 'package:tobang_app_test/screens/sign_up_screen.dart';
import 'package:tobang_app_test/utils/widget_util.dart';
import 'package:tobang_app_test/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool? isShowed = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loading = context.select((AuthNotifier n) => n.isLoading);
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            children: [
              const Text(
                "Welcome Back!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "I am happy to see you again. You can continue where you left off by logging in.",
                style: TextStyle(color: Colors.black45),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFieldCustom(
                controller: username,
                hint: "Username",
                prefixIcon: Icons.person_outline_sharp,
              ),
              TextFieldCustom(
                controller: password,
                hint: "Password",
                prefixIcon: Icons.lock_outline_rounded,
                suffixIcon: Icons.visibility_off,
                isPassword: true,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    onPressed: loading!
                        ? null
                        : () async {
                            FocusScope.of(context).unfocus();

                            setState(() {});
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              await context.read<AuthNotifier>().signIn(
                                  username.text, password.text, context);
                            }
                          },
                    child: loading
                        ? SizedBox(
                            height: 25,
                            width: 25,
                            child: customLoading(),
                          )
                        : const Text("Sign In")),
              ),
              const SizedBox(
                height: 15,
              ),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Sign Up',
                            style: const TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUp()),
                                );
                              })
                      ],
                      text: 'Don\'t have an account? ',
                      style:
                          const TextStyle(color: Colors.black, fontSize: 14))),
            ],
          ),
        ),
      )),
    );
  }
}
