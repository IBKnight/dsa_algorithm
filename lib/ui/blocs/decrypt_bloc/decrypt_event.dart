part of 'decrypt_bloc.dart';

@immutable
sealed class DecryptEvent {}

final class DecryptMessageEvent extends DecryptEvent {
  final String encryptedMessage;
  DecryptMessageEvent({required this.encryptedMessage});
}

final class VerifyMessageEvent extends DecryptEvent {
  final String r;
  final String s;
  final String publicKey;
  final String encryptedMessage;

  VerifyMessageEvent(
      {required this.r,
      required this.s,
      required this.publicKey,
      required this.encryptedMessage});
}
