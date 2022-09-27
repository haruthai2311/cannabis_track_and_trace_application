import 'package:cannabis_track_and_trace_application/screens/tracking/show/details_cultivation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../api/allcultivations.dart';
import '../../../api/hostapi.dart';
import '../../../config/styles.dart';

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
        body: FutureBuilder(
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
                  const SizedBox(height: 20),
                  /* หมายเลขกระถาง คือ potsID หรือ Name */
                  const Text(
                    // "บันทึกผลตรวจประจำวัน \n กระถางหมายเลข : ${result[0].potsName}",

                    "บันทึกการปลูก",
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
                            final Cul = result[index];
                            return Card(
                              child: ListTile(
                                title:
                                    Text("รอบการปลูก : " + Cul.no.toString()),
                                subtitle: Text('โรงปลูก : ' +
                                    Cul.nameGh +
                                    " " +
                                    Cul.remark.toString()),
                                trailing: const Icon(Icons.arrow_forward),
                                onTap: () {
                                   Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsCultivation(
                                             UserID: widget.UserID, CultivationID: Cul.cultivationId.toString(),)));
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
        ));
  }
}
