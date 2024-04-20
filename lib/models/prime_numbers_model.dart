import 'dart:convert';

PrimeNumbersModel primeNumbersModelFromJson(String str) => PrimeNumbersModel.fromJson(json.decode(str));

String primeNumbersModelToJson(PrimeNumbersModel data) => json.encode(data.toJson());

class PrimeNumbersModel {
    final String p;
    final List<String> pA;
    final String q;
    final List<String> qA;

    PrimeNumbersModel({
        required this.p,
        required this.pA,
        required this.q,
        required this.qA,
    });

    factory PrimeNumbersModel.fromJson(Map<String, dynamic> json) => PrimeNumbersModel(
        p: json["p"],
        pA: List<String>.from(json["pA"].map((x) => x)),
        q: json["q"],
        qA: List<String>.from(json["qA"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "p": p,
        "pA": List<dynamic>.from(pA.map((x) => x)),
        "q": q,
        "qA": List<dynamic>.from(qA.map((x) => x)),
    };
}
