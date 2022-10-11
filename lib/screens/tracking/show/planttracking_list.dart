import 'package:cannabis_track_and_trace_application/screens/tracking/show/details_planttrackingpage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../api/hostapi.dart';
import '../../../api/planttracking.dart';
import '../../../config/styles.dart';
import 'package:http/http.dart' as http;

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

  final f = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.pink,
                Colors.white60,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
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
                //print(result);
                return Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    const Text(
                      "บันทึกผลตรวจประจำวัน",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Text(
                      "กระถางหมายเลข : ${result[0].potsName}",
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
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final Plantracking = result[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ListTile(
                                      title: Text("วันที่ : " +
                                          f.format(Plantracking.checkDate)),
                                      subtitle: const Text('Tracking'),
                                      trailing: const Icon(Icons.arrow_forward),
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
        ));
  }
}
