part of 'family_cubit.dart';

@immutable
sealed class FamilyState {}

final class HomeInitial extends FamilyState {}

final class HomeChangeIndex extends FamilyState {}

final class GetFamiliesLoading extends FamilyState {}

final class GetFamiliesSuccess extends FamilyState {}

final class GetFamiliesError extends FamilyState {
  final String message;
  GetFamiliesError({required this.message});
}

final class GetFamiliesFaild extends FamilyState {}

final class AddFamelyLoading extends FamilyState {}

final class AddFamelySuccess extends FamilyState {}

final class AddFamelyError extends FamilyState {
  final String message;
  AddFamelyError({required this.message});
}

final class AddFamelyFaild extends FamilyState {}
