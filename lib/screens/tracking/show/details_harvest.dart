import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../api/allharvests.dart';
import '../../../api/hostapi.dart';
import '../../../config/styles.dart';
import '../edit/edit_harvest.dart';

class DetailsHarvest extends StatefulWidget {
  final String UserID;
  final String harvestId;
  const DetailsHarvest(
      {Key? key, required this.UserID, required this.harvestId})
      : super(key: key);

  @override
  State<DetailsHarvest> createState() => _DetailsHarvestState();
}

class _DetailsHarvestState extends State<DetailsHarvest> {
  late List<Harvests> _Harvests;
  Future<List<Harvests>> getHarvests() async {
    var url = hostAPI + '/trackings/getHarvest?id=' + widget.harvestId;
    print(url);
    var response = await http.get(Uri.parse(url));
    _Harvests = harvestsFromJson(response.body);

    return _Harvests;
  }

  @override
  void initState() {
    super.initState();
    //getPlanttracking();
    //print(widget.UserID);
  }

  final f = DateFormat('dd/MM/yyyy  hh:mm:ss');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
        title: const Text("Harvest"),
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
          future: getHarvests(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                Container();
              }
              var result = snapshot.data;
              String Type;
              String type = result[0].type.toString();
              if (type == "1") {
                Type = "ใบ";
              } else if (type == "2") {
                Type = "ดอก";
              } else if (type == "3") {
                Type = "ก้าน";
              } else {
                Type = "N/A";
              }
              return SingleChildScrollView(
                  child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                        child: Column(children: [
                          Row(
                            children: <Widget>[
                              const Expanded(
                                child: Text(
                                  "โรงปลูก : ",
                                  style: TextStyle(
                                      color: colorDetails2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  result[0].nameGh.toString(),
                                  style: const TextStyle(
                                      color: colorDetails2,
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
                                  "วันที่เก็บเกี่ยว :",
                                  style: TextStyle(
                                      color: colorDetails2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  f.format(result[0].harvestDate).toString(),
                                  style: const TextStyle(
                                      color: colorDetails2,
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
                                  "ครั้งที่ :",
                                  style: TextStyle(
                                      color: colorDetails2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  result[0].harvestNo.toString(),
                                  style: const TextStyle(
                                      color: colorDetails2,
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
                              const Text(
                                "ประเภท :  ",
                                style: TextStyle(
                                    color: colorDetails2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                Type,
                                style: const TextStyle(
                                    color: colorDetails2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: <Widget>[
                              const Text(
                                "น้ำหนัก :  ",
                                style: TextStyle(
                                    color: colorDetails2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                result[0].weight.toString() + " Kg",
                                style: const TextStyle(
                                    color: colorDetails2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
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
                                  "หมายเลขล๊อต :",
                                  style: TextStyle(
                                      color: colorDetails2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  result[0].lotNo.toString(),
                                  style: const TextStyle(
                                      color: colorDetails2,
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
                              const Text(
                                "หมายเหตุ : ",
                                style: TextStyle(
                                    color: colorDetails2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                result[0].remark.toString(),
                                style: const TextStyle(
                                    color: colorDetails2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  )
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
            return EditHarvest(
              UserID: widget.UserID,
              harvestId: widget.harvestId,
            );
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
