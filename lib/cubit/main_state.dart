part of 'main_cubit.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {}

final class ErrorResponseStateMain extends MainState {}

final class MainChangeLanguage extends MainState {}

final class NoConnection extends MainState {}

final class Connection extends MainState {}

final class CheckUpdateLoading extends MainState {}

final class UpdateExistGoodState extends MainState {}

final class CheckUpdateBadState extends MainState {}

final class CheckUpdateError extends MainState {}

final class ChangeThemeStates extends MainState {}
