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
      body: Container(
        decoration: BoxDecoration(
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
                  Text(
                    "การส่งมอบ",
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
                              final transfers = result[index];
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
                                      "หมายเลขการส่งมอบ : " +
                                          transfers.transferId.toString(),
                                      style: TextStyle(
                                          color: kBackground,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      'วันที่ : ' +
                                          f.format(transfers.transferDate),
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
                                                  DetailsTransfer(
                                                    UserID: widget.UserID,
                                                    TransferID: transfers
                                                        .transferId
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
            return AddTransfers(UserID: widget.UserID);
          })).then((value) => setState(() {}));
        },
        backgroundColor: kBackground,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
