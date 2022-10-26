import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class GH1_PlantInfo extends StatefulWidget {
  @override
  State<GH1_PlantInfo> createState() => _GH1_PlantInfoState();
}

class _GH1_PlantInfoState extends State<GH1_PlantInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExpandableTheme(
        data: const ExpandableThemeData(
          iconColor: Colors.blue,
          useInkWell: true,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            Card1(),
            Card2(),
          ],
        ),
      ),
    );
  }
}

const topic =
    "สายพันธุ์ : \nจำนวนกระถาง : \nวันที่เพาะกล้า : \nวันที่ย้ายปลูก : \nจำนวนต้นทั้งหมด : ";
const subheading = "หางกระรอก \n200 กระถาง \n14/02/2021 \n25/06/2021 \n300 ต้น";
const subheading2 = "หางเสือ \n 180 กระถาง \n08/01/2022 \n10/05/2022 \n280 ต้น";

class Card1 extends StatelessWidget {
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
          color: Colors.orange,
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
                            'รอบปลูกที่ 1',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.orange,
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
