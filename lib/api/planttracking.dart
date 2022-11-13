// To parse this JSON data, do
//
//     final plantracking = plantrackingFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Plantracking> plantrackingFromJson(String str) => List<Plantracking>.from(
    json.decode(str).map((x) => Plantracking.fromJson(x)));

String plantrackingToJson(List<Plantracking> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Plantracking {
  Plantracking({
    required this.plantTrackingId,
    required this.checkDate,
    required this.plantStatus,
    required this.soilMoisture,
    required this.soilRemark,
    required this.remarkPlant,
    required this.potId,
    required this.potsName,
    required this.greenHouseId,
    required this.cultivationId,
    required this.barcode,
    required this.isTestPot,
    required this.remarkPot,
    required this.imageId,
    required this.fileName,
    required this.diseaseLogId,
    required this.disease,
    required this.fixDisease,
    required this.insectLogId,
    required this.insect,
    required this.fixInsect,
    required this.trashLogId,
    required this.weight,
    required this.logTime,
    required this.trashRemark,
    required this.remark,
    required this.ghName,
    required this.no,
  });

  int plantTrackingId;
  DateTime checkDate;
  int plantStatus;
  int soilMoisture;
  dynamic soilRemark;
  dynamic remarkPlant;
  int potId;
  String potsName;
  int greenHouseId;
  int cultivationId;
  String barcode;
  String isTestPot;
  dynamic remarkPot;
  int imageId;
  String fileName;
  dynamic diseaseLogId;
  dynamic disease;
  dynamic fixDisease;
  dynamic insectLogId;
  dynamic insect;
  dynamic fixInsect;
  dynamic trashLogId;
  dynamic weight;
  dynamic logTime;
  dynamic trashRemark;
  dynamic remark;
  String ghName;
  int no;

  factory Plantracking.fromJson(Map<String, dynamic> json) => Plantracking(
        plantTrackingId: json["PlantTrackingID"],
        checkDate: DateTime.parse(json["CheckDate"]),
        plantStatus: json["PlantStatus"],
        soilMoisture: json["SoilMoisture"],
        soilRemark: json["SoilRemark"],
        remarkPlant: json["RemarkPlant"],
        potId: json["PotID"],
        potsName: json["potsName"],
        greenHouseId: json["GreenHouseID"],
        cultivationId: json["CultivationID"],
        barcode: json["Barcode"],
        isTestPot: json["IsTestPot"],
        remarkPot: json["RemarkPot"],
        imageId: json["ImageID"],
        fileName: json["FileName"],
        diseaseLogId: json["DiseaseLogID"],
        disease: json["Disease"],
        fixDisease: json["FixDisease"],
        insectLogId: json["InsectLogID"],
        insect: json["Insect"],
        fixInsect: json["FixInsect"],
        trashLogId: json["TrashLogID"],
        weight: json["Weight"],
        logTime: json["LogTime"] ,
        trashRemark: json["TrashRemark"],
        remark: json["Remark"],
        ghName: json["GHName"],
        no: json["No"],
      );

  Map<String, dynamic> toJson() => {
        "PlantTrackingID": plantTrackingId,
        "CheckDate": checkDate.toIso8601String(),
        "PlantStatus": plantStatus,
        "SoilMoisture": soilMoisture,
        "SoilRemark": soilRemark,
        "RemarkPlant": remarkPlant,
        "PotID": potId,
        "potsName": potsName,
        "GreenHouseID": greenHouseId,
        "CultivationID": cultivationId,
        "Barcode": barcode,
        "IsTestPot": isTestPot,
        "RemarkPot": remarkPot,
        "ImageID": imageId,
        "FileName": fileName,
        "DiseaseLogID": diseaseLogId == null ? null : diseaseLogId,
        "Disease": disease == null ? null : disease,
        "FixDisease": fixDisease == null ? null : fixDisease,
        "InsectLogID": insectLogId == null ? null : insectLogId,
        "Insect": insect == null ? null : insect,
        "FixInsect": fixInsect == null ? null : fixInsect,
        "TrashLogID": trashLogId == null ? null : trashLogId,
        "Weight": weight == null ? null : weight,
        "LogTime": logTime == null ? null : logTime.toIso8601String(),
        "TrashRemark": trashRemark == null ? null : trashRemark,
        "Remark": remark == null ? null : remark,
        "GHName": ghName,
        "No": no,
      };
}
