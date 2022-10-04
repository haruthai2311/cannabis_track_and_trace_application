import 'package:cannabis_track_and_trace_application/screens/tracking/edit/editplanttracking.dart';
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
        title: Text("Plant Tracking"),
      ),
      body: FutureBuilder(
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
                child: Stack(
              children: <Widget>[
                Image.network(
                  hostAPI + result[0].fileName,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 350.0, 0.0, 0.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Material(
                      borderRadius: BorderRadius.circular(35.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),

                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            child: Text(
                                              "โรงปลูก : ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              result[0].ghName.toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: <Widget>[
                                          const Expanded(
                                            child: Text(
                                              "รอบปลูก :",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              result[0].no.toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),

                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Expanded(
                                      child: Text(
                                        "หมายเลขกระถาง :",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        result[0].potsName.toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),

                                //buildBox("รอบที่ปลูก :", _ctlCulNo),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Text(
                                      "วันที่บันทึก :  ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      f.format(result[0].checkDate).toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),

                                //buildBox("วันที่บันทึก :", _ctlCheckDate),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Expanded(
                                      child: Text(
                                        "สถานะปัจจุบัน : ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        Status,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),

                                //buildBox("สถานะปัจจุบัน :", _ctlPlantStatus),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Expanded(
                                      child: Text(
                                        "ความชื้นของดิน : ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        SoilMoisture,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),

                                //buildBox("ความชื้นของดิน :", _ctlSoilMoisture),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Expanded(
                                      child: Text(
                                        "หมายเหตุ :\n(ความชื้นของดิน) ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        result[0].soilRemark.toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                // buildBox(
                                //     "หมายเหตุ(ความชื้นของดิน) :", _ctlSoilRemark),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Expanded(
                                      child: Text(
                                        "หมายเหตุ : ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        result[0].remark.toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                //buildBox("โรคที่พบ :", _ctlDisease),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Expanded(
                                      child: Text(
                                        "โรคที่พบ : ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        result[0].disease,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Expanded(
                                      child: Text(
                                        "วิธีแก้ไข : ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        result[0].fixDisease,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                //buildBox("วิธีแก้ไข :", _ctlFixDisease),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Expanded(
                                      child: Text(
                                        "แมลงที่พบ : ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        result[0].insect,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                // buildBox("แมลงที่พบ :", _ctlInsect),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Expanded(
                                      child: Text(
                                        "วิธีแก้ไข : ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        result[0].fixInsect,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                // buildBox("วิธีแก้ไข :", _ctlFixInsect),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Expanded(
                                      child: Text(
                                        "เก็บซาก : ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        result[0].weight.toString() + ' Kg',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                // buildBox("เก็บซาก :", _ctlWeight),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Text(
                                      "วันที่เก็บซาก :  ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      f.format(result[0].logTime).toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                // buildBox("วันที่เก็บซาก :", _ctlLogtime),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Expanded(
                                      child: Text(
                                        "เหตุผลที่เก็บซาก : ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        result[0].trashRemark,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                // buildBox("เหตุผลที่เก็บซาก :", _ctlTrashRemark),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
              
            ));
          }
          return const LinearProgressIndicator();
        },
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
