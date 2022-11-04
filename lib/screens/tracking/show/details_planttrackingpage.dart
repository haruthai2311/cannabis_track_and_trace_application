import 'package:cannabis_track_and_trace_application/screens/tracking/edit/editplanttracking.dart';
import 'package:cannabis_track_and_trace_application/widget/formDetail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../api/hostapi.dart';
import '../../../api/planttracking.dart';
import '../../../config/styles.dart';
import 'package:http/http.dart' as http;

class DetailsPlantTrackingPage extends StatefulWidget {
  final String PlantrackingID;
  final String UserID;
  const DetailsPlantTrackingPage(
      {Key? key, required this.PlantrackingID, required this.UserID})
      : super(key: key);

  @override
  State<DetailsPlantTrackingPage> createState() =>
      _DetailsPlantTrackingPageState();
}

class _DetailsPlantTrackingPageState extends State<DetailsPlantTrackingPage> {
  late List<Plantracking> _listplanttracking;

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
    // print(widget.UserID);
  }

  final f = DateFormat('dd/MM/yyyy  hh:mm:ss');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
        title: const Text("Plant Tracking"),
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
          future: getPlanttracking(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                Container();
              }
              var result = snapshot.data;

              String Status;
              String status = result[0].plantStatus.toString();
              if (status == "1") {
                Status = "ปกติ";
              } else if (status == "2") {
                Status = "ไม่สมบูรณ์";
              } else if (status == "3") {
                Status = "ตัดทิ้ง";
              } else {
                Status = "N/A";
              }

              String SoilMoisture;
              String Soil = result[0].soilMoisture.toString();
              if (Soil == "1") {
                SoilMoisture = "ดินชิ้นเหมาะสม";
              } else if (Soil == "2") {
                SoilMoisture = "ดินชื้นมาก ไม่มีผลต่อการเจริญเติบโต";
              } else if (Soil == "3") {
                SoilMoisture = "ดินชื้นมาก มีผลต่อการเจริญเติบโต";
              } else if (Soil == "4") {
                SoilMoisture = "ดินแห้ง พบต้นเหี่ยวช่วงบ่าย";
              } else if (Soil == "5") {
                SoilMoisture = "ดินแห้ง ไม่พบต้นเหี่ยวช่วงบ่าย";
              } else {
                SoilMoisture = "N/A";
              }
              return SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        children: <Widget>[
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

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'รายละเอียดผลตรวจประจำวัน',
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: ClipRRect(
                          //     borderRadius: BorderRadius.circular(8.0),
                          //     child: Image.network(
                          //       hostAPI + result[0].fileName,
                          //       fit: BoxFit.cover,
                          //       width: double.infinity,
                          //       height:
                          //           MediaQuery.of(context).size.height * 0.5,
                          //     ),
                          //   ),
                          // ),
                          Container(
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color(0xFFF1F4F8),
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: GestureDetector(
                                child: Image.network(
                                  hostAPI + result[0].fileName,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                ),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return DetailScreen(result[0].fileName);
                                  }));
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                FormDetail().buildSubject(
                                    "โรงปลูก :  ",
                                    result[0].ghName.toString(),
                                    Icons.home,
                                    Colors.green),
                                FormDetail().buildSubject(
                                    "รอบปลูก :  ",
                                    result[0].no.toString(),
                                    Icons.grade,
                                    Colors.orange),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                FormDetail().buildText("หมายเลขกระถาง :  ",
                                    result[0].potsName.toString()),
                                SizedBox(height: 5),
                                FormDetail().buildText(
                                  "วันที่บันทึก :  ",
                                  f.format(result[0].checkDate).toString() +
                                      ' น.',
                                ),
                                SizedBox(height: 5),
                                FormDetail()
                                    .buildText("สถานะปัจจุบัน :  ", Status),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: Divider(
                                    height: 24,
                                    thickness: 2,
                                    color: Color(0xFFF1F4F8),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "ความชื้นของดิน :  ",
                                          style: TextStyle(
                                            color: colorDetails3,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          SoilMoisture,
                                          style: TextStyle(
                                            color: colorDetails2,
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                FormDetail().buildText("** หมายเหตุ :  ",
                                    result[0].soilRemark.toString()),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: Divider(
                                    height: 24,
                                    thickness: 2,
                                    color: Color(0xFFF1F4F8),
                                  ),
                                ),
                                FormDetail().buildText(
                                    "โรคที่พบ :  ", result[0].disease),
                                SizedBox(height: 5),
                                FormDetail().buildText(
                                    "วิธีแก้ไข :  ", result[0].fixDisease),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: Divider(
                                    height: 24,
                                    thickness: 2,
                                    color: Color(0xFFF1F4F8),
                                  ),
                                ),
                                FormDetail().buildText(
                                    "แมลงที่พบ :  ", result[0].insect),
                                SizedBox(height: 5),
                                FormDetail().buildText(
                                    "วิธีแก้ไข :  ", result[0].fixInsect),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: Divider(
                                    height: 24,
                                    thickness: 2,
                                    color: Color(0xFFF1F4F8),
                                  ),
                                ),
                                FormDetail().buildText("เก็บซาก :  ",
                                    result[0].weight.toString() + ' Kg'),
                                SizedBox(height: 5),
                                FormDetail().buildText(
                                    "วันที่เก็บซาก : ",
                                    f.format(result[0].logTime).toString() +
                                        ' น.'),
                                SizedBox(height: 5),
                                FormDetail().buildText("เหตุผลที่เก็บซาก :  ",
                                    result[0].trashRemark),
                                Divider(
                                  height: 24,
                                  thickness: 2,
                                  color: Color(0xFFF1F4F8),
                                ),
                                SizedBox(height: 10),
                                FormDetail().buildText("*** หมายเหตุ :  ",
                                    result[0].remark.toString()),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
            }
            return const LinearProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditPlantTracking(
                PlantrackingID: widget.PlantrackingID, UserID: widget.UserID);
          })).then((value) => setState(() {}));
        },
        backgroundColor: const Color(0xFF036568),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      // floatingActionButton: SpeedDial(
      //   animatedIcon: AnimatedIcons.menu_close,
      //   backgroundColor: Color.fromARGB(170, 3, 101, 104),
      //   children: [
      //     SpeedDialChild(
      //         child: Icon(Icons.edit, color: Colors.white),
      //         backgroundColor: Color(0xFF036568),
      //         label: 'แก้ไข',
      //         onTap: () =>
      //             Navigator.push(context, MaterialPageRoute(builder: (context) {
      //               return EditPlantTracking(
      //                   PlantrackingID: widget.PlantrackingID);
      //             }))),
      //     SpeedDialChild(
      //         child: Icon(
      //           Icons.edit_calendar_outlined,
      //           color: Colors.white,
      //         ),
      //         backgroundColor: Color(0xFF036568),
      //         label: 'ข้อมูลการติดตาม',
      //         onTap: () =>
      //             Navigator.push(context, MaterialPageRoute(builder: (context) {
      //               return TrackingPage();
      //             }))),
      //   ],
      // ),
    );
  }
}
