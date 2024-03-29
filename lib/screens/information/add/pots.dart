import 'dart:convert';
import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:cannabis_track_and_trace_application/widget/forminput.dart';
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
    dropdownGH = null;
    dropdownCul = null;
    dropdownIsTest = null;
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

  String? dropdownGH;
  //var itemGH = ['N/A', 'โรงเรือน 1', 'โรงเรือน 2'];
  String? dropdownCul;
  //var itemCul = ['N/A', '1', '2', '3', '4'];
  String selectDropdownIsTest = '';
  String? dropdownIsTest;
  var itemIsTest = ['N/A', 'YES', 'NO'];

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
                addPots();
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
                if (snapshot.data == null) {
                  Container();
                }
                var result1 = snapshot.data[0];
                var result2 = snapshot.data[1];
                var nameGH = <String>[];
                for (var i = 0; i < result1.length; i++) {
                  nameGH.add(result1[i].name);
                }
                print(nameGH);

                var itemCul = <String>[];
                for (var i = 0; i < result2.length; i++) {
                  itemCul.add(result2[i].cultivationId.toString());
                }
                // print(nameStrains);

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
                          "บันทึกข้อมูลกระถาง",
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
                                        NameGHParameters =
                                            "?NameGH=" + dropdownGH!;
                                        dropdownCul = null;
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
                              "หมายเลขการปลูก :",
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
                                  hint: Text("กรุณาเลือกหมายเลขการปลูก"),
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
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        MyForm().buildform("หมายเลขกระถาง :", _ctlName),
                        const SizedBox(height: 20),
                        MyForm().buildform("บาร์โค้ด :", _ctlBarcode),
                        const SizedBox(height: 20),
                        buildIsTestPot(),
                        const SizedBox(height: 20),
                        MyForm().buildformRemake("หมายเหตุ :", _ctlRemake),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ));
              }
              return const LinearProgressIndicator();
            },
          ),
        ));
  }

  Widget buildIsTestPot() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "กระถางทดลอง :",
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
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              dropdownColor: Colors.white,
              iconSize: 30,
              isExpanded: true,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hint: Text("กรุณาเลือก"),
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
        ),
      ],
    );
  }
}
