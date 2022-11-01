import 'dart:convert';
import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:dropdown_search2/dropdown_search2.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import '../../../api/hostapi.dart';
import '../../../api/masterprovinces/districts.dart';
import '../../../api/masterprovinces/provinces.dart';
import '../../../api/masterprovinces/subdistricts.dart';
import '../../../widget/dialog.dart';

class Locations extends StatefulWidget {
  final String UserID;
  const Locations({Key? key, required this.UserID}) : super(key: key);
  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  LatLng? latlng;
  Future<Null> findLatLng() async {
    Position? position = await findPosition();
    if (position != null) {
      setState(() {
        latlng = LatLng(position.latitude, position.longitude);
        print('lat = ${latlng!.latitude}, lng = ${latlng!.longitude}');
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

  // Future<Position?> findPosition() async {
  //   Position? position;
  //   try {
  //     position = await Geolocator.getCurrentPosition();
  //   } catch (e) {
  //     position = null;
  //   }
  //   return position;
  // }

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
    selectSubDistricts = null;
    selectDistricts = null;
    selectProvinces = null;
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
      "Lat": latlng!.latitude.toString(),
      "Long": latlng!.longitude.toString(),
      "Telephone": _ctlTelephone.text,
      "IsActive": selectDropdownIsA.toString(),
      "Remark": _ctlRemark.text,
      "CreateBy": widget.UserID,
      "UpdateBy": widget.UserID,
    });
    // print(_latlng!.latitude.toString());
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

  late List<Provinces> _listProvinces;
  late List<Districts> _listDistricts;
  late List<SubDistricts> _listSubDistricts;
  String pidParameters = '';
  String didParameters = '';
  Future getData() async {
    var url = '$hostAPI/informations/provinces';
    var response = await http.get(Uri.parse(url));
    _listProvinces = provincesFromJson(response.body);

    var urlDistricts = '$hostAPI/informations/districts?pid=$pidParameters';
    print(urlDistricts);
    var responseDistricts = await http.get(Uri.parse(urlDistricts));
    _listDistricts = districtsFromJson(responseDistricts.body);

    var urlSubDistricts =
        '$hostAPI/informations/subdistricts?did=$didParameters';
    print(urlSubDistricts);
    var responseSubDistricts = await http.get(Uri.parse(urlSubDistricts));
    _listSubDistricts = subDistrictsFromJson(responseSubDistricts.body);

    return [_listProvinces, _listDistricts, _listSubDistricts];
  }

  String dropdownIsA = 'N/A';
  String selectDropdownIsA = '';
  var itemIsA = ['N/A', 'ON', 'OFF'];
  //var provinces = ['N/A', 'ON', 'OFF'];
  String? selectProvinces;
  String? selectDistricts;
  String? selectSubDistricts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
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
        body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                Container();
              }
              var p = snapshot.data[0];
              var d = snapshot.data[1];
              var sd = snapshot.data[2];
              var provinces = <String>[];
              for (var i = 0; i < p.length; i++) {
                provinces.add(p[i].nameTh.toString());
              }

              //print(provinces.length);
              // print(provinces.indexOf(selectProvinces!.toString()));

              var districts = <String>[];
              for (var i = 0; i < d.length; i++) {
                districts.add(d[i].nameTh.toString());
              }
              print(districts);

              var subdistricts = <String>[];
              for (var i = 0; i < sd.length; i++) {
                subdistricts.add(sd[i].nameTh.toString());
              }
              print(subdistricts);

              return Padding(
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "จังหวัด :",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
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
                            child: DropdownSearch<String>(
                              //mode of dropdown
                              mode: Mode.DIALOG,
                              //to show search box
                              showSearchBox: true,
                              selectedItem: selectProvinces,
                              dropdownSearchDecoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "เลือกจังหวัด",
                                  contentPadding: EdgeInsets.only(left: 15),
                                  hintStyle: TextStyle(
                                      color: Colors.black38, fontSize: 18)),
                              //list of dropdown items
                              items: provinces,

                              //selectedItem: provinces,
                              //เปลี่ยนค่า dropdown เป็นค่าใหม่ที่เลือก
                              onChanged: (newValue) {
                                setState(() {
                                  selectProvinces = newValue.toString();
                                  print(selectProvinces);
                                  print(
                                      provinces.indexOf(selectProvinces!) + 1);
                                  pidParameters =
                                      p[(provinces.indexOf(selectProvinces!))]
                                          .id
                                          .toString();
                                  selectDistricts = null;
                                  _ctlProvinceID.text =
                                      p[(provinces.indexOf(selectProvinces!))]
                                          .id
                                          .toString();
                                });
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
                            "อำเภอ :",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
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
                            child: DropdownSearch<String>(
                              //mode of dropdown
                              mode: Mode.DIALOG,
                              //to show search box
                              showSearchBox: true,
                              selectedItem: selectDistricts,
                              dropdownSearchDecoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "เลือกอำเภอ",
                                  contentPadding: EdgeInsets.only(left: 15),
                                  hintStyle: TextStyle(
                                      color: Colors.black38, fontSize: 18)),
                              //list of dropdown items
                              items: districts,

                              //selectedItem: provinces,
                              //เปลี่ยนค่า dropdown เป็นค่าใหม่ที่เลือก
                              onChanged: (newValue) {
                                setState(() {
                                  selectDistricts = newValue.toString();
                                  // print(selectProvinces);
                                  // print(districts.indexOf(selectDistricts!));
                                  // print(d[(districts.indexOf(selectDistricts!))]
                                  //     .id
                                  //     .toString());
                                  didParameters =
                                      d[(districts.indexOf(selectDistricts!))]
                                          .id
                                          .toString();
                                  selectSubDistricts = null;
                                  _ctlDistrictID.text =
                                      d[(districts.indexOf(selectDistricts!))]
                                          .id
                                          .toString();
                                });
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
                            "ตำบล :",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
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
                            child: DropdownSearch<String>(
                              //mode of dropdown
                              mode: Mode.DIALOG,
                              //to show search box
                              showSearchBox: true,
                              selectedItem: selectSubDistricts,
                              dropdownSearchDecoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "เลือกตำบล",
                                  contentPadding: EdgeInsets.only(left: 15),
                                  hintStyle: TextStyle(
                                      color: Colors.black38, fontSize: 18)),
                              //list of dropdown items
                              items: subdistricts,

                              //selectedItem: provinces,
                              //เปลี่ยนค่า dropdown เป็นค่าใหม่ที่เลือก
                              onChanged: (newValue) {
                                setState(() {
                                  selectSubDistricts = newValue.toString();
                                  // print(selectProvinces);
                                  // print(districts.indexOf(selectDistricts!));
                                  // print(sd[(subdistricts
                                  //         .indexOf(selectSubDistricts!))]
                                  //     .id
                                  //     .toString());

                                  _ctlPostCode.text = sd[(subdistricts
                                          .indexOf(selectSubDistricts!))]
                                      .zipCode
                                      .toString();
                                  _ctlSubDistrictID.text = sd[(subdistricts
                                          .indexOf(selectSubDistricts!))]
                                      .id
                                      .toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
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
              );
            }
            return const LinearProgressIndicator();
          },
        ));
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
          child: latlng == null
              ? CircularProgressIndicator()
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: latlng!,
                    zoom: 16,
                  ),
                  onMapCreated: (controller) {},
                  markers: <Marker>{
                    Marker(
                      markerId: const MarkerId('id'),
                      position: latlng!,
                      infoWindow: InfoWindow(
                          title: 'You Location',
                          snippet:
                              'Lat = ${latlng!.latitude},Lng = ${latlng!.longitude}'),
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
