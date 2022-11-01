import 'dart:convert';
import 'package:cannabis_track_and_trace_application/config/styles.dart';
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
    dropdownIsA = "N/A";
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

  String dropdownIsA = 'N/A';
  String selectDropdownIsA = '';
  var itemIsA = ['N/A', 'ON', 'OFF'];
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                "บันทึกข้อมูลวัสดุ",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 8, 143, 114)),
              ),
              const SizedBox(height: 50),
              buildName(),
              const SizedBox(height: 20),
              buildCommercialName(),
              const SizedBox(height: 20),
              buildIsActive(),
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
              //                   borderRadius: BorderRadius.circular(30)),
              //               padding: const EdgeInsets.all(15)),
              //           onPressed: () {
              //             addInventorys();
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
              //                   borderRadius: BorderRadius.circular(30)),
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

  Widget buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ชื่อ :",
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
            controller: _ctlName,
            keyboardType: TextInputType.text,
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

  Widget buildCommercialName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ชื่อทางการค้า :",
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
            controller: _ctlCommercialName,
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

  Widget buildIsActive() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "สถานะการใช้งาน :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          padding: const EdgeInsets.only(left: 15, right: 15),
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
          child: DropdownButton(
            dropdownColor: Colors.white,
            iconSize: 30,
            isExpanded: true,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
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
      ],
    );
  }
}
