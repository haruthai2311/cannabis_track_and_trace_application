import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:cannabis_track_and_trace_application/screens/information/add/chemical_uses.dart';
import 'package:cannabis_track_and_trace_application/screens/information/add/inventorys.dart';
import 'package:cannabis_track_and_trace_application/screens/information/add/locations.dart';
import 'package:cannabis_track_and_trace_application/screens/information/add/pots.dart';
import 'package:cannabis_track_and_trace_application/screens/information/add/strains.dart';
import 'package:cannabis_track_and_trace_application/screens/information/details_gh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

class InfoScreen extends StatefulWidget {
  final String UserID;
  const InfoScreen({Key? key, required this.UserID}) : super(key: key);
  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context)
      //{
      =>
      WillPopScope(
        onWillPop: () async {
          if (isDialOpen.value) {
            isDialOpen.value = false;
            return false;
          } else {
            return true;
          }
        },
        child:
            //return
            Scaffold(
          appBar: AppBar(
            backgroundColor: kBackground,
            title: const Text("Infomations"),

            // title: Text(
            //   "Infomation",
            //   style: Theme.of(context)
            //       .textTheme
            //       .bodySmall!
            //       .copyWith(fontWeight: FontWeight.bold),
            // ),
            // leading: Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            // ),
          ),
          extendBody: true,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      // buildHead(),
                      // const SizedBox(height: 15),
                      // buildNews(),
                      // const SizedBox(height: 15),
                      // buildSearch(),
                      // const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DetailsGreenHouses();
                          })).then((value) => setState(() {}));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(95, 179, 173, 173),
                              borderRadius: BorderRadius.circular(15.0)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle_rounded,
                                    color: Colors.lightGreen,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "โรงเรือน G1(EVAP)",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              const Divider(
                                height: 20,
                                thickness: 5,
                                indent: 20,
                                endIndent: 0,
                                color: Colors.lightGreen,
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0)),
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Text("สายพันธุ์หางกระรอก",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 10),
                                    Image.asset(
                                      "images/กระถาง.jpg",
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.circle_rounded,
                                          color: Colors.lightGreen,
                                          size: 10,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "200 กระถาง",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(
                                          Icons.circle_rounded,
                                          color: Colors.lightGreen,
                                          size: 10,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "400 ต้น",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      buildGH2(),
                      const SizedBox(height: 50),
                      //_onGoingTask()
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: SpeedDial(
              //animatedIcon: AnimatedIcons.add_event,
              icon: Icons.add,
              backgroundColor: Colors.pinkAccent,
              overlayColor: Colors.black,
              overlayOpacity: 0.4,
              spacing: 15,
              spaceBetweenChildren: 5,
              //closeManually: true,
              onOpen: () => showToast('Open..'),
              //onClose: () => showToast('Close'),
              openCloseDial: isDialOpen,
              curve: Curves.bounceIn,
              children: [
                SpeedDialChild(
                    backgroundColor: Colors.yellow,
                    child: Icon(Icons.compost),
                    label: "สายพันธุ์ ",
                    labelStyle: TextStyle(fontSize: 18),
                    onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Strains(UserID: widget.UserID);
                        }))

                    //onTap: () => showToast('เลือกเพิ่มข้อมูลสายพันธุ์...'),
                    ),
                SpeedDialChild(
                    child: Icon(Icons.edit_location_alt),
                    backgroundColor: Colors.yellow,
                    label: "สถานที่ปลูก",
                    labelStyle: TextStyle(fontSize: 18),
                    onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Locations(UserID: widget.UserID);
                        }))
                    //onTap: () => showToast('เลือกเพิ่มข้อมูลสถานที่ปลูก...'),
                    ),
                SpeedDialChild(
                    child: Icon(Icons.format_color_fill_rounded),
                    backgroundColor: Colors.yellow,
                    label: "กระถาง",
                    labelStyle: TextStyle(fontSize: 18),
                    onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Pots(UserID: widget.UserID);
                        }))
                    //onTap: () => showToast('เลือกเพิ่มข้อมูลกระถาง...'),
                    ),
                SpeedDialChild(
                    child: Icon(Icons.fire_hydrant_alt_sharp),
                    backgroundColor: Colors.yellow,
                    label: "วัสดุ",
                    labelStyle: TextStyle(fontSize: 18),
                    onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Inventorys(UserID: widget.UserID);
                        }))
                    //onTap: () => showToast('เลือกเพิ่มข้อมูลวัสดุ...'),
                    ),
                SpeedDialChild(
                    child: Icon(FontAwesomeIcons.accusoft),
                    backgroundColor: Colors.yellow,
                    label: "การใช้สารเคมี",
                    onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ChemicalUses(UserID: widget.UserID);
                        }))
                    //onTap: () => showToast('เลือกเพิ่มข้อมูลการใช้สารเคมี...'),
                    ),
              ],
            ),
          ),
        ),
        //extendBodyBehindAppBar: true,
      );
}

