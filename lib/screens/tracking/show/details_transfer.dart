import 'package:cannabis_track_and_trace_application/screens/tracking/edit/edit_transfer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../api/gettransfers.dart';
import '../../../api/hostapi.dart';
import '../../../config/styles.dart';

class DetailsTransfer extends StatefulWidget {
  final String UserID;
  final String TransferID;
  const DetailsTransfer(
      {Key? key, required this.UserID, required this.TransferID})
      : super(key: key);

  @override
  State<DetailsTransfer> createState() => _DetailsTransferState();
}

class _DetailsTransferState extends State<DetailsTransfer> {
  late List<GetTransfers> _Transfer;
  Future<List<GetTransfers>> getTransfer() async {
    var url = hostAPI + '/trackings/getTransfer?id=' + widget.TransferID;
    print(url);
    var response = await http.get(Uri.parse(url));
    _Transfer = getTransfersFromJson(response.body);

    return _Transfer;
  }

  @override
  void initState() {
    super.initState();
    //getPlanttracking();
    print(widget.TransferID);
  }

  final f = DateFormat('dd/MM/yyyy  hh:mm:ss');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
        title: const Text("Transfer"),
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
          future: getTransfer(),
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
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 20),
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
                              'รายละเอียดข้อมูลการส่งมอบ',
                              style: TextStyle(
                                color: Colors.green,
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
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
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
                                          padding: EdgeInsets.only(left: 10)),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 12, 0),
                                        child: Icon(
                                          Icons.pin,
                                          color: Colors.green,
                                          size: 20,
                                        ),
                                      ),
                                      Text(
                                        "หมายเลขการเก็บเกี่ยว :  ",
                                        style: TextStyle(
                                          color: colorDetails3,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        result[0].harvestId.toString(),
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
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
                                          padding: EdgeInsets.only(left: 10)),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 12, 0),
                                        child: Icon(
                                          Icons.grade,
                                          color: Colors.orange,
                                          size: 20,
                                        ),
                                      ),
                                      Text(
                                        "ครั้งที่ :  ",
                                        style: TextStyle(
                                          color: colorDetails3,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        result[0].harvestNo.toString(),
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
                                    "วันที่ :  ",
                                    style: TextStyle(
                                      color: colorDetails3,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    f.format(result[0].transferDate).toString(),
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
                                    "ประเภท :  ",
                                    style: TextStyle(
                                      color: colorDetails3,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    Type,
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
                                    "น้ำหนัก :  ",
                                    style: TextStyle(
                                      color: colorDetails3,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    result[0].weight.toString() + " Kg",
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
                                    "หมายเลขล๊อต :  ",
                                    style: TextStyle(
                                      color: colorDetails3,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    result[0].lotNo.toString(),
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
                                    "ชื่อผู้รับ :  ",
                                    style: TextStyle(
                                      color: colorDetails3,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    result[0].getByName.toString(),
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
                                    "ชื่อสถานที่ :  ",
                                    style: TextStyle(
                                      color: colorDetails3,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    result[0].getByPlace.toString(),
                                    style: TextStyle(
                                      color: colorDetails2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(children: [
                                Text(
                                  "เลขที่ใบอนุญาต :  ",
                                  style: TextStyle(
                                    color: colorDetails3,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  result[0].licenseNo.toString(),
                                  style: TextStyle(
                                    color: colorDetails2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ]),
                              SizedBox(height: 5),
                              Row(children: [
                                Text(
                                  "ป้ายทะเบียนรถ :  ",
                                  style: TextStyle(
                                    color: colorDetails3,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  result[0].licensePlate.toString(),
                                  style: TextStyle(
                                    color: colorDetails2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ]),
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
                                    style: TextStyle(
                                      color: colorDetails2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ]),
                    ),
                  ),
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
            return EditTransfer(
              UserID: widget.UserID,
              TransferID: widget.TransferID,
            );
          })).then((value) => setState(() {}));
        },
        backgroundColor: const Color(0xFF036568),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}
