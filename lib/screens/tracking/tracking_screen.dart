import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/add/plant_tracking.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/show/list_cultivations.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/show/list_harvests.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/show/list_transfers.dart';
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
              _onGoingHeader(),
              const SizedBox(
                height: 10,
              ),
              _onGoingTask()
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
                  width: 175,
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
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
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                  width: 175,
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
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
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                  width: 175,
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
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
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                  width: 175,
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
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
                            fontSize: 20, fontWeight: FontWeight.bold),
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

  Row _onGoingHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
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
          child: const Text(
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
      //width: 100,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                //width: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   "ใส่อะไรดี",
                    //   style: TextStyle(
                    //     color: Colors.blueGrey[700],
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 18,
                    //   ),
                    //   overflow: TextOverflow.ellipsis,
                    //   maxLines: 2,
                    // ),
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
