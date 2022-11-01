import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../api/allcultivations.dart';
import '../../../api/cultivationsbygh.dart';
import '../../../api/hostapi.dart';

class GH1_PlantInfo extends StatefulWidget {
  final String GreenhouseID;
  const GH1_PlantInfo({Key? key, required this.GreenhouseID}) : super(key: key);
  @override
  State<GH1_PlantInfo> createState() => _GH1_PlantInfoState();
}

class _GH1_PlantInfoState extends State<GH1_PlantInfo> {
  late List<CultivationsbyGh> _listCultivation;

  Future<List<CultivationsbyGh>> getCultivations() async {
    var url = hostAPI + '/trackings/Cultivations?gh=${widget.GreenhouseID}';
    print(url);
    var response = await http.get(Uri.parse(url));
    _listCultivation = cultivationsbyGhFromJson(response.body);

    return _listCultivation;
  }

  @override
  void initState() {
    super.initState();
    getCultivations();
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
                      'ไม่พบข้อมูลการปลูก',
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
                      final Cul = result[index];
                      print(result.length);
                      const Color oddcolorgh = Colors.orange;
                      const Color evencolorgh = Colors.green;
                      var amountpots = Cul.amountpots.toString();
                      var pot;
                      amountpots == 'null'
                          ? pot = '0 กระถาง'
                          : pot = amountpots + ' กระถาง';
                      print(pot);
                      return SingleChildScrollView(
                        child: ExpandableTheme(
                          data: const ExpandableThemeData(
                            iconColor: Colors.blue,
                            useInkWell: true,
                          ),
                          child: Column(
                            // physics: const BouncingScrollPhysics(),
                            children: <Widget>[
                              Card1(
                                subheading: Cul.nameStrains.toString() +
                                    '\n' +
                                    pot +
                                    ' \n' +
                                    f.format(Cul.seedDate).toString() +
                                    '\n' +
                                    f.format(Cul.moveDate).toString() +
                                    ' \n' +
                                    Cul.plantTotal.toString() +
                                    ' ต้น',
                                colorcard:
                                    index.isOdd ? oddcolorgh : evencolorgh,
                                titleno: Cul.no.toString(),
                              ),
                              // Card2(),
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

const topic =
    "สายพันธุ์ : \nจำนวนกระถาง : \nวันที่เพาะกล้า : \nวันที่ย้ายปลูก : \nจำนวนต้นทั้งหมด : ";
// const subheading = "หางกระรอก \n200 กระถาง \n14/02/2021 \n25/06/2021 \n300 ต้น";
const subheading2 = "หางเสือ \n 180 กระถาง \nกระถาง \nกระถาง \n280 ต้น";

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
                            'รอบปลูกที่ ' + titleno,
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
          color: Colors.green,
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
                            'รอบปลูกที่ 2',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.green,
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
