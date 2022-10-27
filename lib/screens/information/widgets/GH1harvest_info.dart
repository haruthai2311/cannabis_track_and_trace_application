import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../api/harvestsbygh.dart';
import '../../../api/hostapi.dart';

class GH1_HarvestInfo extends StatefulWidget {
  final String GreenhouseID;
  const GH1_HarvestInfo({Key? key, required this.GreenhouseID})
      : super(key: key);
  @override
  State<GH1_HarvestInfo> createState() => _GH1_HarvestInfoState();
}

class _GH1_HarvestInfoState extends State<GH1_HarvestInfo> {
  late List<HarvestbyGh> _listharvest;

  Future<List<HarvestbyGh>> getCultivations() async {
    var url = hostAPI + '/trackings/Harvests?gh=${widget.GreenhouseID}';
    print(url);
    var response = await http.get(Uri.parse(url));
    _listharvest = harvestbyGhFromJson(response.body);

    return _listharvest;
  }

  @override
  void initState() {
    super.initState();
    print(widget.GreenhouseID);
  }

  final f = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getCultivations(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == null) {
                  Container();
                }

                if (snapshot.data.length == 0) {
                  return const Center(
                    child: Text(
                      'ไม่พบข้อมูลการเก็บเกี่ยว',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 143, 8, 8)),
                    ),
                  );
                }

                var result = snapshot.data;

                return ListView.builder(
                    itemCount: result.length,

                    //reverse: true,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final Har = result[index];
                      print(result.length);
                      const Color oddcolorgh = Colors.pink;
                      const Color evencolorgh = Colors.blue;
                      String Type;
                      String type = Har.type.toString();
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
                        child: ExpandableTheme(
                          data: const ExpandableThemeData(
                            iconColor: Colors.blue,
                            useInkWell: true,
                          ),
                          child: Column(
                            children: <Widget>[
                              Card1(
                                colorcard:
                                    index.isOdd ? oddcolorgh : evencolorgh,
                                subheading:
                                    f.format(Har.harvestDate).toString() +
                                        ' \n' +
                                        Type +
                                        '\n' +
                                        Har.weight.toString() +
                                        'กิโลกรัม \n' +
                                        f.format(Har.transferDate).toString(),
                                titleno: Har.harvestNo.toString(),
                              ),
                              //Card2(),
                            ],
                          ),
                        ),
                      );
                    });
              }
              return const LinearProgressIndicator();
            }));
  }
}

const topic = "วันที่เก็บเกี่ยว : \nประเภท : \nน้ำหนัก : \nวันที่ส่งมอบ : ";
//const subheading = "22/03/2021 \nก้าน \n20 กิโลกรัม \n16/07/2021";
const subheading2 = "18/02/2022 \nก้าน \n18 กิโลกรัม \n22/06/2022";

class Card1 extends StatelessWidget {
  Card1(
      {required this.subheading,
      required this.colorcard,
      required this.titleno});
  final String titleno;
  final String subheading;
  final Color colorcard;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x33000000),
              offset: Offset(2, 4),
              spreadRadius: 2,
            )
          ],
          borderRadius: BorderRadius.circular(10),
          color: colorcard,
          border: Border.all(
            color: const Color(0xFFCFD4DB),
            width: 1,
          ),
        ),
        child: Padding(
          //padding: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.only(right: 10),

          child: ExpandableNotifier(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Column(
                  children: <Widget>[
                    ScrollOnExpand(
                      scrollOnExpand: true,
                      scrollOnCollapse: false,
                      child: ExpandablePanel(
                        theme: const ExpandableThemeData(
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
                          tapBodyToCollapse: true,
                        ),
                        header: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'เก็บเกี่ยวครั้งที่ '+titleno,
                            style: TextStyle(
                                fontSize: 22,
                                color: colorcard,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        collapsed: Row(
                          children: [
                            Text(
                              topic,
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              subheading,
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        expanded: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            for (var _ in Iterable.generate(1))
                              Text(
                                topic,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                            Text(
                              subheading,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: <Widget>[
                            //     for (var _ in Iterable.generate(1))
                            //       Text(
                            //         subheading,
                            //         softWrap: true,
                            //         overflow: TextOverflow.fade,
                            //         style: TextStyle(
                            //           fontSize: 18,
                            //           color: Colors.black,
                            //         ),
                            //       ),
                            //   ],
                            // ),
                          ],
                        ),
                        builder: (_, collapsed, expanded) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 10,
                            ),
                            child: Expandable(
                              collapsed: collapsed,
                              expanded: expanded,
                              theme:
                                  const ExpandableThemeData(crossFadePoint: 0),
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Builder(
                            builder: (context) {
                              var controller = ExpandableController.of(context,
                                  required: true)!;
                              return TextButton(
                                child: Text(
                                  controller.expanded
                                      ? "แสดงน้อยลง"
                                      : "ดูเพิ่มเติม",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: colorcard,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                onPressed: () {
                                  controller.toggle();
                                },
                              );
                            },
                          ),
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Card2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x33000000),
              offset: Offset(2, 4),
              spreadRadius: 2,
            )
          ],
          borderRadius: BorderRadius.circular(10),
          color: Colors.pink,
          border: Border.all(
            color: const Color(0xFFCFD4DB),
            width: 1,
          ),
        ),
        child: Padding(
          //padding: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.only(right: 10),

          child: ExpandableNotifier(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Column(
                  children: <Widget>[
                    ScrollOnExpand(
                      scrollOnExpand: true,
                      scrollOnCollapse: false,
                      child: ExpandablePanel(
                        theme: const ExpandableThemeData(
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
                          tapBodyToCollapse: true,
                        ),
                        header: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'เก็บเกี่ยวครั้งที่ 2',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.pink,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        collapsed: Row(
                          children: [
                            Text(
                              topic,
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              subheading2,
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        expanded: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            for (var _ in Iterable.generate(1))
                              Text(
                                topic,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                            Text(
                              subheading2,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        builder: (_, collapsed, expanded) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 10,
                            ),
                            child: Expandable(
                              collapsed: collapsed,
                              expanded: expanded,
                              theme:
                                  const ExpandableThemeData(crossFadePoint: 0),
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Builder(
                            builder: (context) {
                              var controller = ExpandableController.of(context,
                                  required: true)!;
                              return TextButton(
                                child: Text(
                                  controller.expanded
                                      ? "แสดงน้อยลง"
                                      : "ดูเพิ่มเติม",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                onPressed: () {
                                  controller.toggle();
                                },
                              );
                            },
                          ),
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
