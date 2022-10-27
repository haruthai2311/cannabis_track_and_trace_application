// To parse this JSON data, do
//
//     final countcht = countchtFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Countcht> countchtFromJson(String str) => List<Countcht>.from(json.decode(str).map((x) => Countcht.fromJson(x)));

String countchtToJson(List<Countcht> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Countcht {
    Countcht({
        required this.greenHouseId,
        required this.nameGreenhouse,
        required this.nameLocation,
        required this.address,
        required this.ghiDcul,
        required this.countCul,
        required this.yearCul,
        required this.ghiDher,
        required this.countHar,
        required this.yearHar,
        required this.ghidTran,
        required this.countTran,
        required this.yearTran,
    });

    int greenHouseId;
    String nameGreenhouse;
    String nameLocation;
    String address;
    dynamic ghiDcul;
    dynamic countCul;
    dynamic yearCul;
    dynamic ghiDher;
    dynamic countHar;
    dynamic yearHar;
    dynamic ghidTran;
    dynamic countTran;
    dynamic yearTran;

    factory Countcht.fromJson(Map<String, dynamic> json) => Countcht(
        greenHouseId: json["GreenHouseID"],
        nameGreenhouse: json["NameGreenhouse"],
        nameLocation: json["NameLocation"],
        address: json["Address"],
        ghiDcul: json["GHIDcul"],
        countCul: json["CountCul"],
        yearCul: json["YearCul"],
        ghiDher: json["GHIDher"],
        countHar: json["CountHar"],
        yearHar: json["YearHar"],
        ghidTran: json["GHIDTran"],
        countTran: json["CountTran"],
        yearTran: json["YearTran"],
    );

    Map<String, dynamic> toJson() => {
        "GreenHouseID": greenHouseId,
        "NameGreenhouse": nameGreenhouse,
        "NameLocation": nameLocation,
        "Address": address,
        "GHIDcul": ghiDcul,
        "CountCul": countCul,
        "YearCul": yearCul,
        "GHIDher": ghiDher,
        "CountHar": countHar,
        "YearHar": yearHar,
        "GHIDTran": ghidTran,
        "CountTran": countTran,
        "YearTran": yearTran,
    };
}
