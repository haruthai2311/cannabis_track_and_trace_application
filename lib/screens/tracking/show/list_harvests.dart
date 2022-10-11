import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../api/allharvests.dart';
import '../../../api/hostapi.dart';
import '../../../config/styles.dart';
import '../add/harvests.dart';
import 'details_harvest.dart';

class ListHarveste extends StatefulWidget {
  final String UserID;
  const ListHarveste({Key? key, required this.UserID}) : super(key: key);

  @override
  State<ListHarveste> createState() => _ListHarvesteState();
}

class _ListHarvesteState extends State<ListHarveste> {
  late List<Harvests> _Harvests;
  Future<List<Harvests>> getHarvests() async {
    var url = hostAPI + '/trackings/getHarvests';
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

  final f = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
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
                  const SizedBox(height: 20),
                  Text(
                    "การเก็บเกี่ยว",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ListView.builder(
                            itemCount: result.length,
                            //reverse: true,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final harvests = result[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                        "รอบการเก็บเกี่ยว : " +
                                            harvests.harvestNo.toString(),
                                        style: TextStyle(
                                            color: kBackground,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    subtitle: Text(
                                      'โรงปลูก : ' + harvests.nameGh,
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
                                                  DetailsHarvest(
                                                    UserID: widget.UserID,
                                                    harvestId: harvests
                                                        .harvestId
                                                        .toString(),
                                                  )))
                                          .then((value) => setState(() {}));
                                    },
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
            return AddHarvests(UserID: widget.UserID);
          })).then((value) => setState(() {}));
        },
        backgroundColor: Color.fromARGB(255, 2, 68, 182),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
