import 'dart:convert';
import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:cannabis_track_and_trace_application/widget/forminput.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:form_field_validator/form_field_validator.dart';
import '../../../api/allgreenhouses.dart';
import '../../../api/hostapi.dart';
import '../../../widget/dialog.dart';

class AddHarvests extends StatefulWidget {
  final String UserID;
  const AddHarvests({Key? key, required this.UserID}) : super(key: key);
  @override
  State<AddHarvests> createState() => _AddHarvestsState();
}

class _AddHarvestsState extends State<AddHarvests> {
  late List<AllGreenhouses> _allGreenhouses;
  DateTime date = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  bool _visible = false;
  //late List<AllGreenhouses> _AllGreenhouses;

  final _ctlHarvestNo = TextEditingController();
  final _ctlWeight = TextEditingController();
  final _ctlLotNo = TextEditingController();
  final _ctlHavestRemake = TextEditingController();

  void Clear() {
    _ctlHarvestNo.clear();
    _ctlWeight.clear();
    _ctlLotNo.clear();
    _ctlHavestRemake.clear();
    dropdownGH = 'N/A';
    dropdowntype = 'N/A';
  }

  Future addHarvests() async {
    var url = hostAPI + "/trackings/harvests";
    // Showing LinearProgressIndicator.
    setState(() {
      _visible = true;
    });

    var response = await http.post(Uri.parse(url), body: {
      "GreenHouseName": dropdownGH.toString(),
      "HarvestDate": date.toString(),
      "HarvestNo": _ctlHarvestNo.text,
      "Type": selectDropdown.toString(),
      "Weight": _ctlWeight.text,
      "LotNo": _ctlLotNo.text,
      "Remark": _ctlHavestRemake.text,
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

  Future<List<AllGreenhouses>> getAllGreenhouses() async {
    var url = hostAPI + '/informations/getAllGreenhouses';
    var response = await http.get(Uri.parse(url));
    _allGreenhouses = allGreenhousesFromJson(response.body);
    //print(_allGreenhouses.result[0].name.toString());
    //print(_allGreenhouses.result[1].name.toString());
    return _allGreenhouses;
  }

  String dropdowntype = 'N/A';
  String selectDropdown = '00';
  var itemtype = ['N/A', 'ใบ', 'ดอก', 'ก้าน'];

  String dropdownGH = 'N/A';

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
              if (_formKey.currentState!.validate()) {
                addHarvests();
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
          future: getAllGreenhouses(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var result = snapshot.data;

              var nameGH = ['N/A'];
              for (var i = 0; i < result.length; i++) {
                //print(result[i].newCase);
                nameGH.add(result[i].name);
                //print(casenewsort);

                //

              }
              print(nameGH);

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  key: _formKey,
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
                          "บันทึกข้อมูลการเก็บเกี่ยว",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.green),
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
                                items: nameGH.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(
                                    () {
                                      dropdownGH = newValue!;
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        buildHarvestDate(),
                        const SizedBox(height: 20),
                        MyForm().buildform("ครั้งที่ : ", _ctlHarvestNo),
                        const SizedBox(height: 20),
                        buildType(),
                        const SizedBox(height: 20),
                        MyForm().buildform("น้ำหนัก : ", _ctlWeight),
                        const SizedBox(height: 20),
                        MyForm().buildform("หมายเลขล็อต : ", _ctlLotNo),
                        const SizedBox(height: 20),
                        MyForm()
                            .buildformRemake("หมายเหตุ : ", _ctlHavestRemake),
                        const SizedBox(height: 20),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     Column(
                        //       children: [
                        //         ElevatedButton(
                        //           style: ElevatedButton.styleFrom(
                        //               textStyle: const TextStyle(fontSize: 18),
                        //               primary: const Color.fromARGB(255, 10, 94, 3),
                        //               shape: RoundedRectangleBorder(
                        //                   borderRadius:
                        //                       BorderRadius.circular(30)),
                        //               padding: const EdgeInsets.all(15)),
                        //           onPressed: () {
                        //             if (_formKey.currentState!.validate()) {
                        //               addHarvests();
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
                        //               primary: Color.fromARGB(255, 197, 16, 4),
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

  Widget buildHarvestDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "วันที่เก็บเกี่ยว :",
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
            validator: RequiredValidator(errorText: 'กรุณาป้อนข้อมูล'),
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
            validator: RequiredValidator(errorText: 'กรุณาป้อนข้อมูล'),
          ),
        ),
      ],
    );
  }

  Widget buildHavestRemake() {
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
            controller: _ctlHavestRemake,
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
