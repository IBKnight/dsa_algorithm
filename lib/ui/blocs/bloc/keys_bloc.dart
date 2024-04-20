import 'package:bloc/bloc.dart';
import 'package:dsa_algorithm/logic/remote_data_source.dart';
import 'package:dsa_algorithm/models/keys_model.dart';
import 'package:dsa_algorithm/models/prime_numbers_model.dart';
import 'package:flutter/material.dart';

part 'keys_event.dart';
part 'keys_state.dart';

class KeysBloc extends Bloc<KeysEvent, KeysState> {
  final RemoteDataSource remoteDataSource;
  KeysBloc(this.remoteDataSource) : super(KeysLoading()) {
    on<LoadKeys>(_loadKeys);
  }
  _loadKeys(LoadKeys event, Emitter<KeysState> emit) async {
    try {
      emit(KeysLoading());

      final PrimeNumbersModel primeNumbers =
          await remoteDataSource.fetchPrimeNumbers();
      final KeysModel keys = await remoteDataSource.generateKeys();

      emit(KeysLoaded(keys: keys, primeNumbers: primeNumbers));
    } catch (e) {
      emit(KeysError(e.toString()));
      rethrow;
    }
  }
}
