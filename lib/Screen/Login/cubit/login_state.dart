part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class AuthInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final LoginResponse loginResponseModel;

  LoginSuccess({required this.loginResponseModel});
}

final class LoginError extends LoginState {
  final String message;
  LoginError({required this.message});
}

final class LoginFaild extends LoginState {}
