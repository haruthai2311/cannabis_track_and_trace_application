import 'dart:convert';
import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../api/getcultivations.dart';
import '../../../api/allgreenhouses.dart';
import '../../../api/hostapi.dart';
import '../../../widget/dialog.dart';

class Pots extends StatefulWidget {
  final String UserID;
  const Pots({Key? key, required this.UserID}) : super(key: key);

  @override
  State<Pots> createState() => _PotsState();
}

class _PotsState extends State<Pots> {
  final canceldialog = MyDialog();
  late List<AllGreenhouses> _allGreenhouses;
  late List<GetCultivations> _getCultivations;
  final _formKey = GlobalKey<FormState>();
  bool _visible = false;
  //late List<AllGreenhouses> _AllGreenhouses;

  final _ctlName = TextEditingController();
  final _ctlBarcode = TextEditingController();
  final _ctlRemake = TextEditingController();

  void Clear() {
    _ctlName.clear();
    _ctlBarcode.clear();
    _ctlRemake.clear();
    dropdownGH = 'N/A';
    dropdownCul = 'N/A';
    dropdownIsTest = 'N/A';
  }

  Future addPots() async {
    var url = hostAPI + "/informations/addPots";
    // Showing LinearProgressIndicator.
    setState(() {
      _visible = true;
    });

    var response = await http.post(Uri.parse(url), body: {
      "GreenHouseName": dropdownGH.toString(),
      "CultivationID": dropdownCul.toString(),
      "Name": _ctlName.text,
      "Barcode": _ctlBarcode.text,
      "IsTestPot": selectDropdownIsTest.toString(),
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

  String NameGHParameters = '';
  Future getData() async {
    var url = hostAPI + '/informations/getAllGreenhouses';
    var response = await http.get(Uri.parse(url));
    _allGreenhouses = allGreenhousesFromJson(response.body);

    var urlCultivations =
        hostAPI + '/trackings/getCultivations' + NameGHParameters;
    print(urlCultivations);
    var responseCultivations = await http.get(Uri.parse(urlCultivations));
    _getCultivations = getCultivationsFromJson(responseCultivations.body);

    return [_allGreenhouses, _getCultivations];
  }

  String dropdownGH = 'N/A';
  //var itemGH = ['N/A', 'โรงเรือน 1', 'โรงเรือน 2'];
  String dropdownCul = 'N/A';
  //var itemCul = ['N/A', '1', '2', '3', '4'];
  String selectDropdownIsTest = '';
  String dropdownIsTest = 'N/A';
  var itemIsTest = ['N/A', 'YES', 'NO'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kBackground,
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                 Container();
              } 
                var result1 = snapshot.data[0];
                var result2 = snapshot.data[1];
                var nameGH = ['N/A'];
                for (var i = 0; i < result1.length; i++) {
                  nameGH.add(result1[i].name);
                }
                print(nameGH);

                var itemCul = [
                  'N/A',
                ];
                for (var i = 0; i < result2.length; i++) {
                  itemCul.add(result2[i].cultivationId.toString());
                }
                // print(nameStrains);

                return SafeArea(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              "บันทึกข้อมูลกระถาง",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 8, 143, 114)),
                            ),
                            const SizedBox(height: 50),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "โรงปลูก :",
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
                                          NameGHParameters =
                                              "?NameGH=" + dropdownGH;
                                          dropdownCul = 'N/A';
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "หมายเลขการปลูก :",
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
                                    value: dropdownCul,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: itemCul.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(
                                        () {
                                          dropdownCul = newValue!;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            buildPotName(),
                            const SizedBox(height: 20),
                            buildBarcode(),
                            const SizedBox(height: 20),
                            buildIsTestPot(),
                            const SizedBox(height: 20),
                            buildPotRemake(),
                            const SizedBox(height: 50),
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
                                        addPots();
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
                                        canceldialog.showDialogCancel(context);
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

  Widget buildPotName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "หมายเลขกระถาง :",
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
            controller: _ctlName,
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

  Widget buildBarcode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "บาร์โค้ด :",
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
            controller: _ctlBarcode,
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

  Widget buildIsTestPot() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "กระถางทดลอง :",
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
            value: dropdownIsTest,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: itemIsTest.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(
                () {
                  dropdownIsTest = newValue!;
                  if (dropdownIsTest == 'YES') {
                    selectDropdownIsTest = "Y";
                  } else {
                    selectDropdownIsTest = "N";
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildPotRemake() {
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
            controller: _ctlRemake,
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