Future showToast(String message) async {
  await Fluttertoast.cancel();

  Fluttertoast.showToast(
    msg: message,
    fontSize: 18,
  );
}

// Widget buildHead() {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Hello,",
//             style: TextStyle(color: Colors.black54, fontSize: 16),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Text(
//             "ชื่อคน Login",
//             style: TextStyle(
//                 color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
//           )
//         ],
//       ),
//       // CircleAvatar(
//       //   radius: 30.0,
//       //   backgroundImage: AssetImage("assets/images/doctor1.png"),
//       // )
//     ],
//   );
// }

// Widget buildNews() {
//   return Container(
//     padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
//     decoration: BoxDecoration(
//         color: Color.fromARGB(255, 223, 200, 228),
//         borderRadius: BorderRadius.circular(15.0)),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         // Image.asset(
//         //   "assets/images/surgeon.png",
//         //   width: 90,
//         //   height: 100,
//         // ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "ข้อมูลทั้วไป?",
//               style: TextStyle(
//                   color: Colors.black87,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             SizedBox(
//               width: 120,
//               child: Text(
//                 "ข้อมูลกัญชา",
//                 style: TextStyle(color: Colors.black87, fontSize: 13),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             InkWell(
//               child: Container(
//                 width: 150,
//                 height: 35,
//                 padding: EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                     color: Colors.blueAccent,
//                     borderRadius: BorderRadius.circular(12.0)),
//                 child: Center(
//                   child: Text(
//                     "Get Started",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 13),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ],
//     ),
//   );
// }

// Widget buildSearch() {
//   return Container(
//     padding: EdgeInsets.all(8),
//     height: 50,
//     decoration: BoxDecoration(
//       color: Color.fromARGB(95, 179, 173, 173),
//       borderRadius: BorderRadius.circular(15.0),
//     ),
//     child: TextFormField(
//       style: TextStyle(color: Colors.black),
//       decoration: InputDecoration(
//         border: InputBorder.none,
//         contentPadding: EdgeInsets.only(left: 15),
//         hintText: 'How can we help you?',
//         hintStyle: TextStyle(color: Colors.black54, fontSize: 18),
//         prefixIcon: Icon(
//           Icons.search,
//           size: 30,
//           color: Colors.black54,
//         ),
//       ),
//     ),
//   );
// }

Widget buildGH2() {
  return Container(
    decoration: BoxDecoration(
        color: Color.fromARGB(95, 179, 173, 173),
        borderRadius: BorderRadius.circular(15.0)),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.circle_rounded,
              color: Colors.orangeAccent,
            ),
            SizedBox(width: 5),
            Text(
              "โรงเรือน G2(GreenHouse)",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
          ],
        ),
        const Divider(
          height: 20,
          thickness: 5,
          indent: 20,
          endIndent: 0,
          color: Colors.orangeAccent,
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Text("สายพันธุ์หางเสือ",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Image.asset(
                "images/กระถาง.jpg",
                fit: BoxFit.contain,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.circle_rounded,
                    color: Colors.orangeAccent,
                    size: 10,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "200 กระถาง",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.circle_rounded,
                    color: Colors.orangeAccent,
                    size: 10,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "400 ต้น",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}
//}