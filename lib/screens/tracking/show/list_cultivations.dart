import 'package:cannabis_track_and_trace_application/screens/tracking/show/details_cultivation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../api/allcultivations.dart';
import '../../../api/hostapi.dart';
import '../../../config/styles.dart';
import '../add/cultivations.dart';

class ListCultivations extends StatefulWidget {
  final String UserID;
  const ListCultivations({Key? key, required this.UserID}) : super(key: key);

  @override
  State<ListCultivations> createState() => _ListCultivationsState();
}

class _ListCultivationsState extends State<ListCultivations> {
  late List<Cultivations> _listCultivation;

  Future<List<Cultivations>> getAllCultivations() async {
    var url = hostAPI + '/trackings/AllCultivations';
    print(url);
    var response = await http.get(Uri.parse(url));
    _listCultivation = cultivationsFromJson(response.body);

    return _listCultivation;
  }

  @override
  void initState() {
    super.initState();
    //getPlanttracking();
    //print(widget.UserID);
  }

  final f = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       kBackground,
        //       Colors.white60,
        //     ],
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //   ),
        // ),
        child: FutureBuilder(
          future: getAllCultivations(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                Container();
              }

              if (snapshot.data.length == 0) {
                return const Center(
                  child: Text(
                    'ไม่พบข้อมูล',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 143, 8, 8)),
                  ),
                );
              }

              var result = snapshot.data;
              //print(result);
              return Column(
                children: <Widget>[
                  Container(
                    //margin: const EdgeInsets.only(left: 5, right: 5),
                    height: 130,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          kBackground,
                          Color.fromARGB(103, 6, 137, 141),
                        ],
                        stops: [0, 1],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(0, 2),
                          spreadRadius: 2,
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "บันทึกการปลูก",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  // Text(
                  //   "บันทึกการปลูก",
                  //   style: TextStyle(
                  //       fontSize: 24,
                  //       fontWeight: FontWeight.w600,
                  //       color: Colors.blueAccent),
                  // ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 30, 1),
                    child: Row(
                      children: [
                        const Text(
                          "List Cultivations",
                          style: TextStyle(
                            color: Colors.black45,
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
                              color: Colors.orange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ListView.builder(
                          itemCount: result.length,
                          //reverse: true,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final Cul = result[index];
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
                                  color: Colors.orange,
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
                                      title: Text(
                                        "รอบการปลูก : " + Cul.no.toString(),
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        'โรงปลูก : ' + Cul.nameGh,
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 116, 116, 116),
                                            fontSize: 16),
                                      ),
                                      trailing: const Icon(Icons.arrow_forward),
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsCultivation(
                                                      UserID: widget.UserID,
                                                      CultivationID: Cul
                                                          .cultivationId
                                                          .toString(),
                                                    )))
                                            .then((value) => setState(() {}));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
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
            return AddCultivations(UserID: widget.UserID);
          })).then((value) => setState(() {}));
        },
        backgroundColor: kBackground,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
