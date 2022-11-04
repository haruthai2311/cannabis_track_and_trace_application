import 'dart:convert';
import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:cannabis_track_and_trace_application/widget/forminput.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../api/allharvests.dart';
import '../../../api/hostapi.dart';

class AddTransfers extends StatefulWidget {
  final String UserID;
  const AddTransfers({Key? key, required this.UserID}) : super(key: key);

  @override
  State<AddTransfers> createState() => _AddTransfersState();
}

class _AddTransfersState extends State<AddTransfers> {
  DateTime date = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  bool _visible = false;
  late List<Harvests> _Harvests;

  final _ctlWeight = TextEditingController();
  final _ctlLotNo = TextEditingController();
  final _ctlGetByName = TextEditingController();
  final _ctlGetByPlate = TextEditingController();
  final _ctlLicenseNo = TextEditingController();
  final _ctlLicensePlate = TextEditingController();
  final _ctlTrackRemake = TextEditingController();
  final _ctlHarvestNo = TextEditingController();

  void Clear() {
    _ctlWeight.clear();
    _ctlLotNo.clear();
    _ctlGetByName.clear();
    _ctlGetByPlate.clear();
    _ctlLicenseNo.clear();
    _ctlLicensePlate.clear();
    _ctlTrackRemake.clear();
    dropdowntype = 'N/A';
    dropdownHvtID = 'N/A';
  }

  Future addTransfers() async {
    var url = hostAPI + "/trackings/transfers";
    // Showing LinearProgressIndicator.
    setState(() {
      _visible = true;
    });

    var response = await http.post(Uri.parse(url), body: {
      "HarvestID": dropdownHvtID.toString(),
      "TransferDate": date.toString(),
      "Type": selectDropdown.toString(),
      "Weight": _ctlWeight.text,
      "LotNo": _ctlLotNo.text,
      "GetByName": _ctlGetByName.text,
      "GetByPlace": _ctlGetByPlate.text,
      "LicenseNo": _ctlLicenseNo.text,
      "LicensePlate": _ctlLicensePlate.text,
      "Remark": _ctlTrackRemake.text,
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

  Future getData() async {
    var url = hostAPI + "/trackings/getHarvests";
    var response = await http.get(Uri.parse(url));
    _Harvests = harvestsFromJson(response.body);

    return _Harvests;
  }

  String dropdowntype = 'N/A';
  String selectDropdown = '00';
  var itemtype = ['N/A', 'ใบ', 'ดอก', 'ก้าน'];

  String dropdownHvtID = 'N/A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
        backgroundColor: kBackground,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.save_as_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              addTransfers();
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
              var result = snapshot.data;
              var itemHvtID = ['N/A'];
              for (var i = 0; i < result.length; i++) {
                itemHvtID.add(result[i].harvestId.toString());
              }
              print(itemHvtID);

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
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
                          "บันทึกข้อมูลการส่งมอบ",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Divider(
                            height: 24,
                            thickness: 2,
                            color: Color(0xFFF1F4F8),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "หมายเลขการเก็บเกี่ยว :",
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
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  dropdownColor: Colors.white,
                                  iconSize: 30,
                                  isExpanded: true,
                                  style: const TextStyle(
                                    color: colorDetails2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  value: dropdownHvtID,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: itemHvtID.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(
                                      () {
                                        dropdownHvtID = newValue!;
                                        if (itemHvtID.indexOf(dropdownHvtID) ==
                                            0) {
                                          _ctlHarvestNo.text = "";
                                        } else {
                                          _ctlHarvestNo.text = result[itemHvtID
                                                      .indexOf(dropdownHvtID) -
                                                  1]
                                              .harvestNo
                                              .toString();
                                        }

                                        //print(itemHvtID.indexOf(dropdownHvtID));
                                        //print(result[itemHvtID.indexOf(dropdownHvtID) - 1].harvestNo.toString());
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        MyForm().buildformNum("ครั้งที่ : ", _ctlHarvestNo),
                        const SizedBox(height: 20),
                        buildTransferDate(),
                        const SizedBox(height: 20),
                        buildType(),
                        const SizedBox(height: 20),
                        MyForm().buildformNum("น้ำหนัก (kg) : ", _ctlWeight),
                        const SizedBox(height: 20),
                        MyForm().buildformNum("หมายเลขล็อต : ", _ctlLotNo),
                        const SizedBox(height: 20),
                        MyForm().buildform("ชื่อผู้รับ : ", _ctlGetByName),
                        const SizedBox(height: 20),
                        MyForm().buildform("ชื่อสถานที่ : ", _ctlGetByPlate),
                        const SizedBox(height: 20),
                        MyForm()
                            .buildformNum("เลขที่ใบอนุญาต : ", _ctlLicenseNo),
                        const SizedBox(height: 20),
                        MyForm()
                            .buildformNum("ป้ายทะเบียนรถ : ", _ctlLicensePlate),
                        const SizedBox(height: 20),
                        MyForm()
                            .buildformRemake("หมายเหตุ : ", _ctlTrackRemake),
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
                        //             addTransfers();
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
                        //             canceldialog.showDialogCancel(context);
                        //           },
                        //           child: Text("ยกเลิก"),
                        //         ),
                        //       ],
                        //     )
                        //  ],
                        //),
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

  Widget buildTransferDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "วันที่ :",
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

  Widget buildType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ประเภท :",
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
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              dropdownColor: Colors.white,
              iconSize: 30,
              isExpanded: true,
              style: const TextStyle(
                color: colorDetails2,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
              value: dropdowntype,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: itemtype.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(
                  () {
                    dropdowntype = newValue!;
                    if (dropdowntype == "N/A") {
                      selectDropdown = "00";
                    } else if (dropdowntype == "ใบ") {
                      selectDropdown = "01";
                    } else if (dropdowntype == "ดอก") {
                      selectDropdown = "02";
                    } else {
                      selectDropdown = "03";
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildHarvestNo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ครั้งที่ :",
          style: TextStyle(
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
            readOnly: true,
            controller: _ctlHarvestNo,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: '',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Widget buildweight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "น้ำหนัก (kg) :",
          style: TextStyle(
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
            controller: _ctlWeight,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: 'ระบุน้ำหนัก',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Widget buildLotNo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "หมายเลขล๊อต :",
          style: TextStyle(
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
            controller: _ctlLotNo,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: 'ระบุ',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Widget buildGetByName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ชื่อผู้รับ :",
          style: TextStyle(
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
            controller: _ctlGetByName,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: 'กรอกชื่อผู้รับ',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Widget buildGetByPlate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ชื่อสถานที่ :",
          style: TextStyle(
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
            controller: _ctlGetByPlate,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: 'กรอกชื่อสถานที่',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Widget buildLicenseNo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "เลขที่ใบอนุญาต :",
          style: TextStyle(
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
            controller: _ctlLicenseNo,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: 'ระบุ',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Widget buildLicensePlate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ป้ายทะเบียนรถ :",
          style: TextStyle(
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
            controller: _ctlLicensePlate,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: 'ระบุ',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Widget buildTrackRemake() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "หมายเหตุ :",
          style: TextStyle(
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
            controller: _ctlTrackRemake,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: '**หมายเหตุ**',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }
}
