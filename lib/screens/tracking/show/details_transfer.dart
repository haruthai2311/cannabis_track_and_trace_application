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
      body: FutureBuilder(
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
                child: Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: kBackground,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    child: Column(children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            "หมายเลขการเก็บเกี่ยว : ",
                            style: TextStyle(
                                color: colorDetails,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            result[0].harvestId.toString(),
                            style: const TextStyle(
                                color: colorDetails,
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
                              "ครั้งที่ :",
                              style: TextStyle(
                                  color: colorDetails,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              result[0].harvestNo.toString(),
                              style: const TextStyle(
                                  color: colorDetails,
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
                            "วันที่ :  ",
                            style: TextStyle(
                                color: colorDetails,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            f.format(result[0].transferDate).toString(),
                            style: const TextStyle(
                                color: colorDetails,
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
                            "ประเภท :  ",
                            style: TextStyle(
                                color: colorDetails,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            Type,
                            style: const TextStyle(
                                color: colorDetails,
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
                                color: colorDetails,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            result[0].weight.toString() + " Kg",
                            style: const TextStyle(
                                color: colorDetails,
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
                                  color: colorDetails,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              result[0].lotNo.toString(),
                              style: const TextStyle(
                                  color: colorDetails,
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
                            "ชื่อผู้รับ : ",
                            style: TextStyle(
                                color: colorDetails,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            result[0].getByName.toString(),
                            style: const TextStyle(
                                color: colorDetails,
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
                            "ชื่อสถานที่ : ",
                            style: TextStyle(
                                color: colorDetails,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            result[0].getByPlace.toString(),
                            style: const TextStyle(
                                color: colorDetails,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(children: <Widget>[
                        const Text(
                          "เลขที่ใบอนุญาต : ",
                          style: TextStyle(
                              color: colorDetails,
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          result[0].licenseNo.toString(),
                          style: const TextStyle(
                              color: colorDetails,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(children: <Widget>[
                        const Text(
                          "ป้ายทะเบียนรถ : ",
                          style: TextStyle(
                              color: colorDetails,
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          result[0].licensePlate.toString(),
                          style: const TextStyle(
                              color: colorDetails,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            "หมายเหตุ : ",
                            style: TextStyle(
                                color: colorDetails,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            result[0].remark.toString(),
                            style: const TextStyle(
                                color: colorDetails,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ]),
                  ),
                )
              ],
            ));
          }
          return const LinearProgressIndicator();
        },
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
