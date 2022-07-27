import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:flutter/material.dart';

class Track_deliver extends StatefulWidget {
  @override
  State<Track_deliver> createState() => _Track_deliverState();
}

class _Track_deliverState extends State<Track_deliver> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(backgroundColor: kBackground),
      body: SafeArea(
          child: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[buildHeader(screenHeight)],
      )),
    );
  }

  //ส่วนหัว
  SliverToBoxAdapter buildHeader(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: kBackground,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'เบอร์โทรฉุกเฉินรับมือ COVID-19',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
