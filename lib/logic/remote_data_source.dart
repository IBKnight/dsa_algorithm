import 'package:dio/dio.dart';
import 'package:dsa_algorithm/models/decrypted_message_model.dart';
import 'package:dsa_algorithm/models/keys_model.dart';
import 'package:dsa_algorithm/models/prime_numbers_model.dart';
import 'package:dsa_algorithm/models/signed_message.dart';
import 'package:dsa_algorithm/models/verify_status_model.dart';

class RemoteDataSource {
  final Dio _dio = Dio();
  Future<PrimeNumbersModel> fetchPrimeNumbers() async {
    final response = await _dio.get('http://localhost:8080/generate-primes');

    final data = response.data as Map<String, Object?>;

    return PrimeNumbersModel.fromJson(data);
  }

  Future<KeysModel> generateKeys() async {
    final response = await _dio.get('http://localhost:8080/generate-keys');

    final data = response.data as Map<String, Object?>;

    return KeysModel.fromJson(data);
  }

  Future<SignedMessageModel> signMessage(String message) async {
    final response = await _dio
        .get('http://localhost:8080/sign-message', data: {'message': message});

    final data = response.data as Map<String, Object?>;

    return SignedMessageModel.fromJson(data);
  }

  Future<VerifyStatusModel> verifyMessage(
      {required String cipherMessage,
      required String r,
      required String s,
      required String publicKey}) async {
    final response = await _dio.get('http://localhost:8080/verify-message',
        data: {
          'r': r,
          's': s,
          'public-key': publicKey,
          'message': cipherMessage
        });

    final data = response.data as Map<String, Object?>;

    return VerifyStatusModel.fromJson(data);
  }

  Future<DecryptedMessageModel> decryptMessage(String cipherMessage) async {
    final response = await _dio.get('http://localhost:8080/encrypt-message',
        data: {'ciphertext': cipherMessage});

    final data = response.data as Map<String, Object?>;

    return DecryptedMessageModel.fromJson(data);
  }
}
