// To parse this JSON data, do
//
//     final cultivations = cultivationsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Cultivations> cultivationsFromJson(String str) => List<Cultivations>.from(json.decode(str).map((x) => Cultivations.fromJson(x)));

String cultivationsToJson(List<Cultivations> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cultivations {
    Cultivations({
        required this.cultivationId,
        required this.greenHouseId,
        required this.strainId,
        required this.no,
        required this.seedDate,
        required this.moveDate,
        required this.seedTotal,
        required this.seedNet,
        required this.plantTotal,
        required this.plantLive,
        required this.plantDead,
        required this.remark,
        required this.createTime,
        required this.createBy,
        required this.updateTime,
        required this.updateBy,
        required this.percentageLive,
        required this.percentageDead,
        required this.nameGh,
        required this.nameStrains,
        required this.shortName,
        required this.culGh,
    });
    int cultivationId;
    int greenHouseId;
    int strainId;
    int no;
    DateTime seedDate;
    DateTime moveDate;
    int seedTotal;
    dynamic seedNet;
    int plantTotal;
    int plantLive;
    int plantDead;
    dynamic remark;
    dynamic createTime;
    dynamic createBy;
    dynamic updateTime;
    dynamic updateBy;
    dynamic percentageLive;
    dynamic percentageDead;
    String nameGh;
    String nameStrains;
    dynamic shortName;
    String culGh;

    factory Cultivations.fromJson(Map<String, dynamic> json) => Cultivations(
        cultivationId: json["CultivationID"],
        greenHouseId: json["GreenHouseID"],
        strainId: json["StrainID"],
        no: json["No"],
        seedDate: DateTime.parse(json["SeedDate"]),
        moveDate: DateTime.parse(json["MoveDate"]),
        seedTotal: json["SeedTotal"],
        seedNet: json["SeedNet"].toDouble(),
        plantTotal: json["PlantTotal"],
        plantLive: json["PlantLive"],
        plantDead: json["PlantDead"],
        remark: json["Remark"],
        createTime: DateTime.parse(json["CreateTime"]),
        createBy: json["CreateBy"],
        updateTime: json["UpdateTime"],
        updateBy: json["UpdateBy"],
        percentageLive: json["PercentageLive"].toDouble(),
        percentageDead: json["PercentageDead"].toDouble(),
        nameGh: json["NameGH"],
        nameStrains: json["NameStrains"],
        shortName: json["ShortName"],
        culGh: json["culGH"],
    );

    Map<String, dynamic> toJson() => {
        "CultivationID": cultivationId,
        "GreenHouseID": greenHouseId,
        "StrainID": strainId,
        "No": no,
        "SeedDate": seedDate.toIso8601String(),
        "MoveDate": moveDate.toIso8601String(),
        "SeedTotal": seedTotal,
        "SeedNet": seedNet,
        "PlantTotal": plantTotal,
        "PlantLive": plantLive,
        "PlantDead": plantDead,
        "Remark":  remark,
        "CreateTime": createTime.toIso8601String(),
        "CreateBy": createBy,
        "UpdateTime": updateTime,
        "UpdateBy": updateBy,
        "PercentageLive":  percentageLive,
        "PercentageDead":  percentageDead,
        "NameGH": nameGh,
        "NameStrains": nameStrains,
        "ShortName": shortName,
        "culGH": culGh,
    };
}


