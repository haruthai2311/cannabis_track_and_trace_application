// To parse this JSON data, do
//
//     final getCultivations = getCultivationsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<GetCultivations> getCultivationsFromJson(String str) => List<GetCultivations>.from(json.decode(str).map((x) => GetCultivations.fromJson(x)));

String getCultivationsToJson(List<GetCultivations> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCultivations {
    GetCultivations({
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
        required this.name,
    });

    int cultivationId;
    int greenHouseId;
    int strainId;
    int no;
    DateTime seedDate;
    DateTime moveDate;
    int seedTotal;
    double seedNet;
    int plantTotal;
    int plantLive;
    int plantDead;
    dynamic remark;
    DateTime createTime;
    dynamic createBy;
    DateTime updateTime;
    dynamic updateBy;
    String name;

    factory GetCultivations.fromJson(Map<String, dynamic> json) => GetCultivations(
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
        updateTime: DateTime.parse(json["UpdateTime"]),
        updateBy: json["UpdateBy"],
        name: json["Name"],
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
        "Remark": remark,
        "CreateTime": createTime.toIso8601String(),
        "CreateBy": createBy,
        "UpdateTime": updateTime.toIso8601String(),
        "UpdateBy": updateBy,
        "Name": name,
    };
}
