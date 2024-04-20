import 'package:dio/dio.dart';
import 'package:dsa_algorithm/models/keys_model.dart';
import 'package:dsa_algorithm/models/prime_numbers_model.dart';

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
}
