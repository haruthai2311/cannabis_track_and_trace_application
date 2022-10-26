import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:cannabis_track_and_trace_application/screens/information/widgets/GH2all_info.dart';
import 'package:cannabis_track_and_trace_application/screens/information/widgets/GH2harvest_info.dart';
import 'package:cannabis_track_and_trace_application/screens/information/widgets/GH2plant_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetailsGreenHouses2 extends StatefulWidget {
  const DetailsGreenHouses2({Key? key}) : super(key: key);

  @override
  State<DetailsGreenHouses2> createState() => _DetailsGreenHouses2State();
}

List<String> items = [
  "All",
  "Plant",
  "Harvest",
];

int current = 0;

class _DetailsGreenHouses2State extends State<DetailsGreenHouses2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
        title: const Text("Greenhoueses"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// CUSTOM TABBAR
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                height: 170,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/gh1.jpg"),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x33000000),
                      offset: Offset(0, 2),
                      spreadRadius: 2,
                    )
                  ],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'โรงเรือน G2 (Green House)',
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'สถานที่',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'หมายเหตุ',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                height: 70,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              current = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.all(5),
                            width: 110,
                            height: 50,
                            decoration: BoxDecoration(
                                color: current == index
                                    ? Colors.green
                                    : Colors.white,
                                borderRadius: current == index
                                    ? BorderRadius.circular(30)
                                    : BorderRadius.circular(30),
                                border: current == index
                                    ? null
                                    : Border.all(
                                        color: Colors.green, width: 3.5)),
                            child: Center(
                              child: Text(
                                items[index],
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: current == index
                                        ? Colors.white
                                        : colorTabbar),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: current == index,
                          child: Container(
                            width: 20,
                            height: 3,
                            decoration: const BoxDecoration(
                                color: Colors.lightGreen,
                                shape: BoxShape.rectangle),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            /// MAIN BODY
            SingleChildScrollView(
              child: Container(
                //margin: const EdgeInsets.only(top: 30),
                width: double.infinity,
                height: 500,
                child: Scaffold(
                  body: [
                    GH2_AllInfo(),
                    GH2_PlantInfo(),
                    GH2_HarvestInfo(),
                  ][current],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
