import 'dart:convert';
import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:cannabis_track_and_trace_application/widget/forminput.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../api/hostapi.dart';

class Inventorys extends StatefulWidget {
  final String UserID;
  const Inventorys({Key? key, required this.UserID}) : super(key: key);
  @override
  State<Inventorys> createState() => _InventorysState();
}

class _InventorysState extends State<Inventorys> {
  final _formKey = GlobalKey<FormState>();
  bool _visible = false;

  final _ctlName = TextEditingController();
  final _ctlCommercialName = TextEditingController();
  final _ctlRemark = TextEditingController();

  void Clear() {
    _ctlName.clear();
    _ctlCommercialName.clear();
    dropdownIsA = null;
  }

  Future addInventorys() async {
    var url = hostAPI + "/informations/addInventorys";
    // Showing LinearProgressIndicator.
    setState(() {
      _visible = true;
    });

    var response = await http.post(Uri.parse(url), body: {
      "Name": _ctlName.text,
      "CommercialName": _ctlCommercialName.text,
      "IsActive": selectDropdownIsA.toString(),
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

  String? dropdownIsA;
  String selectDropdownIsA = '';
  var itemIsA = ['ON', 'OFF'];
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
                addInventorys();
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
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
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
                          "บันทึกข้อมูลวัสดุ",
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
                        MyForm().buildform("ชื่อ :", _ctlName),
                        const SizedBox(height: 20),
                        MyForm()
                            .buildform("ชื่อทางการค้า :", _ctlCommercialName),
                        const SizedBox(height: 20),
                        buildIsActive(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }

  Widget buildIsActive() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "สถานะการใช้งาน :",
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
              value: dropdownIsA,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: itemIsA.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(
                  () {
                    dropdownIsA = newValue!;
                    if (dropdownIsA == 'ON') {
                      selectDropdownIsA = "Y";
                    } else {
                      selectDropdownIsA = "N";
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
