import 'dart:convert';

KeysModel keysModelFromJson(String str) => KeysModel.fromJson(json.decode(str));

String keysModelToJson(KeysModel data) => json.encode(data.toJson());

class KeysModel {
  final String publicKey;
  final String privateKey;

  KeysModel({
    required this.publicKey,
    required this.privateKey,
  });

  factory KeysModel.fromJson(Map<String, dynamic> json) => KeysModel(
        publicKey: json["public-key"],
        privateKey: json["private-key"],
      );

  Map<String, dynamic> toJson() => {
        "public-key": publicKey,
        "private-key": privateKey,
      };
}
