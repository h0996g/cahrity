import 'package:charity/api/dio.dart';
import 'package:charity/const/const.dart';
import 'package:charity/helper/cach.dart';
import 'package:charity/home/cubit/home_cubit.dart';
import 'package:charity/model/login/login_m.dart';
import 'package:charity/route.dart';
import 'package:charity/widget/toast.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> handleLoginSuccess(
  BuildContext context,
  LoginResponse loginResponseModel,
) async {
  CachHelper.putcache(key: tokenCache, value: loginResponseModel.token);
  CachHelper.putcache(key: useridCache, value: loginResponseModel.user?.id);
  VPSDio.updateToken(loginResponseModel.token!);
  TOKEN = loginResponseModel.token!;
  HomeCubit.get(context).initHome();
  context.go(RouteConstants.home);
  showToast(msg: loginResponseModel.message!, state: ToastStates.success);
}
