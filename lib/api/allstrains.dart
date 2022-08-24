// To parse this JSON data, do
//
//     final allStrains = allStrainsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AllStrains allStrainsFromJson(String str) => AllStrains.fromJson(json.decode(str));

String allStrainsToJson(AllStrains data) => json.encode(data.toJson());

class AllStrains {
    AllStrains({
        required this.result,
    });

    List<Result> result;

    factory AllStrains.fromJson(Map<String, dynamic> json) => AllStrains(
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class Result {
    Result({
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

    factory Result.fromJson(Map<String, dynamic> json) => Result(
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
