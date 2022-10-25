import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class GH1_AllInfo extends StatefulWidget {
  @override
  State<GH1_AllInfo> createState() => _GH1_AllInfoState();
}

class _GH1_AllInfoState extends State<GH1_AllInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                'ปี 2565',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                //color: colorTabbar,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: colorTabbar,
                  width: 3,
                ),
              ),
              height: 150,
              // width: double.maxFinite,
              // margin: EdgeInsets.symmetric(horizontal: 10),
              // decoration: BoxDecoration(
              //   color: Color.fromARGB(255, 186, 180, 196),
              //   borderRadius: BorderRadius.all(Radius.circular(20)),
              // ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
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
            ),
          ),
        ],
      ),
    );
  }
}
