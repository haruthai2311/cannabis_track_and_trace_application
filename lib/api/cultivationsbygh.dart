// To parse this JSON data, do
//
//     final cultivationsbyGh = cultivationsbyGhFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<CultivationsbyGh> cultivationsbyGhFromJson(String str) => List<CultivationsbyGh>.from(json.decode(str).map((x) => CultivationsbyGh.fromJson(x)));

String cultivationsbyGhToJson(List<CultivationsbyGh> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CultivationsbyGh {
    CultivationsbyGh({
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
        required this.nameGh,
        required this.nameStrains,
        required this.shortName,
        required this.cid,
        required this.ghid,
        required this.amountpots,
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
    String createBy;
    DateTime updateTime;
    String updateBy;
    String nameGh;
    String nameStrains;
    dynamic shortName;
    dynamic cid;
    dynamic ghid;
    dynamic amountpots;

    factory CultivationsbyGh.fromJson(Map<String, dynamic> json) => CultivationsbyGh(
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
        nameGh: json["NameGH"],
        nameStrains: json["NameStrains"],
        shortName: json["ShortName"],
        cid: json["cid"],
        ghid: json["ghid"],
        amountpots: json["amountpots"],
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
        "NameGH": nameGh,
        "NameStrains": nameStrains,
        "ShortName": shortName,
        "cid": cid,
        "ghid": ghid,
        "amountpots": amountpots,
    };
}
