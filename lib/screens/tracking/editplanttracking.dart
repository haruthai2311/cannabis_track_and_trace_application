import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../api/hostapi.dart';
import '../../api/planttracking.dart';
import '../../config/styles.dart';
import '../../widget/dialog.dart';

class EditPlantTracking extends StatefulWidget {
  final String PlantrackingID;

  const EditPlantTracking({Key? key, required this.PlantrackingID})
      : super(key: key);

  @override
  State<EditPlantTracking> createState() => _EditPlantTrackingState();
}

class _EditPlantTrackingState extends State<EditPlantTracking> {
  late List<Plantracking> _listplanttracking;
  final dialog = MyDialog();
  File? file; //เก็บภาพจากการถ่ายและจากแกลเลอรี่

  Future<List<Plantracking>> getPlanttracking() async {
    var url = hostAPI + '/trackings/Plantracking?id=' + widget.PlantrackingID;
    print(url);
    var response = await http.get(Uri.parse(url));
    _listplanttracking = plantrackingFromJson(response.body);
    //print(response.body);
    return _listplanttracking;
  }

  @override
  void initState() {
    super.initState();
    getPlanttracking();
  }

  final f = DateFormat('dd/MM/yyyy hh:mm:ss');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
      ),
      body: FutureBuilder(
        future: getPlanttracking(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              Container();
            }
            var result = snapshot.data;

            final _ctlGHName = TextEditingController(text: result[0].ghName);
            final _ctlCulNo =
                TextEditingController(text: result[0].no.toString());
            final _ctlCheckDate = TextEditingController(
                text: f.format(result[0].checkDate).toString());
            final _ctlPotId =
                TextEditingController(text: result[0].potId.toString());
            final _ctlPlantStatus =
                TextEditingController(text: result[0].plantStatus.toString());
            final _ctlSoilMoisture =
                TextEditingController(text: result[0].soilMoisture.toString());
            final _ctlSoilRemark =
                TextEditingController(text: result[0].soilRemark);
            final _ctlDisease = TextEditingController(text: result[0].disease);
            final _ctlFixDisease =
                TextEditingController(text: result[0].fixDisease);
            final _ctlInsect = TextEditingController(text: result[0].insect);
            final _ctlFixInsect =
                TextEditingController(text: result[0].fixInsect);
            final _ctlWeight = TextEditingController(
                text: result[0].weight.toString() + ' Kg');
            final _ctlTrashRemark =
                TextEditingController(text: result[0].trashRemark);
            final _ctlRemark = TextEditingController(text: result[0].remark);
            return SafeArea(
                child: ListView(padding: EdgeInsets.zero, children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Plant Tracking",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 8, 143, 114)),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          // decoration:
          //     BoxDecoration(border: Border.all(color: Color(0xffC4C4C4))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: ((() => chooseImage(ImageSource.camera))),
                  icon: Icon(
                    Icons.add_a_photo,
                  )),
              Container(
                  width: 270,
                  //height: 190,
                  child: file == null
                      ? Image.network(
                                hostAPI + result[0].fileName,
                          //fit: BoxFit.cover,
                        )
                      : Image.file(file!)),
              IconButton(
                  onPressed: (() => chooseImage(ImageSource.gallery)),
                  icon: Icon(Icons.add_photo_alternate)),
            ],
          ),
        ),
      ],
    ),
                            // Column(
                            //   children: [
                            //     Row(
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: [
                            //         IconButton(
                            //             onPressed: ((() =>
                            //                 chooseImage(ImageSource.camera))),
                            //             icon: Icon(
                            //               Icons.add_a_photo,
                            //             )),
                            //         Container(
                            //             //width: 270,
                            //             height: 230,
                            //             child: file == null
                            //                 /?  Image.network(
                            //                     hostAPI + result[0].fileName)
                            //                 : Image.file(file!)),
                            //         IconButton(
                            //             onPressed: (() =>
                            //                 chooseImage(ImageSource.gallery)),
                            //             icon: Icon(Icons.add_photo_alternate)),
                            //       ],
                            //       //   SizedBox(
                            //       //     //width: 270,
                            //       //     height: 230,
                            //       //     child: Image.network(
                            //       //         hostAPI + result[0].fileName),
                            //       //   ),
                            //       // ],
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("โรงปลูก :", true, _ctlGHName),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("รอบที่ปลูก :", true, _ctlCulNo),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("วันที่บันทึก :", true, _ctlCheckDate),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("หมายเลขกระถาง :", true, _ctlPotId),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("สถานะปัจจุบัน :", false, _ctlPlantStatus),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox(
                                "ความชื้นของดิน :", false, _ctlSoilMoisture),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("หมายเหตุ(ความชื้นของดิน) :", false,
                                _ctlSoilRemark),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("โรคที่พบ :", false, _ctlDisease),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("วิธีแก้ไข :", false, _ctlFixDisease),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("แมลงที่พบ :", false, _ctlInsect),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("วิธีแก้ไข :", false, _ctlFixInsect),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("เก็บซาก :", false, _ctlWeight),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox(
                                "เหตุผลที่เก็บซาก :", false, _ctlTrashRemark),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("หมายเหตุ :", false, _ctlRemark),
                            const SizedBox(
                              height: 15,
                            ),
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
                                      onPressed: () {},
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
                                        dialog.showDialogCancel(context);
                                      },
                                      child: Text("ยกเลิก"),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ]),
                    ),
                  )
                ],
              )
            ]));
          }
          return const LinearProgressIndicator();
        },
      ),
    );
  }

  Future<Null> chooseImage(ImageSource source) async {
    var object = await ImagePicker()
        .pickImage(source: source, maxWidth: 800.0, maxHeight: 800.0);
    if (object != null) {
      setState(() {
        file = File(object.path);
        //print(file);
      });
    }
  }

  Widget buildBox(String title, readonly, controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
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
            readOnly: readonly,
            controller: controller,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 15),
              hintText: "",
              // hintStyle: TextStyle(color: Colors.black38, fontSize: 18)
            ),
          ),
        )
      ],
    );
  }
}
