import 'package:cannabis_track_and_trace_application/screens/tracking/details_planttrackingpage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../api/hostapi.dart';
import '../../api/planttracking.dart';
import '../../config/styles.dart';
import 'package:http/http.dart' as http;

class ListPlantTrackingPage extends StatefulWidget {
  final String code;
  final String UserID;
  const ListPlantTrackingPage(
      {Key? key,required this.code, required this.UserID})
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

  final f = DateFormat('dd/MM/yyyy');
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

              if (snapshot.data.length == 0) {
                return const Center(
                  child: Text(
                    'ไม่พบข้อมูลบาร์โค้ด',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 143, 8, 8)),
                  ),
                );
              }

              var result = snapshot.data;
              print(result);
              return Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  /* หมายเลขกระถาง คือ potsID หรือ Name */
                  const Text(
                    // "บันทึกผลตรวจประจำวัน \n กระถางหมายเลข : ${result[0].potsName}",

                    "บันทึกผลตรวจประจำวัน",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 8, 143, 114)),
                  ),
                  Text(
                    // "บันทึกผลตรวจประจำวัน \n กระถางหมายเลข : ${result[0].potsName}",
                    "กระถางหมายเลข : ${result[0].potsName}",
                    style: const TextStyle(
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
                          reverse: true,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final Plantracking = result[index];
                            return Card(
                              child: ListTile(
                                title: Text("วันที่ : " +
                                    f.format(Plantracking.checkDate)),
                                subtitle: const Text('Tracking'),
                                trailing: const Icon(Icons.arrow_forward),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsPlantTrackingPage(
                                              PlantrackingID: Plantracking
                                                  .plantTrackingId
                                                  .toString(), UserID: widget.UserID)));
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
