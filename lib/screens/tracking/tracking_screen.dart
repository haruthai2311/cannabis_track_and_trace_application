import 'package:cannabis_track_and_trace_application/config/color.dart';
import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/cultivations.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/harvests.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/plant_tracking.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/transfers.dart';
import 'package:cannabis_track_and_trace_application/widget/Circle_Gradient_Icon.dart';
import 'package:flutter/material.dart';

class TrackingScreen extends StatefulWidget {
  final String UserID;

  const TrackingScreen({Key? key, required this.UserID}) : super(key: key);
  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  @override
  void initState() {
    super.initState();
    print(widget.UserID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
        title: Text(
          "Tracking",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 2, 109, 109),
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: () {},
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.menu_rounded,
              ),
            ),
          ),
        ),
      ),
      extendBody: true,
      body: _buildBody(),
    );
  }

  Stack _buildBody() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _taskHeader(),
                const SizedBox(height: 15),
                buildGrid(),
                const SizedBox(height: 15),
                _onGoingHeader(),
                const SizedBox(
                  height: 10,
                ),
                _onGoingTask()
              ],
            ),
          ),
        ),
        // Positioned(
        //   bottom: 30,
        //   // left: 100.w / 2 - (70 / 2),
        //   right: 30,
        //   child: CircleGradientIcon(
        //     color: Colors.pink,
        //     onTap: () {},
        //     size: 60,
        //     iconSize: 30,
        //     icon: Icons.add,
        //   ),
        // )
      ],
    );
  }

  Row _taskHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SelectableText(
          "Tracking",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
          toolbarOptions: const ToolbarOptions(
            copy: true,
            selectAll: true,
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.blue[400],
            ))
      ],
    );
  }

  Widget buildGrid() {
    return Row(children: [
      Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PlantTracking();
                }));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.zero,
              ),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Colors.pink,
                      Color.fromARGB(255, 243, 197, 211),
                    ]),
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: 175,
                  height: 220,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.menu_book_rounded,
                        size: 120,
                      ),
                      Text(
                        'บันทึกผลตรวจประจำวัน',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Harvests();
                }));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.zero,
              ),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Colors.blue,
                      Color.fromARGB(255, 142, 199, 247)
                    ]),
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: 175,
                  height: 170,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.article,
                        size: 60,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'บันทึกข้อมูลการเก็บเกี่ยว',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
      SizedBox(width: 10),
      Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Cultivations();
                }));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.zero,
              ),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Colors.orange,
                      Color.fromARGB(255, 248, 193, 110),
                    ]),
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: 175,
                  height: 170,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.mobile_friendly,
                        size: 60,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'บันทึกการปลูก',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 15,
            width: 10,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Transfers();
                }));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.zero,
              ),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Colors.green,
                      Color.fromARGB(255, 80, 235, 162),
                    ]),
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: 175,
                  height: 220,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.single_bed_sharp,
                        size: 120,
                      ),
                      Text(
                        'บันทึกข้อมูลการส่งมอบ',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: 220,
          //   width: 175,
          //   child: ElevatedButton.icon(
          //     onPressed: () {
          //       Navigator.push(context, MaterialPageRoute(builder: (context) {
          //         return Transfers();
          //       }));
          //     },
          //     icon: const Icon(
          //       Icons.single_bed_sharp,
          //       size: 100,
          //     ),
          //     label: const Text('บันทึกข้อมูลการส่งมอบ'),
          //     style: ElevatedButton.styleFrom(
          //         textStyle: TextStyle(fontSize: 20),
          //         primary: Color.fromARGB(255, 3, 196, 106),
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(20)),
          //         padding: const EdgeInsets.all(20)),
          //   ),
          // ),
          const SizedBox(height: 15),
        ],
      ),
    ]);
  }

  Row _onGoingHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "On Going",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {},
          child: Text(
            "See all",
            style: TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  Widget _onGoingTask() {
    return Container(
      padding: const EdgeInsets.all(
        20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      width: 100,
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ใส่อะไรดี",
                    style: TextStyle(
                      color: Colors.blueGrey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.timelapse,
                        color: Colors.purple[300],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "10:00 AM - 12:30PM",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.purple[50],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "Complete - 80%",
                      style: TextStyle(
                        color: Colors.purple,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Icon(
              Icons.rocket_rounded,
              size: 60,
              color: Colors.orange,
            )
          ],
        ),
      ),
    );
  }
}
