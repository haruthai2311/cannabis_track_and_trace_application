import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../../api/hostapi.dart';
import '../../../api/planttracking.dart';
import '../../../config/styles.dart';
import '../../../widget/dialog.dart';

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

  final _ctlRemark = TextEditingController();
  final _ctlSoilRemark = TextEditingController();
  final _ctlDisease = TextEditingController();
  final _ctlFixDisease = TextEditingController();
  final _ctlInsect = TextEditingController();
  final _ctlFixInsect = TextEditingController();
  final _ctlWeight = TextEditingController();
  final _ctlTrashRemark = TextEditingController();

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
  }

  final f = DateFormat('dd/MM/yyyy  hh:mm:ss');

  String? selectdropdownStatus;
  String? dropdownStatus;
  var itemStatus = ['N/A', 'ปกติ', 'ไม่สมบูรณ์ ', 'ตัดทิ้ง'];

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
  String? urlPathImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.save_as_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              confirmDialog();
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: getPlanttracking(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              Container();
            }
            var result = snapshot.data;

            String plantStatus;

            String status = result[0].plantStatus.toString();
            if (status == "1") {
              plantStatus = "ปกติ";
            } else if (status == "2") {
              plantStatus = "ไม่สมบูรณ์ ";
            } else if (status == "3") {
              plantStatus = "ตัดทิ้ง";
            } else {
              plantStatus = "N/A";
            }

            String SoilMoisture;
            String Soil = result[0].soilMoisture.toString();
            if (Soil == "1") {
              SoilMoisture = "ดินชิ้นเหมาะสม";
            } else if (Soil == "2") {
              SoilMoisture = "ดินชื้นมาก ไม่มีผลต่อการเจริญเติบโต";
            } else if (Soil == "3") {
              SoilMoisture = "ดินชื้นมาก มีผลต่อการเจริญเติบโต";
            } else if (Soil == "4") {
              SoilMoisture = "ดินแห้ง พบต้นเหี่ยวช่วงบ่าย";
            } else if (Soil == "5") {
              SoilMoisture = "ดินแห้ง ไม่พบต้นเหี่ยวช่วงบ่าย";
            } else {
              SoilMoisture = "N/A";
            }
            // final _ctlSoilMoisture =
            //    TextEditingController(text: SoilMoisture);
            // if (dropdownStatus == null) {
            //   selectdropdownStatus = status;
            // }
            selectdropdownStatus ??= '0' + status;
            selectdropdownSoi ??= '0' + Soil;
            if (file == null) {
              urlPathImage = result[0].fileName;
            }

            _ctlSoilRemark.text = result[0].soilRemark;
            _ctlDisease.text = result[0].disease;
            _ctlFixDisease.text = result[0].fixDisease;
            _ctlInsect.text = result[0].insect;
            _ctlFixInsect.text = result[0].fixInsect;
            _ctlWeight.text = result[0].weight.toString() + ' Kg';
            _ctlTrashRemark.text = result[0].trashRemark;
            _ctlRemark.text = result[0].remark;

            return SingleChildScrollView(
                child: Stack(
              children: <Widget>[
                Stack(
                  children: [
                    GestureDetector(
                      child: file == null
                          ? Image.network(
                              hostAPI + result[0].fileName,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.5,
                            )
                          : Image.file(file!),
                      //*คลิกดูรูปใหญ่*//
                      // onTap: () {
                      //   Navigator.push(context, MaterialPageRoute(builder: (_) {
                      //     return DetailScreen();
                      //   }));
                      // },
                    ),
                    Positioned(
                      top: 300,
                      left: 10,
                      right: 10,
                      bottom: 10,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  //alignment: Alignment.bottomRight,
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: IconButton(
                                    onPressed: ((() =>
                                        chooseImage(ImageSource.camera))),
                                    icon: const Icon(
                                      Icons.add_a_photo,
                                    ),
                                    color:
                                        const Color.fromARGB(255, 2, 184, 144),
                                    iconSize: 25,
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                  //alignment: Alignment.bottomRight,
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: IconButton(
                                    onPressed: ((() =>
                                        chooseImage(ImageSource.gallery))),
                                    icon: const Icon(
                                      Icons.add_photo_alternate,
                                    ),
                                    color:
                                        const Color.fromARGB(255, 2, 184, 144),
                                    iconSize: 25,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 350.0, 0.0, 0.0),
                  child: Container(
                    //height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Material(
                      borderRadius: BorderRadius.circular(35.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),

                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            child: Text(
                                              "โรงปลูก : ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              result[0].ghName.toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: <Widget>[
                                          const Expanded(
                                            child: Text(
                                              "รอบปลูก :",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              result[0].no.toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),

                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Expanded(
                                      child: Text(
                                        "หมายเลขกระถาง :",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        result[0].potsName.toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),

                                //buildBox("รอบที่ปลูก :", _ctlCulNo),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Text(
                                      "วันที่บันทึก : ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      f.format(result[0].checkDate).toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),

                                //buildBox("วันที่บันทึก :", _ctlCheckDate),
                                const SizedBox(
                                  height: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "สถานะ :",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal),
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
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
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
                                                  "ไม่สมบูรณ์ ") {
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
                                          fontWeight: FontWeight.normal),
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
                                          SoilMoisture,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        value: dropdownSoi,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
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
                                              if (dropdownSoi ==
                                                  "ดินชิ้นเหมาะสม") {
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
                                Row(
                                  children: const [
                                    Text(
                                      "การเก็บซาก ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Text(
                                      "วันที่เก็บซาก : ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      f.format(result[0].logTime).toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                buildBox("เก็บซาก :", false, _ctlWeight),
                                const SizedBox(
                                  height: 15,
                                ),

                                buildBox("เหตุผลที่เก็บซาก :", false,
                                    _ctlTrashRemark),

                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ));
          }
          return const LinearProgressIndicator();

          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.end,
          //                     children: [
          //                       Column(
          //                         children: [
          //                           ElevatedButton(
          //                             style: ElevatedButton.styleFrom(
          //                                 textStyle: TextStyle(fontSize: 18),
          //                                 primary:
          //                                     Color.fromARGB(255, 10, 94, 3),
          //                                 shape: RoundedRectangleBorder(
          //                                     borderRadius:
          //                                         BorderRadius.circular(30)),
          //                                 padding: const EdgeInsets.all(15)),
          //                             onPressed: () {
          //                               //ส่งค่าจากปุ่มบันทึก
          //                               selectdropdownStatus ??= '0' + status;
          //                               selectdropdownSoi ??= '0' + Soil;
          //                               String urlPathImage =
          //                                   result[0].fileName;

          //                               // dialog.normalDialog(
          //                               //     context,
          //                               //     selectdropdownStatus.toString() +
          //                               //         selectdropdownSoi.toString());
          //                               //confirmDialog();
          //                               showDialog(
          //                                 context: context,
          //                                 builder: (context) => SimpleDialog(
          //                                   title: Text("ยืนยันการแก้ไขข้อมูล"),
          //                                   children: <Widget>[
          //                                     Row(
          //                                       mainAxisAlignment:
          //                                           MainAxisAlignment.center,
          //                                       children: <Widget>[
          //                                         OutlinedButton(
          //                                             onPressed: () {
          //                                               Navigator.pop(context);
          //                                               EditData(
          //                                                   selectdropdownStatus,
          //                                                   selectdropdownSoi,
          //                                                   _ctlSoilRemark,
          //                                                   _ctlRemark,
          //                                                   _ctlDisease,
          //                                                   _ctlFixDisease,
          //                                                   _ctlInsect,
          //                                                   _ctlFixInsect,
          //                                                   _ctlWeight,
          //                                                   _ctlLogtime,
          //                                                   _ctlTrashRemark,
          //                                                   urlPathImage);
          //                                             },
          //                                             child:
          //                                                 const Text('ยืนยัน')),
          //                                         const SizedBox(
          //                                           width: 5,
          //                                         ),
          //                                         OutlinedButton(
          //                                             onPressed: () =>
          //                                                 Navigator.pop(
          //                                                     context),
          //                                             child: Text('ยกเลิก'))
          //                                       ],
          //                                     )
          //                                   ],
          //                                 ),
          //                               );
          //                             },
          //                             child: Text("บันทึก"),
          //                           ),
          //                         ],
          //                       ),
        },
      ),
    );
  }

  Future<Null> confirmDialog() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ยืนยันการแก้ไข'),
          content: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                Text('กรุณากดยืนยันเพื่อดำเนินการแก้ไข'),
                //Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ยืนยัน'),
              onPressed: () {
                EditData();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal),
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

  bool _visible = false;
  Future<Null> EditData() async {
    if (file == null) {
      String url = hostAPI + "/trackings/editPlanttracking";
      // Showing LinearProgressIndicator.
      setState(() {
        _visible = true;
      });

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
        "TrashRemark": _ctlTrashRemark.text,
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
          //showMessage(msg["message"]);
          Navigator.pop(context);

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
    } else {
      Random random = Random();
      int i = random.nextInt(10000000);
      String nameFile = 'EditImage$i.jpg';

      String urlupload = hostAPI + "/upload/uploadimage";
      var formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(file!.path, filename: nameFile)
      });
      var response =
          await Dio().post(urlupload, data: formData).then((value) async {
        String urlPathImage = '/$nameFile';
        print('urlPathImage = $hostAPI$urlPathImage');

        String url = hostAPI + "/trackings/editPlanttracking";
        // Showing LinearProgressIndicator.
        setState(() {
          _visible = true;
        });

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
          "TrashRemark": _ctlTrashRemark.text,
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
            //showMessage(msg["message"]);
            Navigator.pop(context);

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
      });
    }
  }
}

class DetailScreen extends StatelessWidget {
  // final String Image;
  // const DetailScreen({Key? key, required this.Image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Image.network(
            hostAPI + "/Image757337.jpg",
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}