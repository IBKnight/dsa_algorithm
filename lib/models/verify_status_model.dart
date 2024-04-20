import 'dart:convert';

VerifyStatusModel verifyStatusModelFromJson(String str) => VerifyStatusModel.fromJson(json.decode(str));

String verifyStatusModelToJson(VerifyStatusModel data) => json.encode(data.toJson());

class VerifyStatusModel {
    final bool isValid;

    VerifyStatusModel({
        required this.isValid,
    });

    factory VerifyStatusModel.fromJson(Map<String, dynamic> json) => VerifyStatusModel(
        isValid: json["is_valid"],
    );

    Map<String, dynamic> toJson() => {
        "is_valid": isValid,
    };
}
