import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../api/hostapi.dart';
import '../../api/planttracking.dart';
import '../../config/styles.dart';
import '../../widget/dialog.dart';

class EditPlantTracking extends StatefulWidget {
  final String PlantrackingID;
  final String UserID;
  const EditPlantTracking(
      {Key? key, required this.PlantrackingID, required this.UserID})
      : super(key: key);

  @override
  State<EditPlantTracking> createState() => _EditPlantTrackingState();
}

class _EditPlantTrackingState extends State<EditPlantTracking> {
  late List<Plantracking> _listplanttracking;
  final dialog = MyDialog();
  File? file; //เก็บภาพจากการถ่ายและจากแกลเลอรี่

  Future<List<Plantracking>> getPlanttracking() async {
    var url = hostAPI + '/trackings/Plantracking?id=' + widget.PlantrackingID;
    print(url);
    var response = await http.get(Uri.parse(url));
    _listplanttracking = plantrackingFromJson(response.body);
    //print(response.body);
    return _listplanttracking;
  }

  @override
  void initState() {
    super.initState();
    getPlanttracking();
    //print(dropdownSelectStatus);
    //print(widget.UserID);
    print(file);
  }

  final f = DateFormat('dd/MM/yyyy hh:mm:ss');

  String? selectdropdownStatus;
  String? dropdownStatus;
  var itemStatus = ['N/A', 'ปกติ', 'ไม่สมบูรณ์', 'ตัดทิ้ง'];

