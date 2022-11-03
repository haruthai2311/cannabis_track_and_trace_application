import 'package:cannabis_track_and_trace_application/screens/tracking/edit/edit_cultivation.dart';
import 'package:cannabis_track_and_trace_application/widget/formDetail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../../api/allcultivations.dart';
import '../../../api/hostapi.dart';
import '../../../config/styles.dart';

class DetailsCultivation extends StatefulWidget {
  final String UserID;
  final String CultivationID;
  const DetailsCultivation(
      {Key? key, required this.UserID, required this.CultivationID})
      : super(key: key);

  @override
  State<DetailsCultivation> createState() => _DetailsCultivationState();
}

class _DetailsCultivationState extends State<DetailsCultivation> {
  late List<Cultivations> _listCultivation;

  Future<List<Cultivations>> getCultivation() async {
    var url = hostAPI + '/trackings/Cultivation?ID=' + widget.CultivationID;
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
        title: const Text("Cultivation"),
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
          future: getCultivation(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                Container();
              }
              var result = snapshot.data;

              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      //padding: EdgeInsets.only(top: 100),
                      padding: EdgeInsets.all(10),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 5, 0, 20),
                              child: Container(
                                width: 60,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Color(0xFFDBE2E7),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'รายละเอียดข้อมูลการปลูก',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ตรวจสอบความถูกต้องด้านล่าง',
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Divider(
                                height: 24,
                                thickness: 2,
                                color: Color(0xFFF1F4F8),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  FormDetail().buildSubject(
                                      "โรงปลูก :  ",
                                      result[0].nameGh.toString(),
                                      Icons.home,
                                      Colors.green),
                                  FormDetail().buildSubject(
                                      "รอบปลูก :  ",
                                      result[0].no.toString(),
                                      Icons.calendar_month,
                                      Colors.blueGrey),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                children: [
                                  FormDetail().buildText("สายพันธุ์ :  ",
                                      result[0].nameStrains.toString()),
                                  SizedBox(height: 5),
                                  FormDetail().buildText("วันที่เพาะเมล็ด :  ",
                                      f.format(result[0].seedDate).toString()),
                                  SizedBox(height: 5),
                                  FormDetail().buildText("วันที่ย้ายปลูก :  ",
                                      f.format(result[0].moveDate).toString()),
                                  SizedBox(height: 5),
                                  FormDetail().buildText(
                                      "จำนวนเมล็ด :  ",
                                      result[0].seedTotal.toString() +
                                          ' เมล็ด'),
                                  SizedBox(height: 5),
                                  FormDetail().buildText("น้ำหนักเมล็ด :  ",
                                      result[0].seedNet.toString() + " Kg."),
                                  SizedBox(height: 5),
                                  FormDetail().buildText("จำนวนต้นทั้งหมด :  ",
                                      result[0].plantTotal.toString() + ' ต้น'),
                                  SizedBox(height: 5),
                                  FormDetail().buildText(
                                      "จำนวนต้นเป็นทั้งหมด :  ",
                                      result[0].plantLive.toString() + ' ต้น'),
                                  SizedBox(height: 5),
                                  FormDetail().buildText(
                                      "จำนวนต้นตายทั้งหมด :  ",
                                      result[0].plantDead.toString() + ' ต้น'),
                                  SizedBox(height: 5),
                                  FormDetail().buildText("หมายเหตุ :  ",
                                      result[0].remark.toString()),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    //SizedBox(height: 30),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20, right: 20),
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       Navigator.push(context,
                    //           MaterialPageRoute(builder: (context) {
                    //         return EditCultivation(
                    //           UserID: widget.UserID,
                    //           CultivationID: widget.CultivationID,
                    //         );
                    //       })).then((value) => setState(() {}));
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: colorTabbar,
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(30)),
                    //       padding: EdgeInsets.zero,
                    //     ),
                    //     child: Container(
                    //       width: double.infinity,
                    //       height: 50,
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Text(
                    //             'Edit',
                    //             style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 20,
                    //               fontWeight: FontWeight.w500,
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             width: 10,
                    //           ),
                    //           Icon(Icons.edit)
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              );
            }
            return const LinearProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditCultivation(
              UserID: widget.UserID,
              CultivationID: widget.CultivationID,
            );
          })).then((value) => setState(() {}));
        },
        backgroundColor: const Color(0xFF036568),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}
