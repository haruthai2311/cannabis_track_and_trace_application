import 'package:cannabis_track_and_trace_application/screens/tracking/add/transfers.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/show/details_transfer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../api/gettransfers.dart';
import '../../../api/hostapi.dart';
import '../../../config/styles.dart';
import 'package:http/http.dart' as http;

class ListTransfers extends StatefulWidget {
  final String UserID;
  const ListTransfers({Key? key, required this.UserID}) : super(key: key);

  @override
  State<ListTransfers> createState() => _ListTransfersState();
}

class _ListTransfersState extends State<ListTransfers> {
  late List<GetTransfers> _listTransfers;
  Future<List<GetTransfers>> getTransfers() async {
    var url = hostAPI + '/trackings/getTransfers';
    print(url);
    var response = await http.get(Uri.parse(url));
    _listTransfers = getTransfersFromJson(response.body);

    return _listTransfers;
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
        future: getTransfers(),
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

                  "การส่งมอบ",
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
                          final transfers = result[index];
                          return Card(
                            child: ListTile(
                              title: Text("หมายเลขการส่งมอบ : " +
                                  transfers.transferId.toString()),
                              subtitle: Text('วันที่ : ' +
                                  f.format(transfers.transferDate)),
                              trailing: const Icon(Icons.arrow_forward),
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => DetailsTransfer(
                                              UserID: widget.UserID,
                                              TransferID: transfers.transferId
                                                  .toString(),
                                            )))
                                    .then((value) => setState(() {}));
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
            return AddTransfers(UserID: widget.UserID);
          })).then((value) => setState(() {}));
        },
        backgroundColor: const Color(0xFF036568),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
