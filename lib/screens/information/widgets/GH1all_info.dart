import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class GH1_AllInfo extends StatefulWidget {
  final String countCul;
  final String countCulold;
  final String countHar;
  final String countHarold;
  final String countTran;
  final String countTranold;
  const GH1_AllInfo(
      {Key? key,
      required this.countCul,
      required this.countHar,
      required this.countTran,
      required this.countCulold,
      required this.countHarold,
      required this.countTranold})
      : super(key: key);
  @override
  State<GH1_AllInfo> createState() => _GH1_AllInfoState();
}

class _GH1_AllInfoState extends State<GH1_AllInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Card1(
            countCul: widget.countCul,
            countHar: widget.countHar,
            countTran: widget.countTran,
          ),
          SizedBox(height: 15),
          Card2(countCulold: widget.countCulold, countHarold: widget.countHarold, countTranold: widget.countTranold,),
        ],
      ),
    );
  }
}

class Card1 extends StatelessWidget {
  Card1(
      {required this.countCul,
      required this.countHar,
      required this.countTran});

  final String countCul;
  final String countHar;
  final String countTran;
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
                    'ปี '+ (DateTime.now().year+543).toString(),
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
                  Padding(
                     padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'ปลูกทั้งหมด ',
                            style: TextStyle(
                              fontSize: 20,
                              color: colorAll,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            countCul == 'null' ? '0 รอบ' : countCul + ' รอบ',
                            style: TextStyle(
                              color: colorAll,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                     padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'เก็บเกี่ยวทั้งหมด ',
                            style: TextStyle(
                              fontSize: 20,
                              color: colorAll,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            countHar == 'null' ? '0 รอบ' : countHar + ' รอบ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: colorAll,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                     padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'ส่งมอบทั้งหมด ',
                            style: TextStyle(
                              fontSize: 20,
                              color: colorAll,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            countTran == 'null' ? '0 รอบ' : countTran + ' รอบ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: colorAll,
                            ),
                          ),
                        ),
                      ],
                    ),
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

class Card2 extends StatelessWidget {Card2(
      {required this.countCulold,
      required this.countHarold,
      required this.countTranold});

  final String countCulold;
  final String countHarold;
  final String countTranold;
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
                    'ปี '+(DateTime.now().year+542).toString(),
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
                  Padding(
                     padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'ปลูกทั้งหมด ',
                            style: TextStyle(
                              fontSize: 20,
                              color: colorAll,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            countCulold == 'null'? '0 รอบ':countCulold+' รอบ',
                            style: TextStyle(
                              color: colorAll,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'เก็บเกี่ยวทั้งหมด ',
                            style: TextStyle(
                              fontSize: 20,
                              color: colorAll,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            countHarold == 'null'? '0 รอบ':countHarold+' รอบ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: colorAll,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'ส่งมอบทั้งหมด ',
                            style: TextStyle(
                              fontSize: 20,
                              color: colorAll,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            countTranold == 'null'? '0 รอบ':countTranold+' รอบ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: colorAll,
                            ),
                          ),
                        ),
                      ],
                    ),
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
