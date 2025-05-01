import 'package:charity/Screen/Login/componants/components.dart';
import 'package:charity/Screen/Login/componants/fields.dart';
import 'package:charity/Screen/Login/componants/redirect.dart';
import 'package:charity/Screen/Login/cubit/login_cubit.dart';
import 'package:charity/const/colors.dart';
import 'package:charity/const/const.dart';
import 'package:charity/const/size_text.dart';
import 'package:charity/helper/cach.dart';
import 'package:charity/widget/lang_component.dart';
import 'package:charity/widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String valueSelected = CachHelper.getData(key: langCache) ?? 'EN';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal.w,
            vertical: paddingVertical.h,
          ),
          child: Form(
            key: LoginCubit.get(context).formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80.h),
                Text(
                  AppLocalizations.of(context)!.welcomeBack,
                  style: TextStyle(
                    fontSize: 28.sp,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  AppLocalizations.of(
                    context,
                  )!.logInAndPickUpRightWhereYouLeftOff,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 30.h),
                LanguageSelector(initialSelectedValue: valueSelected),
                SizedBox(height: 30.h),
                const LoginFields(),
                Spacer(),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginError) {
                      showToast(msg: state.message, state: ToastStates.error);
                    }
                    if (state is LoginSuccess) {
                      handleLoginSuccess(context, state.loginResponseModel);
                    }
                  },
                  builder: (context, state) {
                    return CustomSubmitButton(
                      text: AppLocalizations.of(context)!.login,
                      isLoading: state is LoginLoading,
                      onPressed: () {
                        if (LoginCubit.get(
                          context,
                        ).formKey.currentState!.validate()) {
                          Map<String, dynamic> data = {
                            'identifier':
                                LoginCubit.get(context).emailController.text,
                            'password':
                                LoginCubit.get(context).passwordController.text,
                            "device": CachHelper.getData(key: deviceCache),
                          };
                          LoginCubit.get(context).login(data: data);
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
