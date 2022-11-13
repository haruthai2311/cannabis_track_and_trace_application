import 'dart:convert';
import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:cannabis_track_and_trace_application/widget/forminput.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../api/allInventorys.dart';
import '../../../api/allgreenhouses.dart';
import '../../../api/hostapi.dart';
import '../../../widget/dialog.dart';

class ChemicalUses extends StatefulWidget {
  final String UserID;
  const ChemicalUses({Key? key, required this.UserID}) : super(key: key);
  @override
  State<ChemicalUses> createState() => _ChemicalUsesState();
}

class _ChemicalUsesState extends State<ChemicalUses> {
  final canceldialog = MyDialog();
  late List<AllGreenhouses> _allGreenhouses;
  late List<AllInventorys> _allInventory;
  DateTime date = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  bool _visible = false;
  //late List<AllGreenhouses> _AllGreenhouses;

  final _ctlUseAmount = TextEditingController();
  final _ctlUnit = TextEditingController();
  final _ctlUseRemark = TextEditingController();
  final _ctlRemake = TextEditingController();

  void Clear() {
    _ctlUseAmount.clear();
    _ctlUnit.clear();
    _ctlUseRemark.clear();
    _ctlRemake.clear();
    dropdownGH = null;
    dropdownIV = null;
    date = DateTime.now();
  }

  Future addChemicalUses() async {
    var url = hostAPI + "/informations/addChemicalUses";
    // Showing LinearProgressIndicator.
    setState(() {
      _visible = true;
    });

    var response = await http.post(Uri.parse(url), body: {
      "InventoryName": dropdownIV.toString(),
      "UseAmount": _ctlUseAmount.text,
      "Unit": _ctlUnit.text,
      "UseRemark": _ctlUseRemark.text,
      "PHI": date.toString(),
      "GreenHouseName": dropdownGH.toString(),
      "Remark": _ctlRemake.text,
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
    var url = hostAPI + '/informations/getAllGreenhouses';
    var response = await http.get(Uri.parse(url));
    _allGreenhouses = allGreenhousesFromJson(response.body);

    var urlInventory = hostAPI + '/informations/getInventorys';
    var responseInventory = await http.get(Uri.parse(urlInventory));
    _allInventory = allInventorysFromJson(responseInventory.body);

    return [_allGreenhouses, _allInventory];
  }

  String? dropdownGH;
  String? dropdownIV;

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
                addChemicalUses();
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
                var result1 = snapshot.data[0];
                var result2 = snapshot.data[1];

                var nameGH = <String>[];
                for (var i = 0; i < result1.length; i++) {
                  nameGH.add(result1[i].name);
                }
                print(nameGH);

                var nameIV = <String>[];
                for (var i = 0; i < result2.length; i++) {
                  //print(result[i].newCase);
                  nameIV.add(result2[i].name);
                  //print(casenewsort);

                  //

                }
                print(nameIV);

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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 5, 0, 20),
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
                            "บันทึกข้อมูลการใช้สารเคมี",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 8, 143, 114)),
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
                                style: TextStyle(
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
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                    hint: Text("กรุณาเลือกโรงปลูก"),
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
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "วัสดุ :",
                                style: TextStyle(
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
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                    hint: Text("กรุณาเลือกวัสดุ"),
                                    value: dropdownIV,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: nameIV.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(
                                        () {
                                          dropdownIV = newValue!;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          MyForm().buildform("ปริมาณ :", _ctlUseAmount),
                          const SizedBox(height: 20),
                          MyForm().buildform("หน่วย :", _ctlUnit),
                          const SizedBox(height: 20),
                          MyForm().buildform("เหตุผลที่ใช้ :", _ctlUseRemark),
                          const SizedBox(height: 20),
                          buildPHI(),
                          const SizedBox(height: 20),
                          MyForm().buildformRemake("หมายเหตุ :", _ctlRemake),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const LinearProgressIndicator();
            },
          ),
        ));
  }

  Widget buildPHI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "วันที่ปลอดภัยหลังใช้ :",
          style: TextStyle(
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
                style: const TextStyle(fontSize: 18, color: Colors.black),
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
}
