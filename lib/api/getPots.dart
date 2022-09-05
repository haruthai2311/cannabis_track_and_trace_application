// To parse this JSON data, do
//
//     final getPots = getPotsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<GetPots> getPotsFromJson(String str) => List<GetPots>.from(json.decode(str).map((x) => GetPots.fromJson(x)));

String getPotsToJson(List<GetPots> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetPots {
    GetPots({
        required this.potId,
        required this.greenHouseId,
        required this.cultivationId,
        required this.name,
        required this.barcode,
        required this.isTestPot,
        required this.remark,
        required this.createTime,
        required this.createBy,
        required this.updateTime,
        required this.updateBy,
    });

    int potId;
    int greenHouseId;
    int cultivationId;
    String name;
    String barcode;
    String isTestPot;
    String remark;
    DateTime createTime;
    String createBy;
    DateTime updateTime;
    String updateBy;

    factory GetPots.fromJson(Map<String, dynamic> json) => GetPots(
        potId: json["PotID"],
        greenHouseId: json["GreenHouseID"],
        cultivationId: json["CultivationID"],
        name: json["Name"],
        barcode: json["Barcode"],
        isTestPot: json["IsTestPot"],
        remark: json["Remark"].toString(),
        createTime: DateTime.parse(json["CreateTime"]),
        createBy: json["CreateBy"].toString(),
        updateTime: DateTime.parse(json["UpdateTime"]),
        updateBy: json["UpdateBy"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "PotID": potId,
        "GreenHouseID": greenHouseId,
        "CultivationID": cultivationId,
        "Name": name,
        "Barcode": barcode,
        "IsTestPot": isTestPot,
        "Remark": remark.toString(),
        "CreateTime": createTime.toIso8601String(),
        "CreateBy": createBy,
        "UpdateTime": updateTime.toIso8601String(),
        "UpdateBy": updateBy,
    };
}
