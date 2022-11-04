import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cannabis_track_and_trace_application/api/hostapi.dart';
import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:cannabis_track_and_trace_application/widget/forminput.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../api/allgreenhouses.dart';
import '../../../api/getPots.dart';
import '../../../widget/dialog.dart';

class PlantTracking extends StatefulWidget {
  final String UserID;
  const PlantTracking({Key? key, required this.UserID}) : super(key: key);

  @override
  State<PlantTracking> createState() => _PlantTrackingState();
}

class _PlantTrackingState extends State<PlantTracking> {
  final dialog = MyDialog();
  DateTime date = DateTime.now();
  DateTime TrashLogTime = DateTime.now();
  late List<AllGreenhouses> _allGreenhouses;
  late List<GetPots> _getPots;
  File? file; //เก็บภาพจากการถ่ายและจากแกลเลอรี่
  bool _visible = false;

  final _ctlPlantStatus = TextEditingController();
  final _ctlSoilMoisture = TextEditingController();
  final _ctlRemark = TextEditingController();
  final _ctlSoilRemark = TextEditingController();
  final _ctlDisease = TextEditingController();
  final _ctlFixDisease = TextEditingController();
  final _ctlInsect = TextEditingController();
  final _ctlFixInsect = TextEditingController();
  final _ctlImageFileName = TextEditingController();
  final _ctlCheckDateTime = TextEditingController();
  final _ctlWeight = TextEditingController();
  final _ctlTrashRemark = TextEditingController();
  final _ctlRemarkTrash_log = TextEditingController();

  void Clear() {
    dropdownPotID = 'N/A';
    _ctlPlantStatus.clear();
    _ctlSoilMoisture.clear();
    _ctlRemark.clear();
    _ctlSoilRemark.clear();
    _ctlDisease.clear();
    _ctlFixDisease.clear();
    _ctlInsect.clear();
    _ctlFixInsect.clear();
    _ctlImageFileName.clear();
    _ctlCheckDateTime.clear();
    _ctlWeight.clear();
    _ctlTrashRemark.clear();
    _ctlRemarkTrash_log.clear();
    file = null;
    dropdownGH = 'N/A';
    dropdownStatus = 'N/A';
    dropdownSoi = 'N/A';
  }

