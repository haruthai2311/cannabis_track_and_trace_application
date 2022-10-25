import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GH1_HarvestInfo extends StatefulWidget {
  @override
  State<GH1_HarvestInfo> createState() => _GH1_HarvestInfoState();
}

class _GH1_HarvestInfoState extends State<GH1_HarvestInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x33000000),
                  offset: Offset(2, 4),
                  spreadRadius: 1,
                )
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
              border: Border.all(
                color: const Color(0xFFCFD4DB),
                width: 1,
              ),
            ),
            width: double.infinity,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'เก็บเกี่ยวครั้งที่ 1',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'สายพันธุ์หางกระรอก 200 กระถาง',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'ดูเพิ่มเติม',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x33000000),
                  offset: Offset(2, 4),
                  spreadRadius: 1,
                )
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.pink,
              border: Border.all(
                color: const Color(0xFFCFD4DB),
                width: 1,
              ),
            ),
            width: double.infinity,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'เก็บเกี่ยวครั้งที่ 2',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'สายพันธุ์หางกระรอก 200 กระถาง',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'ดูเพิ่มเติม',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
