import 'package:charity/api/api_const.dart';
import 'package:charity/api/dio.dart';
import 'package:charity/model/login/login_m.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(AuthInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  //-----------------Login-------------------

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  Future<void> login({Map<String, dynamic>? data}) async {
    emit(LoginLoading());

    VPSDio.post(path: ApiConst.login, data: data)
        .then((value) {
          if (value.statusCode == 200) {
            LoginResponse loginResponseModel = LoginResponse.fromJson(
              value.data,
            );

            emit(LoginSuccess(loginResponseModel: loginResponseModel));
          } else {
            String message = value.data['message'] ?? 'error';
            emit(LoginError(message: message));
          }
        })
        .catchError((e) {
          emit(LoginFaild());
        });
  }
}
