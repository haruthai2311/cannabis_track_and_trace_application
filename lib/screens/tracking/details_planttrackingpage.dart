import 'package:cannabis_track_and_trace_application/screens/tracking/editplanttracking.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/plant_tracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import '../../api/hostapi.dart';
import '../../api/planttracking.dart';
import '../../config/styles.dart';
import 'package:http/http.dart' as http;

class DetailsPlantTrackingPage extends StatefulWidget {
  final String PlantrackingID;
  const DetailsPlantTrackingPage({Key? key, required this.PlantrackingID})
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
                child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Form(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
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
                                SizedBox(
                                  //width: 270,
                                  height: 230,
                                  child: Image.network(
                                      hostAPI + result[0].fileName),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("โรงปลูก :", _ctlGHName),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("รอบที่ปลูก :", _ctlCulNo),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("วันที่บันทึก :", _ctlCheckDate),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("หมายเลขกระถาง :", _ctlPotId),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("สถานะปัจจุบัน :", _ctlPlantStatus),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("ความชื้นของดิน :", _ctlSoilMoisture),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox(
                                "หมายเหตุ(ความชื้นของดิน) :", _ctlSoilRemark),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("โรคที่พบ :", _ctlDisease),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("วิธีแก้ไข :", _ctlFixDisease),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("แมลงที่พบ :", _ctlInsect),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("วิธีแก้ไข :", _ctlFixInsect),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("เก็บซาก :", _ctlWeight),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("เหตุผลที่เก็บซาก :", _ctlTrashRemark),
                            const SizedBox(
                              height: 15,
                            ),
                            buildBox("หมายเหตุ :", _ctlRemark),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ));
          }
          return const LinearProgressIndicator();
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () =>   Navigator.push(context,
      //                                   MaterialPageRoute(builder: (context) {
      //                                 return PlantTracking(UserID: '14');
      //                               })),
      //   tooltip: 'Open New Page',
      //   child: Icon(Icons.edit),
      // ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Color.fromARGB(170, 3, 101, 104),
        children: [
          SpeedDialChild(
            child: Icon(Icons.edit,color: Colors.white),
            backgroundColor: Color(0xFF036568),
            label: 'แก้ไข',
            onTap: () => Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return EditPlantTracking(PlantrackingID: widget.PlantrackingID);
                                    }))
          ),
          SpeedDialChild(
            child: Icon(Icons.edit_calendar_outlined,color: Colors.white,),
            backgroundColor: Color(0xFF036568),
            label: 'ข้อมูลการติดตาม',
             onTap: () => Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return PlantTracking(UserID: '14');
                                    }))
          ),

        ],
      ),
    );
  }

  Widget buildBox(String title, controller) {
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
            readOnly: true,
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