  String? selectdropdownSoi;
  String? dropdownSoi;
  var itemSoi = [
    'N/A',
    'ดินชิ้นเหมาะสม',
    'ดินชื้นมาก ไม่มีผลต่อการเจริญเติบโต',
    'ดินชื้นมาก มีผลต่อการเจริญเติบโต',
    'ดินแห้ง พบต้นเหี่ยวช่วงบ่าย',
    'ดินแห้ง ไม่พบต้นเหี่ยวช่วงบ่าย'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
      ),
      body: FutureBuilder(
        future: getPlanttracking(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              Container();
            }
            var result = snapshot.data;

            final _ctlGHName = TextEditingController(text: result[0].ghName);
            final _ctlCulNo =
                TextEditingController(text: result[0].no.toString());
            final _ctlCheckDate = TextEditingController(
                text: f.format(result[0].checkDate).toString());
            final _ctlPotId =
                TextEditingController(text: result[0].potId.toString());

            String plantStatus;

            String status = result[0].plantStatus.toString();
            if (status == "1") {
              plantStatus = "ปกติ";
            } else if (status == "2") {
              plantStatus = "ไม่สมบูรณ์";
            } else if (status == "3") {
              plantStatus = "ตัดทิ้ง";
            } else {
              plantStatus = "N/A";
            }
            // String selectdropdownStatus = plantStatus;
            // print(selectdropdownStatus);

            // final _ctlPlantStatus = TextEditingController(text: Status);

            String soilMoisture;
            String Soil = result[0].soilMoisture.toString();
            if (Soil == "1") {
              soilMoisture = "ดินชิ้นเหมาะสม";
            } else if (Soil == "2") {
              soilMoisture = "ดินชื้นมาก ไม่มีผลต่อการเจริญเติบโต";
            } else if (Soil == "3") {
              soilMoisture = "ดินชื้นมาก มีผลต่อการเจริญเติบโต";
            } else if (Soil == "4") {
              soilMoisture = "ดินแห้ง พบต้นเหี่ยวช่วงบ่าย";
            } else if (Soil == "5") {
              soilMoisture = "ดินแห้ง ไม่พบต้นเหี่ยวช่วงบ่าย";
            } else {
              soilMoisture = "N/A";
            }
            // final _ctlSoilMoisture =
            //     TextEditingController(text: SoilMoisture);

            final _ctlSoilRemark =
                TextEditingController(text: result[0].soilRemark);
            final _ctlDisease = TextEditingController(text: result[0].disease);
            final _ctlFixDisease =
                TextEditingController(text: result[0].fixDisease);
            final _ctlInsect = TextEditingController(text: result[0].insect);
            final _ctlFixInsect =
                TextEditingController(text: result[0].fixInsect);
            final _ctlWeight = TextEditingController(
                text: result[0].weight.toString() + ' Kg');
            final _ctlTrashRemark =
                TextEditingController(text: result[0].trashRemark);
            final _ctlRemark = TextEditingController(text: result[0].remark);
            final _ctlLogtime = TextEditingController(
                text: f.format(result[0].logTime).toString());
            return SafeArea(
                child: ListView(padding: EdgeInsets.zero, children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Edit Plant Tracking",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 8, 143, 114)),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 200,
                                  // decoration:
                                  //     BoxDecoration(border: Border.all(color: Color(0xffC4C4C4))),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: ((() =>
                                              chooseImage(ImageSource.camera))),
                                          icon: const Icon(
                                            Icons.add_a_photo,
                                          )),
                                      Container(
                                          width: 270,
                                          //height: 190,
                                          child: file == null
                                              ? Image.network(
                                                  hostAPI + result[0].fileName,
                                                  //fit: BoxFit.cover,
                                                )
                                              : Image.file(file!)),
                                      IconButton(
                                          onPressed: (() =>
                                              chooseImage(ImageSource.gallery)),
                                          icon: const Icon(
                                              Icons.add_photo_alternate)),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("โรงปลูก :", true, _ctlGHName),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("รอบที่ปลูก :", true, _ctlCulNo),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("วันที่บันทึก :", true, _ctlCheckDate),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("หมายเลขกระถาง :", true, _ctlPotId),
                            const SizedBox(
                              height: 15,
                            ),
                            //buildBox("สถานะปัจจุบัน :", false, _ctlPlantStatus),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "สถานะ :",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 240, 239, 239),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: DropdownButton(
                                    dropdownColor: Colors.white,
                                    iconSize: 30,
                                    isExpanded: true,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                    hint: Text(
                                      plantStatus,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    value: dropdownStatus,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: itemStatus.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      //dropdownStatus = newValue!;
                                      setState(
                                        () {
                                          dropdownStatus = newValue!;
                                          // if (dropdownStatus == null) {
                                          //   selectdropdownStatus = status;
                                          // } else
                                          if (dropdownStatus == "ปกติ") {
                                            selectdropdownStatus = "01";
                                          } else if (dropdownStatus ==
                                              "ไม่สมบูรณ์") {
                                            selectdropdownStatus = "02";
                                          } else if (dropdownStatus ==
                                              "ตัดทิ้ง") {
                                            selectdropdownStatus = "03";
                                          } else {
                                            selectdropdownStatus = "00";
                                          }
                                          print(selectdropdownStatus);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            // buildBox(
                            //     "ความชื้นของดิน :", false, _ctlSoilMoisture),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "ความชื้นในดิน :",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 240, 239, 239),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: DropdownButton(
                                    dropdownColor: Colors.white,
                                    iconSize: 30,
                                    isExpanded: true,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                    hint: Text(
                                      soilMoisture,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    value: dropdownSoi,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: itemSoi.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(
                                        () {
                                          dropdownSoi = newValue!;
                                          if (dropdownSoi == "ดินชิ้นเหมาะสม") {
                                            selectdropdownSoi = "01";
                                          } else if (dropdownSoi ==
                                              "ดินชื้นมาก ไม่มีผลต่อการเจริญเติบโต") {
                                            selectdropdownSoi = "02";
                                          } else if (dropdownSoi ==
                                              "ดินชื้นมาก มีผลต่อการเจริญเติบโต") {
                                            selectdropdownSoi = "03";
                                          } else if (dropdownSoi ==
                                              "ดินแห้ง พบต้นเหี่ยวช่วงบ่าย") {
                                            selectdropdownSoi = "04";
                                          } else if (dropdownSoi ==
                                              "ดินแห้ง ไม่พบต้นเหี่ยวช่วงบ่าย") {
                                            selectdropdownSoi = "05";
                                          } else {
                                            selectdropdownSoi = "00";
                                          }
                                          print(selectdropdownSoi);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("หมายเหตุ(ความชื้นของดิน) :", false,
                                _ctlSoilRemark),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("หมายเหตุ :", false, _ctlRemark),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("โรคที่พบ :", false, _ctlDisease),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("วิธีแก้ไข :", false, _ctlFixDisease),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("แมลงที่พบ :", false, _ctlInsect),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("วิธีแก้ไข :", false, _ctlFixInsect),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("เก็บซาก :", false, _ctlWeight),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("วันที่เก็บซาก :", false, _ctlLogtime),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox(
                                "เหตุผลที่เก็บซาก :", false, _ctlTrashRemark),
                            const SizedBox(
                              height: 15,
                            ),
                            // buildBox("หมายเหตุ :", false, _ctlRemark),
                            // const SizedBox(
                            //   height: 15,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          textStyle: TextStyle(fontSize: 18),
                                          primary:
                                              Color.fromARGB(255, 10, 94, 3),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          padding: const EdgeInsets.all(15)),
                                      onPressed: () {
                                        //ส่งค่าจากปุ่มบันทึก
                                        selectdropdownStatus ??= '0' + status;
                                        selectdropdownSoi ??= '0' + Soil;
                                        String urlPathImage = result[0].fileName;
                                       
                                        // dialog.normalDialog(
                                        //     context,
                                        //     selectdropdownStatus.toString() +
                                        //         selectdropdownSoi.toString());
                                        //confirmDialog();
                                        showDialog(
                                          context: context,
                                          builder: (context) => SimpleDialog(
                                            title: Text("ยืนยันการแก้ไขข้อมูล"),
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  OutlinedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        EditData(
                                                            selectdropdownStatus,
                                                            selectdropdownSoi,
                                                            _ctlSoilRemark,
                                                            _ctlRemark,
                                                            _ctlDisease,
                                                            _ctlFixDisease,
                                                            _ctlInsect,
                                                            _ctlFixInsect,
                                                            _ctlWeight,
                                                            _ctlLogtime,
                                                            _ctlTrashRemark,
                                                            urlPathImage);
                                                      },
                                                      child:
                                                          const Text('ยืนยัน')),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  OutlinedButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: Text('ยกเลิก'))
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      child: Text("บันทึก"),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Column(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          textStyle: TextStyle(fontSize: 18),
                                          primary:
                                              Color.fromARGB(255, 197, 16, 4),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          padding: const EdgeInsets.all(15)),
                                      onPressed: () {
                                        dialog.showDialogCancel(context);
                                      },
                                      child: Text("ยกเลิก"),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ]),
                    ),
                  )
                ],
              )
            ]));
          }
          return const LinearProgressIndicator();
        },
      ),
    );
  }

  Future<dynamic> showMessage(String msg) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<Null> chooseImage(ImageSource source) async {
    var object = await ImagePicker()
        .pickImage(source: source, maxWidth: 800.0, maxHeight: 800.0);
    if (object != null) {
      setState(() {
        file = File(object.path);
        //print(file);
      });
    }
  }

  Widget buildBox(String title, readonly, controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            readOnly: readonly,
            controller: controller,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 15),
              hintText: "",
              // hintStyle: TextStyle(color: Colors.black38, fontSize: 18)
            ),
          ),
        )
      ],
    );
  }

  Future<Null> confirmDialog() async {}

  bool _visible = false;
  Future<Null> EditData(
      selectdropdownStatus,
      selectdropdownSoi,
      _ctlSoilRemark,
      _ctlRemark,
      _ctlDisease,
      _ctlFixDisease,
      _ctlInsect,
      _ctlFixInsect,
      _ctlWeight,
      TrashLogTime,
      _ctlTrashRemark,
      urlPathImage) async {
    String url = hostAPI + "/trackings/editPlanttracking";
    var response = await http.put(Uri.parse(url), body: {
      "PlantTrackingID": widget.PlantrackingID,
      "PlantStatus": selectdropdownStatus.toString(),
      "SoilMoisture": selectdropdownSoi.toString(),
      "SoilRemark": _ctlSoilRemark.text,
      "Remark": _ctlRemark.text,
      "Disease": _ctlDisease.text,
      "FixDisease": _ctlFixDisease.text,
      "Insect": _ctlInsect.text,
      "FixInsect": _ctlFixInsect.text,
      "Weight": _ctlWeight.text,
      "LogTime": TrashLogTime.toString(),
      "TrashRemark": _ctlTrashRemark.text,
      // "RemarkTrash_log": _ctlRemarkTrash_log.text,
      "ImageFileName": urlPathImage.toString(),
      "UpdateBy": widget.UserID,
    });
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
    if (response.statusCode == 200) {
      print(response.body);
      var msg = jsonDecode(response.body);

      //Check Login Status
      if (msg['success'] == true) {
        setState(() {
          //hide progress indicator
          _visible = false;
        });
        showMessage(msg["message"]);

        ///Clear();
      } else {
        setState(() {
          //hide progress indicator
          _visible = false;

          //Show Error Message Dialog
          showMessage(msg["message"]);
        });
        //showMessage(context, 'เกิดข้อผิดพลาด');
      }
    } else {
      setState(() {
        //hide progress indicator
        _visible = false;

        //Show Error Message Dialog
        showMessage("Error during connecting to Server.");
      });
    }
  }
}
