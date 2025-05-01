part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeChangeIndex extends HomeState {}

final class GetFamiliesLoading extends HomeState {}

final class GetFamiliesSuccess extends HomeState {}

final class GetFamiliesError extends HomeState {
  final String message;
  GetFamiliesError({required this.message});
}

final class GetFamiliesFaild extends HomeState {}

final class AddFamelyLoading extends HomeState {}

final class AddFamelySuccess extends HomeState {}

final class AddFamelyError extends HomeState {
  final String message;
  AddFamelyError({required this.message});
}

final class AddFamelyFaild extends HomeState {}
