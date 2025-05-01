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
