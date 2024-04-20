import 'dart:convert';

SignedMessageModel signedMessageModelFromJson(String str) =>
    SignedMessageModel.fromJson(json.decode(str));

String signedMessageModelToJson(SignedMessageModel data) =>
    json.encode(data.toJson());

class SignedMessageModel {
  final String r;
  final String s;
  final String ciphertext;

  SignedMessageModel({
    required this.r,
    required this.s,
    required this.ciphertext,
  });

  factory SignedMessageModel.fromJson(Map<String, dynamic> json) =>
      SignedMessageModel(
        r: json["r"],
        s: json["s"],
        ciphertext: json["ciphertext"],
      );

  Map<String, dynamic> toJson() => {
        "r": r,
        "s": s,
        "ciphertext": ciphertext,
      };
}
