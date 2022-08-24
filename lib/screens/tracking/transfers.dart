import 'dart:convert';
import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../api/allharvests.dart';
import '../../api/hostapi.dart';

class Transfers extends StatefulWidget {
  @override
  State<Transfers> createState() => _TransfersState();
}

class _TransfersState extends State<Transfers> {
  DateTime date = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  bool _visible = false;
  late List<AllHarvests> _allHarvests;

  final _ctlHavestID = TextEditingController();
  final _ctlWeight = TextEditingController();
  final _ctlLotNo = TextEditingController();
  final _ctlGetByName = TextEditingController();
  final _ctlGetByPlate = TextEditingController();
  final _ctlLicenseNo = TextEditingController();
  final _ctlLicensePlate = TextEditingController();
  final _ctlTrackRemake = TextEditingController();

  void Clear() {
    _ctlHavestID.clear();
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

  Future<List<AllHarvests>> getAllHarvests() async {
    var url = hostAPI + "/trackings/getHarvests";
    var response = await http.get(Uri.parse(url));
    _allHarvests = allHarvestsFromJson(response.body);

    return _allHarvests;
  }

  String dropdowntype = 'N/A';
  String selectDropdown = '00';
  var itemtype = ['N/A', 'ใบ', 'ดอก', 'ก้าน'];

  String dropdownHvtID = 'N/A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: kBackground),
        body: FutureBuilder(
          future: getAllHarvests(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var result = snapshot.data;
              var itemHvtID = ['N/A'];
              for (var i = 0; i < result.length; i++) {
                itemHvtID.add(result[i].harvestId.toString());
              }
              print(itemHvtID);

              return SafeArea(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            "บันทึกข้อมูลการส่งมอบ",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 8, 143, 114)),
                          ),
                          const SizedBox(height: 50),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "หมายเลขการเก็บเกี่ยว :",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Container(
                                margin: EdgeInsets.only(left: 15, right: 15),
                                padding: EdgeInsets.only(left: 15, right: 15),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 240, 239, 239),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
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
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
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
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          buildTransferDate(),
                          const SizedBox(height: 20),
                          buildType(),
                          const SizedBox(height: 20),
                          buildweight(),
                          const SizedBox(height: 20),
                          buildLotNo(),
                          const SizedBox(height: 20),
                          buildGetByName(),
                          const SizedBox(height: 20),
                          buildGetByPlate(),
                          const SizedBox(height: 20),
                          buildLicenseNo(),
                          const SizedBox(height: 20),
                          buildLicensePlate(),
                          const SizedBox(height: 20),
                          buildTrackRemake(),
                          const SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        textStyle: TextStyle(fontSize: 18),
                                        primary: Color.fromARGB(255, 10, 94, 3),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        padding: const EdgeInsets.all(15)),
                                    onPressed: () {
                                      addTransfers();
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
                                      _showDialogCancel();
                                    },
                                    child: Text("ยกเลิก"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return LinearProgressIndicator();
          },
        ));
  }

  Future<void> _showDialogCancel() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ยืนยันการยกเลิก'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('คุณต้องการยกเลิกใช่หรือไม่?'),
                //Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ยืนยัน'),
              onPressed: () {
                //print('Confirmed');
                Navigator.of(context).pop();
                Navigator.of(context).pop(Transfers());
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

  Widget buildTransferDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "วันที่ :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          padding: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${date.year}/${date.month}/${date.day}',
                //'${date.day}/${date.month}/${date.year}',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              OutlinedButton(
                child: Icon(Icons.date_range_outlined),
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
                  shape: StadiumBorder(),
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
                  textStyle: TextStyle(fontSize: 16),
                  primary: Color.fromARGB(255, 10, 91, 97),
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
        Text(
          "ประเภท :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          padding: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
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
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
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
      ],
    );
  }

  Widget buildweight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "น้ำหนัก (kg) :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: _ctlWeight,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
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
        Text(
          "หมายเลขล๊อต :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: _ctlLotNo,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
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
        Text(
          "ชื่อผู้รับ :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: _ctlGetByName,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
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
        Text(
          "ชื่อสถานที่ :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: _ctlGetByPlate,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
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
        Text(
          "เลขที่ใบอนุญาต :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: _ctlLicenseNo,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
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
        Text(
          "ป้ายทะเบียนรถ :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: _ctlLicensePlate,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
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
        Text(
          "หมายเหตุ :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: _ctlTrackRemake,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
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
