import 'dart:convert';

DecryptedMessageModel decryptedMessageModelFromJson(String str) => DecryptedMessageModel.fromJson(json.decode(str));

String decryptedMessageModelToJson(DecryptedMessageModel data) => json.encode(data.toJson());

class DecryptedMessageModel {
    final String decryptedText;

    DecryptedMessageModel({
        required this.decryptedText,
    });

    factory DecryptedMessageModel.fromJson(Map<String, dynamic> json) => DecryptedMessageModel(
        decryptedText: json["decrypted-text"],
    );

    Map<String, dynamic> toJson() => {
        "decrypted-text": decryptedText,
    };
}
