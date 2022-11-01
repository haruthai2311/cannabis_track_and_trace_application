import 'package:cannabis_track_and_trace_application/screens/tracking/edit/edit_cultivation.dart';
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
                                  'Cultivation Summary',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
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
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 8),
                                    child: Container(
                                      width: double.infinity,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Color(0xFFF1F4F8),
                                          width: 2,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10)),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 12, 0),
                                            child: Icon(
                                              Icons.home,
                                              color: Colors.green,
                                              size: 24,
                                            ),
                                          ),
                                          Text(
                                            "โรงปลูก :  ",
                                            style: TextStyle(
                                              color: colorDetails3,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            result[0].nameGh.toString(),
                                            style: TextStyle(
                                              color: colorDetails2,
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 8),
                                    child: Container(
                                      width: double.infinity,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Color(0xFFF1F4F8),
                                          width: 2,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10)),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 12, 0),
                                            child: Icon(Icons.calendar_month,
                                                color: Colors.blueGrey),
                                          ),
                                          Text(
                                            "รอบปลูก :  ",
                                            style: TextStyle(
                                              color: colorDetails3,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            result[0].no.toString(),
                                            style: TextStyle(
                                              color: colorDetails2,
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "สายพันธุ์ :  ",
                                        style: TextStyle(
                                          color: colorDetails3,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        result[0].nameStrains.toString(),
                                        style: TextStyle(
                                          color: colorDetails2,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "วันที่เพาะเมล็ด :  ",
                                        style: TextStyle(
                                          color: colorDetails3,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        f.format(result[0].seedDate).toString(),
                                        style: TextStyle(
                                          color: colorDetails2,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "วันที่ย้ายปลูก :  ",
                                        style: TextStyle(
                                          color: colorDetails3,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        f.format(result[0].moveDate).toString(),
                                        style: const TextStyle(
                                          color: colorDetails2,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "จำนวนเมล็ด :  ",
                                        style: TextStyle(
                                          color: colorDetails3,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        result[0].seedTotal.toString(),
                                        style: const TextStyle(
                                          color: colorDetails2,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "น้ำหนักเมล็ด :  ",
                                        style: TextStyle(
                                          color: colorDetails3,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        result[0].seedNet.toString() + " Kg.",
                                        style: const TextStyle(
                                          color: colorDetails2,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "จำนวนต้นทั้งหมด :  ",
                                        style: TextStyle(
                                          color: colorDetails3,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        result[0].plantTotal.toString(),
                                        style: const TextStyle(
                                          color: colorDetails2,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "จำนวนต้นเป็นทั้งหมด :  ",
                                        style: TextStyle(
                                          color: colorDetails3,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        result[0].plantLive.toString(),
                                        style: const TextStyle(
                                          color: colorDetails2,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "จำนวนต้นตายทั้งหมด :  ",
                                        style: TextStyle(
                                          color: colorDetails3,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        result[0].plantDead.toString(),
                                        style: const TextStyle(
                                          color: colorDetails2,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "หมายเหตุ :  ",
                                        style: TextStyle(
                                          color: colorDetails3,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        result[0].remark.toString(),
                                        style: const TextStyle(
                                          color: colorDetails2,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "หมายเหตุ :  ",
                                        style: TextStyle(
                                          color: colorDetails3,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          //fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        result[0].remark.toString(),
                                        style: const TextStyle(
                                          color: colorDetails2,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                          //fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
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
