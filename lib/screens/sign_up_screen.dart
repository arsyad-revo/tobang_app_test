import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tobang_app_test/providers/auth_provider.dart';
import 'package:tobang_app_test/screens/sign_in_screen.dart';
import 'package:tobang_app_test/utils/widget_util.dart';
import 'package:tobang_app_test/widgets/textfield_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repassword = TextEditingController();
  TextEditingController date = TextEditingController();
  String? selectedGender;

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
                "Welcome!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Hello, I guess you are new arround here. You can start using the application after sign up.",
                style: TextStyle(color: Colors.black45),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFieldCustom(
                controller: email,
                hint: "Email Address",
                isEmail: true,
                prefixIcon: Icons.mail_outline_rounded,
              ),
              TextFieldCustom(
                controller: phone,
                hint: "Phone Number",
                isPhone: true,
                prefixIcon: Icons.phone_android,
              ),
              TextFieldCustom(
                  controller: firstname,
                  hint: "First Name",
                  prefixIcon: Icons.person_outline_rounded),
              TextFieldCustom(
                controller: lastname,
                hint: "Last Name",
                prefixIcon: Icons.person_outline_rounded,
              ),
              DropdownButtonFormField<String>(
                value: selectedGender,
                hint: const Text("Gender"),
                decoration: InputDecoration(
                    hintText: 'Gender',
                    filled: true,
                    prefixIcon: const Icon(Icons.person_outline_rounded),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                onChanged: (value) => setState(() => selectedGender = value),
                validator: (value) =>
                    value == null ? 'This field is required' : null,
                items: ['Male', 'Female']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFieldCustom(
                controller: date,
                hint: "Birth Date",
                isDate: true,
                onTap: () => context
                    .read<AuthNotifier>()
                    .selectDate(context)
                    .then((value) {
                  setState(() {
                    date.text = value;
                  });
                }),
                prefixIcon: Icons.date_range,
              ),
              TextFieldCustom(
                controller: password,
                hint: "Password",
                isPassword: true,
                suffixIcon: Icons.visibility_off,
                prefixIcon: Icons.lock_outline_rounded,
              ),
              TextFieldCustom(
                controller: repassword,
                hint: "Retype Password",
                isRePassword: true,
                suffixIcon: Icons.visibility_off,
                prefixIcon: Icons.lock_outline_rounded,
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
                              if (password.text != repassword.text) {
                                return showSnackbar(
                                    context, "Password do not match");
                              }
                              context.read<AuthNotifier>().signUp(
                                  email.text,
                                  password.text,
                                  phone.text,
                                  firstname.text,
                                  lastname.text,
                                  date.text,
                                  selectedGender == "Male" ? 1 : 2,
                                  context);
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
                            text: 'Sign In',
                            style: const TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignIn()),
                                );
                              })
                      ],
                      text: 'Already have an account? ',
                      style:
                          const TextStyle(color: Colors.black, fontSize: 14))),
            ],
          ),
        ),
      )),
    );
  }
}
