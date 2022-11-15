import 'package:cannabis_track_and_trace_application/screens/tracking/show/details_planttrackingpage.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/show/planttracking_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../api/hostapi.dart';
import '../../../api/planttracking.dart';
import '../../../api/potslist.dart';
import '../../../config/styles.dart';
import 'package:http/http.dart' as http;

import '../add/plant_trackingbyscan.dart';

class ListPots extends StatefulWidget {
  final String UserID;
  const ListPots({Key? key, required this.UserID}) : super(key: key);

  @override
  State<ListPots> createState() => _ListPotsState();
}

class _ListPotsState extends State<ListPots> {
  late List<Potslist> _listpots;

  Future<List<Potslist>> getData() async {
    var url = hostAPI + '/trackings/Potslist';
    print(url);
    var response = await http.get(Uri.parse(url));
    _listpots = potslistFromJson(response.body);

    return _listpots;
  }

  @override
  void initState() {
    super.initState();

    //print(widget.UserID);
  }

  late String PotID;
  late String GHName;

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
          future: getData(),
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
              PotID = result[0].barcode.toString();
              GHName = result[0].ghName.toString();
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
                        // Text(
                        //   "กระถางหมายเลข : ${result[0].potsName}",
                        //   style: const TextStyle(
                        //       fontSize: 24,
                        //       fontWeight: FontWeight.w600,
                        //       color: Colors.white),
                        // ),
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
                              final p = result[index];
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
                                        title: Text("บาร์โค้ด : " + p.barcode),
                                        subtitle: Text(
                                            'รอบปลูกที่ ${p.cultivationId} โรงปลูก ${p.ghName}'),
                                        trailing:
                                            const Icon(Icons.chevron_right),
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ListPlantTrackingPage(
                                                        UserID: widget.UserID,
                                                        code: p.barcode,
                                                      )));
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context) {
      //       return PlantTrackingByScan(
      //         UserID: widget.UserID,
      //         PotID: PotID,
      //         GHName: GHName,
      //       );
      //     })).then((value) => setState(() {}));
      //   },
      //   backgroundColor: colorTabbar,
      //   child: const Icon(Icons.add, color: Colors.white),
      // ),
    );
  }
}
