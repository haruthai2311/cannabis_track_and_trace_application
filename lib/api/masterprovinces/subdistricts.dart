// To parse this JSON data, do
//
//     final subDistricts = subDistrictsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<SubDistricts> subDistrictsFromJson(String str) => List<SubDistricts>.from(json.decode(str).map((x) => SubDistricts.fromJson(x)));

String subDistrictsToJson(List<SubDistricts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubDistricts {
    SubDistricts({
        required this.id,
        required this.zipCode,
        required this.nameTh,
        required this.nameEn,
        required this.districtId,
    });

    String id;
    int zipCode;
    String nameTh;
    String nameEn;
    int districtId;

    factory SubDistricts.fromJson(Map<String, dynamic> json) => SubDistricts(
        id: json["id"],
        zipCode: json["zip_code"],
        nameTh: json["name_th"],
        nameEn: json["name_en"],
        districtId: json["district_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "zip_code": zipCode,
        "name_th": nameTh,
        "name_en": nameEn,
        "district_id": districtId,
    };
}
