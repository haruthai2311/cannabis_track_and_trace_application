// To parse this JSON data, do
//
//     final allStrains = allStrainsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AllStrains> allStrainsFromJson(String str) => List<AllStrains>.from(json.decode(str).map((x) => AllStrains.fromJson(x)));

String allStrainsToJson(List<AllStrains> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllStrains {
    AllStrains({
        required this.strainId,
        required this.name,
        required this.shortName,
        required this.isActive,
        required this.remark,
        required this.createTime,
        required this.createBy,
        required this.updateTime,
        required this.updateBy,
    });

    int strainId;
    String name;
    dynamic shortName;
    String isActive;
    dynamic remark;
    DateTime createTime;
    dynamic createBy;
    DateTime updateTime;
    dynamic updateBy;

    factory AllStrains.fromJson(Map<String, dynamic> json) => AllStrains(
        strainId: json["StrainID"],
        name: json["Name"],
        shortName: json["ShortName"],
        isActive: json["IsActive"],
        remark: json["Remark"],
        createTime: DateTime.parse(json["CreateTime"]),
        createBy: json["CreateBy"],
        updateTime: DateTime.parse(json["UpdateTime"]),
        updateBy: json["UpdateBy"],
    );

    Map<String, dynamic> toJson() => {
        "StrainID": strainId,
        "Name": name,
        "ShortName": shortName,
        "IsActive": isActive,
        "Remark": remark,
        "CreateTime": createTime.toIso8601String(),
        "CreateBy": createBy,
        "UpdateTime": updateTime.toIso8601String(),
        "UpdateBy": updateBy,
    };
}
