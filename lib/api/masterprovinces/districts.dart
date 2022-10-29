// To parse this JSON data, do
//
//     final districts = districtsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Districts> districtsFromJson(String str) => List<Districts>.from(json.decode(str).map((x) => Districts.fromJson(x)));

String districtsToJson(List<Districts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Districts {
    Districts({
        required this.id,
        required this.code,
        required this.nameTh,
        required this.nameEn,
        required this.provinceId,
    });

    int id;
    String code;
    String nameTh;
    String nameEn;
    int provinceId;

    factory Districts.fromJson(Map<String, dynamic> json) => Districts(
        id: json["id"],
        code: json["code"],
        nameTh: json["name_th"],
        nameEn: json["name_en"],
        provinceId: json["province_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name_th": nameTh,
        "name_en": nameEn,
        "province_id": provinceId,
    };
}
