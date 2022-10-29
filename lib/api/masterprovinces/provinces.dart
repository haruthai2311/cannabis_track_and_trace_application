// To parse this JSON data, do
//
//     final provinces = provincesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Provinces> provincesFromJson(String str) => List<Provinces>.from(json.decode(str).map((x) => Provinces.fromJson(x)));

String provincesToJson(List<Provinces> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Provinces {
    Provinces({
        required this.id,
        required this.code,
        required this.nameTh,
        required this.nameEn,
        required this.geographyId,
    });

    int id;
    String code;
    String nameTh;
    String nameEn;
    int geographyId;

    factory Provinces.fromJson(Map<String, dynamic> json) => Provinces(
        id: json["id"],
        code: json["code"],
        nameTh: json["name_th"],
        nameEn: json["name_en"],
        geographyId: json["geography_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name_th": nameTh,
        "name_en": nameEn,
        "geography_id": geographyId,
    };
}
