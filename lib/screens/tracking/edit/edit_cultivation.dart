import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../api/allcultivations.dart';
import '../../../api/allgreenhouses.dart';
import '../../../api/allstrains.dart';
import '../../../api/hostapi.dart';
import '../../../config/styles.dart';
import '../../../widget/forminput.dart';

class EditCultivation extends StatefulWidget {
  final String UserID;
  final String CultivationID;
  const EditCultivation(
      {Key? key, required this.UserID, required this.CultivationID})
      : super(key: key);

  @override
  State<EditCultivation> createState() => _EditCultivationState();
}

class _EditCultivationState extends State<EditCultivation> {
  DateTime SeedDate = DateTime.now();
  DateTime MoveDate = DateTime.now();
  late List<Cultivations> _listCultivation;
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

  @override
  void initState() {
    super.initState();
    //getAllData();
  }

  Future getData() async {
    var urlGH = hostAPI + '/informations/getAllGreenhouses';
    var responseGH = await http.get(Uri.parse(urlGH));
    _allGreenhouses = allGreenhousesFromJson(responseGH.body);

    var urlStrains = hostAPI + '/informations/getStrains';
    var responseStrains = await http.get(Uri.parse(urlStrains));
    _allStrains = allStrainsFromJson(responseStrains.body);

    var url = hostAPI + '/trackings/Cultivation?ID=' + widget.CultivationID;
    print(url);
    var response = await http.get(Uri.parse(url));
    _listCultivation = cultivationsFromJson(response.body);

    return [_allGreenhouses, _allStrains, _listCultivation];
  }

  String? dropdownStrain;
  //var itemStrain = ['N/A', 'สายพันธุ์หางกระรอก', 'สายพันธุ์หางเสือ'];

  String? dropdownGH;
  //var itemGH = ['N/A', 'โรงเรือน 1', 'โรงเรือน 2'];
  final f = DateFormat('dd/MM/yyyy  hh:mm:ss');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cultivation Edit"),
          backgroundColor: kBackground,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.save_as_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                confirmDialog();
              },
            )
          ],
        ),
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage("images/bg_editTracking.png"),
            //   fit: BoxFit.fill,
            // ),
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
                var resultCul = snapshot.data[2];
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
                var nameGreenHouse = resultCul[0].nameGh.toString();
                var nameStrain = resultCul[0].nameStrains.toString();
                _ctlNo.text = resultCul[0].no.toString();
                _ctlSeedtotal.text = resultCul[0].seedTotal.toString();
                _ctlSeedNet.text = resultCul[0].seedNet.toString();
                _ctlPlantTotal.text = resultCul[0].plantTotal.toString();
                _ctlPlantLive.text = resultCul[0].plantLive.toString();
                _ctlPlantDead.text = resultCul[0].plantDead.toString();
                _ctlPlantRemake.text = resultCul[0].remark.toString();
                SeedDate = resultCul[0].seedDate;
                MoveDate = resultCul[0].moveDate;

                dropdownStrain ??= nameStrain;
                dropdownGH ??= nameGreenHouse;

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    //padding: const EdgeInsets.only(top: 50),
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
                          Text(
                            "แก้ไขข้อมูลการปลูก",
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
                                "โรงปลูก ",
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
                                child: DropdownButton(
                                  dropdownColor: Colors.white,
                                  iconSize: 30,
                                  isExpanded: true,
                                  style: TextStyle(
                                    color: colorDetails2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hint: Text(
                                    nameGreenHouse,
                                    style: TextStyle(
                                      color: colorDetails2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
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
                                child: DropdownButton(
                                  dropdownColor: Colors.white,
                                  iconSize: 30,
                                  isExpanded: true,
                                  style: TextStyle(
                                    color: colorDetails2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hint: Text(
                                    nameStrain,
                                    style: TextStyle(
                                      color: colorDetails2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
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
                          MyForm().buildform("รอบการปลูก : ", _ctlNo),
                          const SizedBox(height: 20),
                          buildSeedData(),
                          const SizedBox(height: 20),
                          buildMoveData(),
                          const SizedBox(height: 20),
                          MyForm().buildform("จำนวนเมล็ด : ", _ctlSeedtotal),
                          const SizedBox(height: 20),
                          MyForm().buildform("น้ำหนักเมล็ด : ", _ctlSeedNet),
                          const SizedBox(height: 20),
                          MyForm()
                              .buildform("จำนวนต้นทั้งหมด : ", _ctlPlantTotal),
                          const SizedBox(height: 20),
                          MyForm().buildform(
                              "จำนวนต้นเป็นทั้งหมด : ", _ctlPlantLive),
                          const SizedBox(height: 20),
                          //MyForm.buildform("จำนวนต้นตายทั้งหมด : ", _ctlPlantDead),
                          MyForm().buildform(
                              "จำนวนต้นตายทั้งหมด : ", _ctlPlantDead),
                          const SizedBox(height: 20),
                          MyForm()
                              .buildformRemake("หมายเหตุ : ", _ctlPlantRemake),
                          const SizedBox(height: 20),
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

  // Widget buildform(title, controllor) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         title,
  //         style: const TextStyle(
  //           color: colorDetails3,
  //           fontSize: 20,
  //           fontWeight: FontWeight.w600,
  //         ),
  //       ),
  //       const SizedBox(height: 10),
  //       Container(
  //         width: double.infinity,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(16),
  //           border: Border.all(
  //             color: Color.fromARGB(255, 238, 238, 240),
  //             width: 2,
  //           ),
  //         ),
  //         child: TextFormField(
  //           controller: controllor,
  //           keyboardType: TextInputType.number,
  //           style: const TextStyle(
  //             color: colorDetails2,
  //             fontSize: 20,
  //             fontWeight: FontWeight.normal,
  //           ),
  //           decoration: const InputDecoration(
  //               border: InputBorder.none,
  //               contentPadding: EdgeInsets.only(left: 15),
  //               hintText: 'ระบุ',
  //               hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget buildSeedData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "วันที่เพาะเมล็ด :",
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

  Widget buildPlantRemake() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "หมายเหตุ :",
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
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Color.fromARGB(255, 238, 238, 240),
              width: 2,
            ),
          ),
          child: TextFormField(
            controller: _ctlPlantRemake,
            style: const TextStyle(
              color: colorDetails2,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
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

  Future<Null> confirmDialog() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ยืนยันการแก้ไข'),
          content: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                Text('กรุณากดยืนยันเพื่อดำเนินการแก้ไข'),
                //Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ยืนยัน'),
              onPressed: () {
                EditData();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<Null> EditData() async {
    String url = hostAPI + "/trackings/editCultivatiions";
    // Showing LinearProgressIndicator.
    setState(() {
      _visible = true;
    });

    var response = await http.put(Uri.parse(url), body: {
      "CultivationID": widget.CultivationID,
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
        //showMessage(msg["message"]);
        Navigator.pop(context);

        ///Clear();
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
}
