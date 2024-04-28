part of 'sign_bloc.dart';

@immutable
sealed class SignEvent {}

final class SignMessageEvent extends SignEvent {

  SignMessageEvent(this.message);

  final String message;
}
