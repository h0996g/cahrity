import 'package:charity/Screen/Login/componants/components.dart';
import 'package:charity/Screen/Login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginFields extends StatefulWidget {
  const LoginFields({super.key});

  @override
  _LoginFieldsState createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Email Field
        CustomTextFormField(
          textInputAction: TextInputAction.next,
          controller: LoginCubit.get(context).emailController,
          labelText: AppLocalizations.of(context)!.email,
          hintText: AppLocalizations.of(context)!.enterYourEmail,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icon(Icons.email_outlined, size: 24.r),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.pleaseEnterYourEmail;
            }
            if (!value.contains('@')) {
              return AppLocalizations.of(context)!.pleaseEnterAValidEmail;
            }
            return null;
          },
        ),
        SizedBox(height: 15.h),
        // Password Field
        CustomTextFormField(
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              size: 24.r,
            ),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
          controller: LoginCubit.get(context).passwordController,
          labelText: AppLocalizations.of(context)!.password,
          hintText: AppLocalizations.of(context)!.enterYourPassword,
          obscureText: obscureText,
          prefixIcon: Icon(Icons.lock_outline, size: 24.r),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.pleaseEnterYourPassword;
            }
            if (value.length < 6) {
              return AppLocalizations.of(
                context,
              )!.passwordMustBeAtLeast6Characters;
            }
            return null;
          },
        ),
      ],
    );
  }
}
