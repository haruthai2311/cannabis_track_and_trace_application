import 'dart:convert';

import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:cannabis_track_and_trace_application/widget/forminput.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../api/alllocations.dart';
import '../../../api/hostapi.dart';

class GreenHouses extends StatefulWidget {
  final String UserID;
  const GreenHouses({Key? key, required this.UserID}) : super(key: key);

  @override
  State<GreenHouses> createState() => _GreenHousesState();
}

class _GreenHousesState extends State<GreenHouses> {
  final _formKey = GlobalKey<FormState>();
  bool _visible = false;

  final _ctlName = TextEditingController();
  final _ctlRemark = TextEditingController();

  void Clear() {
    _ctlName.clear();
    _ctlRemark.clear();
    dropdownLocations = null;
    dropdownIsA = null;
  }

  Future addGreenhouse() async {
    var url = hostAPI + "/informations/addGreenhouses";
    // Showing LinearProgressIndicator.
    setState(() {
      _visible = true;
    });

    var response = await http.post(Uri.parse(url), body: {
      "Name": _ctlName.text,
      "LocationName": dropdownLocations.toString(),
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

  late List<AllLocations> _listlocations;
  Future getData() async {
    var url = hostAPI + '/informations/getLocations';
    var response = await http.get(Uri.parse(url));
    _listlocations = allLocationsFromJson(response.body);

    return _listlocations;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  String? dropdownLocations;
  // var nameLocations = ['1', '2', '3'];

  String? dropdownIsA;
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
                addGreenhouse();
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var result = snapshot.data;

              var nameLocations = <String>[];
              for (var i = 0; i < result.length; i++) {
                nameLocations.add(result[i].name);
              }
              print(nameLocations);

              return Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "บันทึกข้อมูลโรงเรือน ",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 8, 143, 114)),
                      ),
                      const SizedBox(height: 50),
                      MyForm().buildform("ชื่อโรงเรือน :", _ctlName),
                      const SizedBox(height: 20),
                      buildGH_location(nameLocations),
                      const SizedBox(height: 20),
                      buildGH_IsActive(),
                      const SizedBox(height: 20),
                      MyForm().buildform("หมายเหตุ :", _ctlRemark),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              );
            }
            return const LinearProgressIndicator();
          },
        ));
  }

 

  Widget buildGH_location(nameLocations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ชื่อสถานที่ :",
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
            child: DropdownButton<String>(
              dropdownColor: Colors.white,
              iconSize: 30,
              isExpanded: true,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              hint: const Text("เลือกสถานที่"),
              value: dropdownLocations,
              icon: const Icon(Icons.keyboard_arrow_down),
              items:
                  nameLocations.map<DropdownMenuItem<String>>((String items) {
                return DropdownMenuItem<String>(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(
                  () {
                    dropdownLocations = newValue!;
                    print(dropdownLocations.toString());
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildGH_IsActive() {
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
              hint: const Text('N/A'),
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
