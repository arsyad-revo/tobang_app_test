import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tobang_app_test/providers/auth_provider.dart';
import 'package:tobang_app_test/utils/func_util.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final IconData? prefixIcon;
  final bool? isPassword;
  final bool? isRePassword;
  final bool? isDate;
  final IconData? suffixIcon;
  final Function()? onTap;
  final bool? isEmail;
  final bool? isPhone;
  const TextFieldCustom(
      {Key? key,
      this.controller,
      this.hint,
      this.prefixIcon,
      this.isPassword = false,
      this.isRePassword = false,
      this.suffixIcon,
      this.isDate = false,
      this.onTap,
      this.isEmail = false,
      this.isPhone = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isShowPassword =
        context.select((AuthNotifier n) => n.isPasswordShowed);
    final isShowRePassword =
        context.select((AuthNotifier n) => n.isRePasswordShowed);
    return Column(
      children: [
        TextFormField(
          controller: controller,
          obscureText: isPassword!
              ? !isShowPassword!
              : isRePassword!
                  ? !isShowRePassword!
                  : false,
          readOnly: isDate!,
          onTap: onTap,
          validator: (value) {
            if (value!.isEmpty) {
              return 'This field is required';
            } else if (value.isNotEmpty && isEmail! && !isValidEmail(value)) {
              return 'Email not valid';
            } else {
              return null;
            }
          },
          keyboardType: isPhone!
              ? TextInputType.phone
              : isEmail!
                  ? TextInputType.emailAddress
                  : TextInputType.text,
          decoration: InputDecoration(
              hintText: hint,
              filled: true,
              suffixIcon: suffixIcon != null
                  ? IconButton(
                      onPressed: () {
                        if (isPassword!) {
                          context.read<AuthNotifier>().setShowPassword();
                        }
                        if (isRePassword!) {
                          context.read<AuthNotifier>().setShowRePassword();
                        }
                      },
                      icon: Icon(isShowPassword! && isPassword! ||
                              isShowRePassword! && isRePassword!
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded))
                  : null,
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(10.0),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.circular(10.0),
              )),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
