import 'dart:convert';
import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:cannabis_track_and_trace_application/widget/forminput.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../api/allgreenhouses.dart';
import '../../../api/allstrains.dart';
import '../../../api/hostapi.dart';
import '../../../widget/dialog.dart';

class AddCultivations extends StatefulWidget {
  final String UserID;
  const AddCultivations({Key? key, required this.UserID}) : super(key: key);
  @override
  State<AddCultivations> createState() => _AddCultivationsState();
}

class _AddCultivationsState extends State<AddCultivations> {
  final canceldialog = MyDialog();
  DateTime SeedDate = DateTime.now();
  DateTime MoveDate = DateTime.now();
  late List<AllGreenhouses> _allGreenhouses;
  late List<AllStrains> _allStrains;
  final _formKey = GlobalKey<FormState>();
  bool _visible = false;

  final _ctlNo = TextEditingController();
  final _ctlSeedtotal = TextEditingController();
  final _ctlSeedNet = TextEditingController();
  final _ctlPlantTotal = TextEditingController();
  final _ctlPlantLive = TextEditingController();
  final _ctlPlantDead = TextEditingController();
  final _ctlPlantRemake = TextEditingController();

  void Clear() {
    _ctlNo.clear();
    _ctlSeedtotal.clear();
    _ctlSeedNet.clear();
    _ctlPlantTotal.clear();
    _ctlPlantLive.clear();
    _ctlPlantDead.clear();
    _ctlPlantRemake.clear();
    dropdownGH = 'N/A';
    dropdownStrain = 'N/A';
  }

  Future addCultivations() async {
    var url = hostAPI + "/trackings/addCultivations";
    // Showing LinearProgressIndicator.
    setState(() {
      _visible = true;
    });

    var response = await http.post(Uri.parse(url), body: {
      "GreenHouseName": dropdownGH.toString(),
      "StrainName": dropdownStrain.toString(),
      "No": _ctlNo.text,
      "SeedDate": SeedDate.toString(),
      "MoveDate": MoveDate.toString(),
      "SeedTotal": _ctlSeedtotal.text,
      "SeedNet": _ctlSeedNet.text,
      "PlantTotal": _ctlPlantTotal.text,
      "PlantLive": _ctlPlantLive.text,
      "PlantDead": _ctlPlantDead.text,
      "Remark": _ctlPlantRemake.text,
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
    //getAllData();
  }

  Future getData() async {
    var url = hostAPI + '/informations/getAllGreenhouses';
    var response = await http.get(Uri.parse(url));
    _allGreenhouses = allGreenhousesFromJson(response.body);

    var urlStrains = hostAPI + '/informations/getStrains';
    var responseStrains = await http.get(Uri.parse(urlStrains));
    _allStrains = allStrainsFromJson(responseStrains.body);

    return [_allGreenhouses, _allStrains];
    //return _allGreenhouses;
  }

  String dropdownStrain = 'N/A';
  //var itemStrain = ['N/A', 'สายพันธุ์หางกระรอก', 'สายพันธุ์หางเสือ'];

  String dropdownGH = 'N/A';
  //var itemGH = ['N/A', 'โรงเรือน 1', 'โรงเรือน 2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cultivation"),
          backgroundColor: kBackground,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.save_as_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                addCultivations();
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
                var nameGH = ['N/A'];
                for (var i = 0; i < result1.length; i++) {
                  nameGH.add(result1[i].name);
                }
                print(nameGH);

                var nameStrains = [
                  'N/A',
                ];
                for (var i = 0; i < result2.length; i++) {
                  nameStrains.add(result2[i].name);
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
                            "บันทึกข้อมูลการปลูก",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "สายพันธุ์ :",
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
                                  value: dropdownStrain,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: nameStrains.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(
                                      () {
                                        dropdownStrain = newValue!;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          MyForm().buildformNum("รอบการผลิต : ", _ctlNo),
                          const SizedBox(height: 20),
                          buildSeedData(),
                          const SizedBox(height: 20),
                          buildMoveData(),
                          const SizedBox(height: 20),
                          MyForm().buildformNum("จำนวนเมล็ด : ", _ctlSeedtotal),
                          const SizedBox(height: 20),
                          MyForm().buildformNum("น้ำหนักเมล็ด : ", _ctlSeedNet),
                          const SizedBox(height: 20),
                          MyForm().buildformNum(
                              "จำนวนต้นทั้งหมด : ", _ctlPlantTotal),
                          const SizedBox(height: 20),
                          MyForm().buildformNum(
                              "จำนวนต้นเป็นทั้งหมด : ", _ctlPlantLive),
                          const SizedBox(height: 20),
                          MyForm().buildformNum(
                              "จำนวนต้นตายทั้งหมด : ", _ctlPlantDead),
                          const SizedBox(height: 20),
                          MyForm()
                              .buildformRemake("หมายเหตุ : ", _ctlPlantRemake),
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
                          //                   borderRadius:
                          //                       BorderRadius.circular(30)),
                          //               padding: const EdgeInsets.all(15)),
                          //           onPressed: () {
                          //             addCultivations();
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
                          //               primary:
                          //                   Color.fromARGB(255, 197, 16, 4),
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
        ));
  }

  Widget buildSeedData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "วันที่เพาะเมล็ด :",
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
                '${SeedDate.year}/${SeedDate.month}/${SeedDate.day}',
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
                    initialDate: SeedDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  //if "CANCEL" = null
                  if (newDate == null) return;
                  //if "OK" => DateTime
                  setState(() => SeedDate = newDate);
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

  Widget buildMoveData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "วันที่ย้ายปลูก :",
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
                '${MoveDate.year}/${MoveDate.month}/${MoveDate.day}',
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
                    initialDate: MoveDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  //if "CANCEL" = null
                  if (newDate == null) return;
                  //if "OK" => DateTime
                  setState(() => MoveDate = newDate);
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
