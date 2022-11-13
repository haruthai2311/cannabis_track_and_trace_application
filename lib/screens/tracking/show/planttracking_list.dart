import 'package:cannabis_track_and_trace_application/screens/tracking/show/details_planttrackingpage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../api/hostapi.dart';
import '../../../api/planttracking.dart';
import '../../../config/styles.dart';
import 'package:http/http.dart' as http;

import '../add/plant_trackingbyscan.dart';

class ListPlantTrackingPage extends StatefulWidget {
  final String code;
  final String UserID;
  const ListPlantTrackingPage(
      {Key? key, required this.code, required this.UserID})
      : super(key: key);

  @override
  State<ListPlantTrackingPage> createState() => _ListPlantTrackingPageState();
}

class _ListPlantTrackingPageState extends State<ListPlantTrackingPage> {
  late List<Plantracking> _listplanttracking;

  Future<List<Plantracking>> getPlanttracking() async {
    var url = hostAPI + '/trackings/getPlantracking?Barcode=' + widget.code;
    print(url);
    var response = await http.get(Uri.parse(url));
    _listplanttracking = plantrackingFromJson(response.body);

    return _listplanttracking;
  }

  @override
  void initState() {
    super.initState();
    getPlanttracking();
    //print(widget.UserID);
  }

  late String PotID;

  final f = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/CardListTracking1.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: FutureBuilder(
          future: getPlanttracking(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                Container();
              }

              if (snapshot.data.length == 0) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          Text(
                            "บันทึกผลตรวจประจำวัน",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 1),
                      child: Row(
                        children: [
                          const Text(
                            "List Plant Tracking",
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {},
                            child: const Text(
                              "all",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(240, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'ไม่พบข้อมูลบาร์โค้ด',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 143, 8, 8)),
                        ),
                      ),
                    ))
                  ],
                );
              }

              var result = snapshot.data;
              PotID = result[0].potId.toString();
              //print(result);
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Text(
                          "บันทึกผลตรวจประจำวัน",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          "กระถางหมายเลข : ${result[0].potsName}",
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 1),
                    child: Row(
                      children: [
                        const Text(
                          "List Plant Tracking",
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {},
                          child: const Text(
                            "all",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(240, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ListView.builder(
                            itemCount: result.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final Plantracking = result[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 2,
                                        color: Color(0x33000000),
                                        offset: Offset(1, 3),
                                        spreadRadius: 1,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.pink,
                                    border: Border.all(
                                      color: const Color(0xFFCFD4DB),
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      child: ListTile(
                                        title: Text("วันที่ : " +
                                            f.format(Plantracking.checkDate)),
                                        subtitle: const Text('Tracking'),
                                        trailing:
                                            const Icon(Icons.chevron_right),
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsPlantTrackingPage(
                                                          PlantrackingID:
                                                              Plantracking
                                                                  .plantTrackingId
                                                                  .toString(),
                                                          UserID:
                                                              widget.UserID)));
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const LinearProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PlantTrackingByScan(UserID: widget.UserID, PotID: PotID);
          })).then((value) => setState(() {}));
        },
        backgroundColor: colorTabbar,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
