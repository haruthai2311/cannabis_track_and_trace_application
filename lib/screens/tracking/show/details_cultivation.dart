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
          future: getCultivation(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                Container();
              }
              var result = snapshot.data;

              return SingleChildScrollView(
                  child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                        child: Column(children: [
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        "โรงปลูก : ",
                                        style: TextStyle(
                                            color: colorDetails2,
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        result[0].nameGh.toString(),
                                        style: const TextStyle(
                                            color: colorDetails2,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
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
                                  "รอบปลูก :",
                                  style: TextStyle(
                                      color: colorDetails2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  result[0].no.toString(),
                                  style: const TextStyle(
                                      color: colorDetails2,
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
                              Text(
                                "สายพันธุ์ :  ",
                                style: TextStyle(
                                    color: colorDetails2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                result[0].nameStrains.toString(),
                                style: const TextStyle(
                                    color: colorDetails2,
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
                                "วันที่เพาะเมล็ด :  ",
                                style: TextStyle(
                                    color: colorDetails2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                f.format(result[0].seedDate).toString(),
                                style: const TextStyle(
                                    color: colorDetails2,
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
                                "วันที่ย้ายปลูก :  ",
                                style: TextStyle(
                                    color: colorDetails2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                f.format(result[0].moveDate).toString(),
                                style: const TextStyle(
                                    color: colorDetails2,
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
                                  "จำนวนเมล็ด :",
                                  style: TextStyle(
                                      color: colorDetails2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  result[0].seedTotal.toString(),
                                  style: const TextStyle(
                                      color: colorDetails2,
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
                              const Expanded(
                                child: Text(
                                  "น้ำหนักเมล็ด : ",
                                  style: TextStyle(
                                      color: colorDetails2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  result[0].seedNet.toString() + " Kg.",
                                  style: const TextStyle(
                                      color: colorDetails2,
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
                                "จำนวนต้นทั้งหมด : ",
                                style: TextStyle(
                                    color: colorDetails2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                result[0].plantTotal.toString(),
                                style: const TextStyle(
                                    color: colorDetails2,
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
                                "จำนวนต้นเป็นทั้งหมด : ",
                                style: TextStyle(
                                    color: colorDetails2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                result[0].plantLive.toString(),
                                style: const TextStyle(
                                    color: colorDetails2,
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
                                "จำนวนต้นตายทั้งหมด : ",
                                style: TextStyle(
                                    color: colorDetails2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                result[0].plantDead.toString(),
                                style: const TextStyle(
                                    color: colorDetails2,
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
                                "หมายเหตุ : ",
                                style: TextStyle(
                                    color: colorDetails2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                result[0].remark.toString(),
                                style: const TextStyle(
                                    color: colorDetails2,
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
                                "หมายเหตุ : ",
                                style: TextStyle(
                                    color: colorDetails2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                result[0].remark.toString(),
                                style: const TextStyle(
                                    color: colorDetails2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  )
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
