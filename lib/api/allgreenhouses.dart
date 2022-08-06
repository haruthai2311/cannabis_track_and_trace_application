// To parse this JSON data, do
//
//     final allGreenhouses = allGreenhousesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AllGreenhouses allGreenhousesFromJson(String str) => AllGreenhouses.fromJson(json.decode(str));

String allGreenhousesToJson(AllGreenhouses data) => json.encode(data.toJson());

class AllGreenhouses {
    AllGreenhouses({
        required this.result,
    });

    List<Result> result;

    factory AllGreenhouses.fromJson(Map<String, dynamic> json) => AllGreenhouses(
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        required this.greenHouseId,
        required this.locationId,
        required this.name,
        required this.isActive,
        required this.remark,
        required this.createTime,
        required this.createBy,
        required this.updateTime,
        required this.updateBy,
    });

    int greenHouseId;
    int locationId;
    String name;
    String isActive;
    dynamic remark;
    DateTime createTime;
    dynamic createBy;
    DateTime updateTime;
    dynamic updateBy;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        greenHouseId: json["GreenHouseID"],
        locationId: json["LocationID"],
        name: json["Name"],
        isActive: json["IsActive"],
        remark: json["Remark"],
        createTime: DateTime.parse(json["CreateTime"]),
        createBy: json["CreateBy"],
        updateTime: DateTime.parse(json["UpdateTime"]),
        updateBy: json["UpdateBy"],
    );

    Map<String, dynamic> toJson() => {
        "GreenHouseID": greenHouseId,
        "LocationID": locationId,
        "Name": name,
        "IsActive": isActive,
        "Remark": remark,
        "CreateTime": createTime.toIso8601String(),
        "CreateBy": createBy,
        "UpdateTime": updateTime.toIso8601String(),
        "UpdateBy": updateBy,
    };
}
