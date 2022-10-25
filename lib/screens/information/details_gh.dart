import 'package:cannabis_track_and_trace_application/screens/information/widgets/GH1_info.dart';
import 'package:cannabis_track_and_trace_application/screens/information/widgets/GH1all_info.dart';
import 'package:cannabis_track_and_trace_application/screens/information/widgets/GH1harvest_info.dart';
import 'package:cannabis_track_and_trace_application/screens/information/widgets/GH1plant_info.dart';
import 'package:flutter/material.dart';

import '../../config/styles.dart';

class DetailsGreenHouses extends StatefulWidget {
  @override
  State<DetailsGreenHouses> createState() => _DetailsGreenHousesState();
}

class _DetailsGreenHousesState extends State<DetailsGreenHouses> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBackground,
          title: Text("Greenhoueses"),
          bottom: TabBar(
            indicator: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: colorTabbar,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: colorTabbar,
            tabs: <Widget>[
              Tab(
                child: Text(
                  "All",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Tab(
                child: Text(
                  "Plant",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Tab(
                child: Text(
                  "Harvest",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GH1_info(),
                  GH1_AllInfo(),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GH1_PlantInfo(),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GH1_HarvestInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
