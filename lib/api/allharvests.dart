// To parse this JSON data, do
//
//     final harvests = harvestsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Harvests> harvestsFromJson(String str) => List<Harvests>.from(json.decode(str).map((x) => Harvests.fromJson(x)));

String harvestsToJson(List<Harvests> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Harvests {
    Harvests({
        required this.harvestId,
        required this.harvestDate,
        required this.harvestNo,
        required this.greenHouseId,
        required this.type,
        required this.weight,
        required this.lotNo,
        required this.remark,
        required this.createTime,
        required this.createBy,
        required this.updateTime,
        required this.updateBy,
        required this.nameGh,
    });

    int harvestId;
    String harvestDate;
    int harvestNo;
    int greenHouseId;
    int type;
    double weight;
    String lotNo;
    dynamic remark;
    DateTime createTime;
    dynamic createBy;
    DateTime updateTime;
    dynamic updateBy;
    String nameGh;

    factory Harvests.fromJson(Map<String, dynamic> json) => Harvests(
        harvestId: json["HarvestID"],
        harvestDate: json["HarvestDate"],
        harvestNo: json["HarvestNo"],
        greenHouseId: json["GreenHouseID"],
        type: json["Type"],
        weight: json["Weight"].toDouble(),
        lotNo: json["LotNo"],
        remark: json["Remark"],
        createTime: DateTime.parse(json["CreateTime"]),
        createBy:  json["CreateBy"],
        updateTime: DateTime.parse(json["UpdateTime"]),
        updateBy: json["UpdateBy"],
        nameGh: json["NameGH"],
    );

    Map<String, dynamic> toJson() => {
        "HarvestID": harvestId,
        "HarvestDate": harvestDate,
        "HarvestNo": harvestNo,
        "GreenHouseID": greenHouseId,
        "Type": type,
        "Weight": weight,
        "LotNo": lotNo,
        "Remark":  remark,
        "CreateTime": createTime.toIso8601String(),
        "CreateBy": createBy,
        "UpdateTime": updateTime.toIso8601String(),
        "UpdateBy":  updateBy,
        "NameGH": nameGh,
    };
}
