import 'dart:convert';

import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../api/hostapi.dart';
import '../../../widget/dialog.dart';

class Locations extends StatefulWidget {
  final String UserID;
  const Locations({Key? key, required this.UserID}) : super(key: key);
  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  final canceldialog = MyDialog();
  LatLng? _latlng;
  Future<Null> findLatLng() async {
    Position? position = await findPosition();
    if (position != null) {
      setState(() {
        _latlng = LatLng(position.latitude, position.longitude);
        print('lat = ${_latlng!.latitude}, lng = ${_latlng!.longitude}');
      });
    }
  }

  Future<Position?> findPosition() async {
    Position? position;
    try {
      position = await Geolocator.getCurrentPosition();
    } catch (e) {
      position = null;
    }
    return position;
  }

  final _formKey = GlobalKey<FormState>();
  bool _visible = false;

  final _ctlName = TextEditingController();
  final _ctlAddrNo = TextEditingController();
  final _ctlMoo = TextEditingController();
  final _ctlRoad = TextEditingController();
  final _ctlSubDistrictID = TextEditingController();
  final _ctlDistrictID = TextEditingController();
  final _ctlProvinceID = TextEditingController();
  final _ctlPostCode = TextEditingController();
  final _ctlTelephone = TextEditingController();
  final _ctlRemark = TextEditingController();
  final _ctlCreateBy = TextEditingController();
  final _ctlUpdateBy = TextEditingController();

  void Clear() {
    _ctlName.clear();
    _ctlAddrNo.clear();
    _ctlMoo.clear();
    _ctlRoad.clear();
    _ctlSubDistrictID.clear();
    _ctlDistrictID.clear();
    _ctlProvinceID.clear();
    _ctlPostCode.clear();
    _ctlTelephone.clear();
    _ctlRemark.clear();
    _ctlCreateBy.clear();
    _ctlUpdateBy.clear();
    dropdownIsA = 'N/A';
  }

  Future addLocations() async {
    var url = hostAPI + "/informations/addLocations";
    // Showing LinearProgressIndicator.
    setState(() {
      _visible = true;
    });

    var response = await http.post(Uri.parse(url), body: {
      "Name": _ctlName.text,
      "AddrNo": _ctlAddrNo.text,
      "Moo": _ctlMoo.text,
      "Road": _ctlRoad.text,
      "SubDistrictID": _ctlSubDistrictID.text,
      "DistrictID": _ctlDistrictID.text,
      "ProvinceID": _ctlProvinceID.text,
      "PostCode": _ctlPostCode.text,
      "Lat": _latlng!.latitude.toString(),
      "Long": _latlng!.longitude.toString(),
      "Telephone": _ctlTelephone.text,
      "IsActive": selectDropdownIsA.toString(),
      "Remark": _ctlRemark.text,
      "CreateBy": widget.UserID,
      "UpdateBy": widget.UserID,
    });
    print(_latlng!.latitude.toString());
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
    findLatLng();
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
              addLocations();
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
                "บันทึกข้อมูลสถานที่ปลูก",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 8, 143, 114)),
              ),
              const SizedBox(height: 50),
              buildName(),
              const SizedBox(height: 20),
              buildAddNo(),
              const SizedBox(height: 20),
              buildMoo(),
              const SizedBox(height: 20),
              buildRoad(),
              const SizedBox(height: 20),
              buildSubDistrictID(),
              const SizedBox(height: 20),
              buildDistrictID(),
              const SizedBox(height: 20),
              buildProvinceID(),
              const SizedBox(height: 20),
              buildPostCode(),
              const SizedBox(height: 20),
              buildTelephone(),
              const SizedBox(height: 20),
              buildLatLng(),
              const SizedBox(height: 20),
              buildIsActive(),
              const SizedBox(height: 20),
              buildLocationRemake(),
              const SizedBox(height: 50),
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
              //             addLocations();
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

  Widget buildAddNo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "เลขที่ :",
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
            controller: _ctlAddrNo,
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

  Widget buildMoo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "หมู่ :",
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
            controller: _ctlMoo,
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

  Widget buildRoad() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ถนน :",
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
            controller: _ctlRoad,
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

  Widget buildSubDistrictID() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ตำบล :",
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
            controller: _ctlSubDistrictID,
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

  Widget buildDistrictID() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "อำเภอ :",
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
            controller: _ctlDistrictID,
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

  Widget buildProvinceID() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "จังหวัด :",
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
            controller: _ctlProvinceID,
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

  Widget buildPostCode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "รหัสไปรษณีย์ :",
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
            controller: _ctlPostCode,
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

  Widget buildLatLng() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ตำแหน่ง :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          height: 250,
          width: 500,
          child: _latlng == null
              ? const CircularProgressIndicator()
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _latlng!,
                    zoom: 16,
                  ),
                  onMapCreated: (controller) {},
                  markers: <Marker>{
                    Marker(
                      markerId: const MarkerId('id'),
                      position: _latlng!,
                      infoWindow: InfoWindow(
                          title: 'You Location',
                          snippet:
                              'Lat = ${_latlng!.latitude},Lng = ${_latlng!.longitude}'),
                    )
                  },
                ),
        ),
      ],
    );
  }

  Widget buildTelephone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "โทรศัพท์ :",
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
            controller: _ctlTelephone,
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

  Widget buildLocationRemake() {
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
            controller: _ctlRemark,
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
