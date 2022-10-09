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
        backgroundColor: kBackground,
      ),
      body: FutureBuilder(
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
                /* หมายเลขกระถาง คือ potsID หรือ Name */
                const Text(
                  // "บันทึกผลตรวจประจำวัน \n กระถางหมายเลข : ${result[0].potsName}",

                  "การเก็บเกี่ยว",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 8, 143, 114)),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ListView.builder(
                        itemCount: result.length,
                        //reverse: true,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final harvests = result[index];
                          return Card(
                            child: ListTile(
                              title: Text("รอบการเก็บเกี่ยว : " + harvests.harvestNo.toString()),
                              subtitle: Text('โรงปลูก : ' +
                                  harvests.nameGh
                                 ),
                              trailing: const Icon(Icons.arrow_forward),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailsHarvest(
                                          UserID: widget.UserID,
                                           harvestId: harvests.harvestId.toString(),
                                        ))).then((value) => setState(() {}));
                              },
                            ),
                          );
                        }),
                  ),
                ),
              ],
            );
          }
          return const LinearProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AddHarvests(UserID: widget.UserID);
                })).then((value) => setState(() {}));
        },
        backgroundColor: const Color(0xFF036568),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

