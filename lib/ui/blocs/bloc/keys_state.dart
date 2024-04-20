part of 'keys_bloc.dart';

@immutable
sealed class KeysState {}

final class KeysLoading extends KeysState {}

final class KeysLoaded extends KeysState {
  final KeysModel keys;
  final PrimeNumbersModel primeNumbers;

  KeysLoaded({required this.keys, required this.primeNumbers});
}

final class KeysError extends KeysState {
  final String errorMessage;

  KeysError(this.errorMessage);
}
