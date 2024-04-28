part of 'sign_bloc.dart';

@immutable
sealed class SignState {}

final class SignLoading extends SignState {}

final class SignLoaded extends SignState {
  final SignedMessageModel signedMessage;

  SignLoaded({required this.signedMessage});
}

final class SignError extends SignState {
  final String errorMessage;

  SignError({required this.errorMessage});
}