  Future<Null> uploadImageAndInsertData() async {
    String urlupload = hostAPI + "/upload/uploadimage";
    Random random = Random();
    int i = random.nextInt(10000000);
    String nameFile = 'Image$i.jpg';

    var formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file!.path, filename: nameFile)
    });
    var response =
        await Dio().post(urlupload, data: formData).then((value) async {
      String urlPathImage = '/$nameFile';
      print('urlPathImage = $hostAPI$urlPathImage');

      var url = hostAPI + "/trackings/planttrackings";
      // Showing LinearProgressIndicator.
      setState(() {
        _visible = true;
      });

      var response = await http.post(Uri.parse(url), body: {
        "nameGreenHouse": dropdownGH.toString(),
        "CheckDate": date.toString(),
        "PotID": dropdownPotID.toString(),
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
        "RemarkTrash_log": _ctlRemarkTrash_log.text,
        "ImageFileName": urlPathImage.toString(),
        "CreateBy": widget.UserID,
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
          Clear();
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
    });
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

  @override
  void initState() {
    super.initState();
  }

  String NameGHParameters = '';
  Future getData() async {
    var url = hostAPI + '/informations/getAllGreenhouses';
    var response = await http.get(Uri.parse(url));
    _allGreenhouses = allGreenhousesFromJson(response.body);

    var urlPots = hostAPI + '/informations/getPots' + NameGHParameters;
    print(urlPots);
    var responsePots = await http.get(Uri.parse(urlPots));
    _getPots = getPotsFromJson(responsePots.body);

    return [_allGreenhouses, _getPots];
  }

  String selectdropdownStatus = 'N/A';
  String dropdownStatus = 'N/A';
  var itemStatus = ['N/A', 'ปกติ', 'ไม่สมบูรณ์ ', 'ตัดทิ้ง'];

  String dropdownGH = 'N/A';
  //var itemGH = ['N/A', 'โรงเรือน 1', 'โรงเรือน 2'];
  String dropdownPotID = 'N/A';
  //var itemPotID = ['N/A', '1', '2', '3'];
  String selectdropdownSoi = 'N/A';
  String dropdownSoi = 'N/A';
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
        title: Text('Plant Tracking'),
        backgroundColor: kBackground,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.save_as_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              if (file == null) {
                dialog.normalDialog(context, 'กรุณาเลือกรูปภาพ');
              } else {
                uploadImageAndInsertData();
              }
            },
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kBackground,
              Colors.white60,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // if (snapshot.data == null) {
              //   Container();
              // }
              if (snapshot.data == null) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(
                        child: Text(
                          'ไม่พบข้อมูลตั้งต้น',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 143, 8, 8)),
                        ),
                      ),
                    ));
              }
              var result1 = snapshot.data[0];
              var result2 = snapshot.data[1];
              var itemGH = ['N/A'];
              for (var i = 0; i < result1.length; i++) {
                //print(result[i].newCase);
                itemGH.add(result1[i].name);
                //print(casenewsort);
              }
              print(itemGH);
              var itemPotID = ['N/A'];
              for (var i = 0; i < result2.length; i++) {
                //print(result[i].newCase);
                itemPotID.add(result2[i].potId.toString());
                //print(casenewsort);
              }
              print(itemPotID);

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 20),
                          child: Container(
                            width: 60,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Color(0xFFDBE2E7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const Text(
                          "บันทึกผลตรวจประจำวัน",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink),
                        ),
                        const SizedBox(height: 30),
                        buildImages(),
                        const SizedBox(height: 20),
                        //โรงปลูก
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "โรงปลูก :",
                              style: const TextStyle(
                                color: colorDetails3,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Color.fromARGB(255, 238, 238, 240),
                                  width: 2,
                                ),
                              ),
                              child: DropdownButton(
                                dropdownColor: Colors.white,
                                iconSize: 30,
                                isExpanded: true,
                                style: const TextStyle(
                                  color: colorDetails2,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                                value: dropdownGH,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: itemGH.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(
                                    () {
                                      dropdownGH = newValue!;
                                      NameGHParameters =
                                          "?NameGH=" + dropdownGH;
                                      dropdownPotID = 'N/A';
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // buildPlantNo(),
                        // const SizedBox(height: 20),
                        buildCheckDate(),
                        const SizedBox(height: 20),
                        //หมายเลขกระถาง
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "หมายเลขกระถาง :",
                              style: const TextStyle(
                                color: colorDetails3,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Color.fromARGB(255, 238, 238, 240),
                                  width: 2,
                                ),
                              ),
                              child: DropdownButton(
                                dropdownColor: Colors.white,
                                iconSize: 30,
                                isExpanded: true,
                                style: const TextStyle(
                                  color: colorDetails2,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                                value: dropdownPotID,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: itemPotID.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(
                                    () {
                                      dropdownPotID = newValue!;
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        buildPlantStatus(),
                        const SizedBox(height: 20),
                        MyForm().buildformSection(
                            'การสำรวจดิน', Icons.grass, Colors.brown),
                        const SizedBox(height: 20),
                        buildSoiMoisture(),
                        const SizedBox(height: 20),
                        MyForm().buildform("** หมายเหตุ : ", _ctlSoilRemark),
                        const SizedBox(height: 20),
                        MyForm().buildformSection(
                            'การสำรวจโรค', Icons.coronavirus, Colors.purple),
                        const SizedBox(height: 20),
                        MyForm().buildform("โรคที่พบ : ", _ctlDisease),
                        const SizedBox(height: 20),
                        MyForm().buildform(
                            "การแก้ไขที่ทำไปแล้ว : ", _ctlFixDisease),
                        const SizedBox(height: 20),
                        MyForm().buildformSection(
                          'การสำรวจแมลง',
                          Icons.emoji_nature,
                          Color.fromARGB(255, 2, 88, 158),
                        ),
                        const SizedBox(height: 20),
                        MyForm().buildform("แมลงที่พบ : ", _ctlInsect),
                        const SizedBox(height: 20),
                        MyForm()
                            .buildform("การแก้ไขที่ทำไปแล้ว : ", _ctlFixInsect),
                        const SizedBox(height: 20),
                        MyForm().buildformSection('การเก็บซาก',
                            Icons.auto_delete, Color.fromARGB(255, 1, 126, 12)),
                        const SizedBox(height: 20),
                        MyForm().buildformNum("น้ำหนัก (kg) : ", _ctlWeight),
                        const SizedBox(height: 20),
                        buildTrashLogTime(),
                        const SizedBox(height: 20),
                        MyForm()
                            .buildform("เหตุผลที่เก็บซาก : ", _ctlTrashRemark),
                        const SizedBox(height: 20),
                        MyForm().buildform("** หมายเหตุ : ", _ctlTrashRemark),
                        const SizedBox(height: 30),
                        MyForm().buildformRemake("หมายเหตุ : ", _ctlRemark),
                        const SizedBox(height: 20),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     Column(
                        //       children: [
                        //         ElevatedButton(
                        //           style: ElevatedButton.styleFrom(
                        //               textStyle: TextStyle(fontSize: 18),
                        //               primary: Color.fromARGB(255, 10, 94, 3),
                        //               shape: RoundedRectangleBorder(
                        //                   borderRadius:
                        //                       BorderRadius.circular(30)),
                        //               padding: const EdgeInsets.all(15)),
                        //           onPressed: () {
                        //             if (file == null) {
                        //               dialog.normalDialog(
                        //                   context, 'กรุณาเลือกรูปภาพ');
                        //             } else {
                        //               uploadImageAndInsertData();
                        //             }
                        //           },
                        //           child: Text("บันทึก"),
                        //         ),
                        //       ],
                        //     ),
                        //     SizedBox(width: 10),
                        //     Column(
                        //       children: [
                        //         ElevatedButton(
                        //           style: ElevatedButton.styleFrom(
                        //               textStyle: TextStyle(fontSize: 18),
                        //               primary:
                        //                   Color.fromARGB(255, 197, 16, 4),
                        //               shape: RoundedRectangleBorder(
                        //                   borderRadius:
                        //                       BorderRadius.circular(30)),
                        //               padding: const EdgeInsets.all(15)),
                        //           onPressed: () {
                        //             dialog.showDialogCancel(context);
                        //           },
                        //           child: Text("ยกเลิก"),
                        //         ),
                        //       ],
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const LinearProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget buildImages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200,
          // decoration:
          //     BoxDecoration(border: Border.all(color: Color(0xffC4C4C4))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: ((() => chooseImage(ImageSource.camera))),
                  icon: const Icon(
                    Icons.add_a_photo,
                  )),
              SizedBox(
                  width: 250,
                  //height: 190,
                  child: file == null
                      ? Image.asset(
                          "images/Group639.png",
                          fit: BoxFit.cover,
                        )
                      : Image.file(file!)),
              IconButton(
                  onPressed: (() => chooseImage(ImageSource.gallery)),
                  icon: const Icon(Icons.add_photo_alternate)),
            ],
          ),
        ),
      ],
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

  Widget buildCheckDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "วันที่บันทึก :",
          style: const TextStyle(
            color: colorDetails3,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Color.fromARGB(255, 238, 238, 240),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${date.year}/${date.month}/${date.day}',
                //'${date.day}/${date.month}/${date.year}',
                style: const TextStyle(
                  color: colorDetails2,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              OutlinedButton(
                child: const Icon(Icons.date_range_outlined),
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  //if "CANCEL" = null
                  if (newDate == null) return;
                  //if "OK" => DateTime
                  setState(() => date = newDate);
                },
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
                  textStyle: const TextStyle(fontSize: 16),
                  primary: const Color.fromARGB(255, 10, 91, 97),
                  //onPrimary: Colors.white
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPlantStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "สถานะ :",
          style: const TextStyle(
            color: colorDetails3,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Color.fromARGB(255, 238, 238, 240),
              width: 2,
            ),
          ),
          child: DropdownButton(
            dropdownColor: Colors.white,
            iconSize: 30,
            isExpanded: true,
            style: const TextStyle(
              color: colorDetails2,
              fontSize: 20,
              fontWeight: FontWeight.normal,
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
              setState(
                () {
                  dropdownStatus = newValue!;
                  if (dropdownStatus == "ปกติ") {
                    selectdropdownStatus = "01";
                  } else if (dropdownStatus == "ไม่สมบูรณ์") {
                    selectdropdownStatus = "02";
                  } else if (dropdownStatus == "ตัดทิ้ง") {
                    selectdropdownStatus = "03";
                  } else {
                    selectdropdownStatus = "00";
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  //ความชื้น
  Widget buildSoiMoisture() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ความชื้นในดิน :",
          style: const TextStyle(
            color: colorDetails3,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Color.fromARGB(255, 238, 238, 240),
              width: 2,
            ),
          ),
          child: DropdownButton(
            dropdownColor: Colors.white,
            iconSize: 30,
            isExpanded: true,
            style: const TextStyle(
              color: colorDetails2,
              fontSize: 20,
              fontWeight: FontWeight.normal,
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
                  } else if (dropdownSoi == "ดินแห้ง พบต้นเหี่ยวช่วงบ่าย") {
                    selectdropdownSoi = "04";
                  } else if (dropdownSoi == "ดินแห้ง ไม่พบต้นเหี่ยวช่วงบ่าย") {
                    selectdropdownSoi = "05";
                  } else {
                    selectdropdownSoi = "00";
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildTrashLogTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "วันที่เก็บซาก :",
          style: const TextStyle(
            color: colorDetails3,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Color.fromARGB(255, 238, 238, 240),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${TrashLogTime.year}/${TrashLogTime.month}/${TrashLogTime.day}',
                //'${date.day}/${date.month}/${date.year}',
                style: const TextStyle(
                  color: colorDetails2,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              OutlinedButton(
                child: const Icon(Icons.date_range_outlined),
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: TrashLogTime,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  //if "CANCEL" = null
                  if (newDate == null) return;
                  //if "OK" => DateTime
                  setState(() => TrashLogTime = newDate);
                },
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
                  textStyle: const TextStyle(fontSize: 16),
                  primary: const Color.fromARGB(255, 10, 91, 97),
                  //onPrimary: Colors.white
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
