part of 'decrypt_bloc.dart';

@immutable
sealed class DecryptState {}

final class DecryptLoading extends DecryptState {}

final class DecryptLoaded extends DecryptState {
  final DecryptedMessageModel decryptedMessageModel;
  final VerifyStatusModel? verifyStatusModel;
  final bool shouldShowDialog;

  DecryptLoaded(
      {required this.shouldShowDialog,
      required this.decryptedMessageModel,
      required this.verifyStatusModel});
}

final class DecryptError extends DecryptState {
  final String errorMessage;

  DecryptError({required this.errorMessage});
}
