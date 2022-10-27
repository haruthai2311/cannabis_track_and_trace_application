import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GH2_AllInfo extends StatefulWidget {
  const GH2_AllInfo({Key? key}) : super(key: key);

  @override
  State<GH2_AllInfo> createState() => _GH2_AllInfoState();
}

class _GH2_AllInfoState extends State<GH2_AllInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Card1(),
          SizedBox(height: 15),
          Card2(),
        ],
      ),
    );
  }
}

class Card1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 1,
              color: colordetailAll,
              offset: Offset(0, 1),
              spreadRadius: 1,
            )
          ],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: colordetailAll,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 50,
              decoration: BoxDecoration(
                color: colordetailAll,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ปี 2565',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'ปลูกทั้งหมด ',
                        style: TextStyle(
                          fontSize: 20,
                          color: colorAll,
                        ),
                      ),
                      Text(
                        '2 รอบ',
                        style: TextStyle(
                          color: colorAll,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'เก็บเกี่ยว ',
                        style: TextStyle(
                          fontSize: 20,
                          color: colorAll,
                        ),
                      ),
                      Text(
                        '2 รอบ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colorAll,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'ส่งมอบ ',
                        style: TextStyle(
                          fontSize: 20,
                          color: colorAll,
                        ),
                      ),
                      Text(
                        '2 รอบ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colorAll,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Card2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 1,
              color: colordetailAll,
              offset: Offset(0, 1),
              spreadRadius: 1,
            )
          ],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: colordetailAll,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 50,
              decoration: BoxDecoration(
                color: colordetailAll,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ปี 2564',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'ปลูกทั้งหมด ',
                        style: TextStyle(
                          fontSize: 20,
                          color: colorAll,
                        ),
                      ),
                      Text(
                        '3 รอบ',
                        style: TextStyle(
                          color: colorAll,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'เก็บเกี่ยว ',
                        style: TextStyle(
                          fontSize: 20,
                          color: colorAll,
                        ),
                      ),
                      Text(
                        '3 รอบ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colorAll,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'ส่งมอบ ',
                        style: TextStyle(
                          fontSize: 20,
                          color: colorAll,
                        ),
                      ),
                      Text(
                        '3 รอบ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colorAll,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
