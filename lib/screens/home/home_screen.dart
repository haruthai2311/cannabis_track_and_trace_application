import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:cannabis_track_and_trace_application/screens/home/account_screen.dart';
import 'package:cannabis_track_and_trace_application/screens/home/scan_screen.dart';
import 'package:cannabis_track_and_trace_application/widget/Circle_Gradient_Icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  final String UserID;

  const HomeScreen({Key? key, required this.UserID}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //   @override
  // void initState() {
  //   super.initState();
  //   print(widget.UserID);

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
        title: Text(
          "Home Screen",
          // style: Theme.of(context)
          //     .textTheme
          //     .bodySmall!
          //     .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      extendBody: true,
      body: _buildBody(),
    );
  }

  Stack _buildBody() {
    return Stack(children: [
      SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              buildSearch(),
              const SizedBox(height: 10),
              buildTaskHead(),
              const SizedBox(height: 10),
              buildAmount(),
              const SizedBox(height: 10),
              buildGraph(),
              const SizedBox(height: 10),
              buildResult(),
              const SizedBox(height: 70),
            ],
          ),
        ),
      )
    ]);
  }

  Widget buildSearch() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromARGB(95, 179, 173, 173),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: TextFormField(
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 15),
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.black54, fontSize: 18),
              prefixIcon: Icon(
                Icons.search,
                size: 30,
                color: Colors.black54,
              ),
              suffixIcon: Icon(
                Icons.settings,
                size: 30,
                color: Colors.black54,
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        Text(
          "รายงารอบการปลูกที่ 1/65",
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget buildTaskHead() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      height: 150,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x33000000),
            offset: Offset(0, 2),
            spreadRadius: 2,
          )
        ],
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 1, 100, 84),
            Color.fromARGB(255, 2, 158, 140)
          ],
          stops: [0, 1],
          begin: AlignmentDirectional(0, -1),
          end: AlignmentDirectional(0, 1),
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'จำนวนต้นทั้งหมด',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '400 ต้น',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(width: 50),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'โรงเรือน',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(width: 50),
                Text(
                  'G1 (EVAp)',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAmount() {
    return Padding(
      padding: EdgeInsets.all(10),
      //padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 160,
            height: 80,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x33000000),
                  offset: Offset(2, 4),
                  spreadRadius: 2,
                )
              ],
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(
                color: Color(0xFFCFD4DB),
                width: 1,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 166, 245, 168),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.green,
                      size: 20,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '371 ต้น',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'ต้นปกติ',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 14, 117, 17),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 160,
            height: 80,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x33000000),
                  offset: Offset(2, 4),
                  spreadRadius: 2,
                )
              ],
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(
                color: Color(0xFFCFD4DB),
                width: 1,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 209, 207, 207),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Color.fromARGB(255, 230, 28, 13),
                      size: 20,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '29 ต้น',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'ต้นตาย',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 230, 28, 13),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      //
    );
  }

  Widget buildGraph() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Color.fromARGB(255, 176, 4, 211),
            offset: Offset(0, 0),
            spreadRadius: 2,
          )
        ],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color.fromARGB(255, 134, 3, 160),
          width: 3,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'การเจริญเติบโตทั่วไป',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CircularPercentIndicator(
                    percent: 0.80,
                    radius: 100,
                    lineWidth: 25,
                    animation: true,
                    progressColor: colorGraph1,
                    backgroundColor: colorGraph2,
                    center: Text(
                      '80%',
                      style: TextStyle(
                          fontSize: 45,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.label,
                          color: colorGraph1,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'ต้นดี',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.label,
                          color: colorGraph2,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'ต้นไม่ดี',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResult() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x33000000),
                offset: Offset(2, 4),
                spreadRadius: 2,
              )
            ],
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
              color: Color(0xFFCFD4DB),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 90,
                      child: VerticalDivider(
                        color: colorResult1,
                        thickness: 5,
                        indent: 3,
                        endIndent: 3,
                        width: 5,
                      ),
                    ),
                    Icon(
                      Icons.search,
                      size: 50,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'การสำรวจโรค',
                          style: TextStyle(
                              fontSize: 20,
                              color: colorResult1,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'พบโรค',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'หมายเหตุ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text(
                    '14 ต้น',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x33000000),
                offset: Offset(2, 4),
                spreadRadius: 2,
              )
            ],
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
              color: Color(0xFFCFD4DB),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 90,
                      child: VerticalDivider(
                        color: colorResult2,
                        thickness: 5,
                        indent: 3,
                        endIndent: 3,
                        width: 5,
                      ),
                    ),
                    Icon(
                      Icons.search,
                      size: 50,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'การสำรวจแมลง',
                          style: TextStyle(
                              fontSize: 20,
                              color: colorResult2,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'พบแมลง',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'หมายเหตุ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text(
                    '50 ต้น',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
