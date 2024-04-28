part of 'keys_bloc.dart';

@immutable
sealed class KeysEvent {}

final class LoadKeys extends KeysEvent {}
