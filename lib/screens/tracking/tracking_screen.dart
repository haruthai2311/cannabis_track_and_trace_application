import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/add/plant_tracking.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/show/list_cultivations.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/show/list_harvests.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/show/list_transfers.dart';
import 'package:cannabis_track_and_trace_application/test.dart';
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
        title: const Text("Tracking"),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.push(context, MaterialPageRoute(builder: (context) {
        //           return Test();
        //         }));
        //       },
        //       icon: Icon(Icons.add))
        // ],
      ),
      extendBody: true,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildGrid(),
              const SizedBox(height: 15),
              // _onGoingHeader(),
              // const SizedBox(height: 10),
              // _onGoingTask(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGrid() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PlantTracking(UserID: widget.UserID);
                }));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.zero,
              ),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.pink,
                        Color.fromARGB(255, 243, 197, 211),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  //width: 175,
                  padding: const EdgeInsets.fromLTRB(30, 40, 20, 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.menu_book_rounded,
                        size: 120,
                      ),
                      Text(
                        'Plant Tracking',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ListCultivations(UserID: widget.UserID);
                }));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.zero,
              ),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.orange,
                        Color.fromARGB(255, 248, 193, 110),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  //width: 175,
                  padding: const EdgeInsets.fromLTRB(20, 40, 30, 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.mobile_friendly,
                        size: 120,
                      ),
                      Text(
                        'Cultivation',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ListHarveste(UserID: widget.UserID);
                }));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.zero,
              ),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Color.fromARGB(255, 142, 199, 247)],
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  //width: 175,
                  padding: const EdgeInsets.fromLTRB(30, 40, 20, 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.article,
                        size: 120,
                      ),
                      Text(
                        'Harvests',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ListTransfers(UserID: widget.UserID);
                }));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.zero,
              ),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.green,
                        Color.fromARGB(255, 80, 235, 162),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  //width: 175,
                  padding: const EdgeInsets.fromLTRB(20, 40, 30, 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.single_bed_sharp,
                        size: 120,
                      ),
                      Text(
                        'Transfer',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
