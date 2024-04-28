import 'package:bloc/bloc.dart';
import 'package:dsa_algorithm/logic/remote_data_source.dart';
import 'package:dsa_algorithm/models/signed_message.dart';
import 'package:meta/meta.dart';

part 'sign_event.dart';
part 'sign_state.dart';

class SignBloc extends Bloc<SignEvent, SignState> {
    final RemoteDataSource remoteDataSource;

  SignBloc(this.remoteDataSource) : super(SignLoading()) {
    on<SignMessageEvent>(_signMessage);
  }

  _signMessage(event, emit) async{
      try {
        final signedMess = await remoteDataSource.signMessage(event.message);


        emit(SignLoaded(signedMessage: signedMess));

      } catch (e) {
        emit(SignError(errorMessage: e.toString()));
        rethrow;
      }
    }
}
