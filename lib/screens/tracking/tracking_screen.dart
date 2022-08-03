import 'package:cannabis_track_and_trace_application/screens/tracking/cultivations.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/harvests.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/plant_tracking.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/transfers.dart';
import 'package:flutter/material.dart';

class TrackingScreen extends StatefulWidget {
  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              child: Row(
                children: [
                  SizedBox(
                    height: 130,
                    width: 175,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PlantTracking();
                        }));
                      },
                      child: Text('บันทึกผลตรวจประจำวัน'),
                      style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                            fontSize: 20,
                          ),
                          primary: Color.fromARGB(255, 240, 199, 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(20)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                    width: 10,
                  ),
                  SizedBox(
                    height: 130,
                    width: 175,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Cultivations();
                        }));
                      },
                      child: Text('บันทึกการปลูก'),
                      style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                            fontSize: 20,
                          ),
                          primary: Color.fromARGB(255, 27, 150, 133),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(20)),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              child: Row(
                children: [
                  SizedBox(
                    height: 130,
                    width: 175,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Harvests();
                        }));
                      },
                      child: Text('บันทึกข้อมูลการเก็บเกี่ยว'),
                      style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                            fontSize: 20,
                          ),
                          primary: Color.fromARGB(255, 238, 96, 139),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(20)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                    width: 10,
                  ),
                  SizedBox(
                    height: 130,
                    width: 175,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Transfers();
                        }));
                      },
                      child: Text('บันทึกข้อมูลการส่งมอบ'),
                      style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                            fontSize: 20,
                          ),
                          primary: Color.fromARGB(255, 143, 93, 243),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(20)),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            )
          ],
        ),
      ),
    )));
  }
}
