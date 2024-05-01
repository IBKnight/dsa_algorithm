import 'package:bloc/bloc.dart';
import 'package:dsa_algorithm/logic/remote_data_source.dart';
import 'package:dsa_algorithm/models/decrypted_message_model.dart';
import 'package:dsa_algorithm/models/verify_status_model.dart';
import 'package:meta/meta.dart';

part 'decrypt_event.dart';
part 'decrypt_state.dart';

class DecryptBloc extends Bloc<DecryptEvent, DecryptState> {
  RemoteDataSource remoteDataSource;
  DecryptBloc(this.remoteDataSource) : super(DecryptLoading()) {
    on<DecryptMessageEvent>(_decryptMessage);
    on<VerifyMessageEvent>(_verifyMessage);
  }
  Future<void> _decryptMessage(event, emit) async {
    try {
      final DecryptedMessageModel decryptedMessage =
          await remoteDataSource.decryptMessage(event.encryptedMessage);

      emit(
        DecryptLoaded(
            decryptedMessageModel: decryptedMessage,
            verifyStatusModel: null,
            shouldShowDialog: false),
      );
    } catch (e) {
      emit(DecryptError(errorMessage: e.toString()));
    }
  }

  Future<void> _verifyMessage(event, emit) async {
    try {
      final DecryptedMessageModel decryptedMessage =
          await remoteDataSource.decryptMessage(event.encryptedMessage);

      final verifyStatus = await remoteDataSource.verifyMessage(
          cipherMessage: event.encryptedMessage,
          r: event.r,
          s: event.s,
          publicKey: event.publicKey);

      emit(DecryptLoaded(
          decryptedMessageModel: decryptedMessage,
          verifyStatusModel: verifyStatus, shouldShowDialog: true));
    } catch (e) {
      emit(DecryptError(errorMessage: e.toString()));
    }
  }
}
