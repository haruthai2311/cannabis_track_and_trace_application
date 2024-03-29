import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:cannabis_track_and_trace_application/screens/information/add/chemical_uses.dart';
import 'package:cannabis_track_and_trace_application/screens/information/add/greenhouses.dart';
import 'package:cannabis_track_and_trace_application/screens/information/add/inventorys.dart';
import 'package:cannabis_track_and_trace_application/screens/information/add/locations.dart';
import 'package:cannabis_track_and_trace_application/screens/information/add/pots.dart';
import 'package:cannabis_track_and_trace_application/screens/information/add/strains.dart';
import 'package:cannabis_track_and_trace_application/screens/information/details_gh1.dart';
import 'package:cannabis_track_and_trace_application/screens/information/details_gh2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../../api/allgreenhouses.dart';
import '../../api/cultivationsbygh.dart';
import '../../api/hostapi.dart';

class InfoScreen extends StatefulWidget {
  final String UserID;
  const InfoScreen({Key? key, required this.UserID}) : super(key: key);
  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final isDialOpen = ValueNotifier(false);
  late List<CultivationsbyGh> _greenhouses;

  Future getGreenhouses() async {
    var url = hostAPI + '/trackings/InfoCul';
    print(url);
    var response = await http.get(Uri.parse(url));
    _greenhouses = cultivationsbyGhFromJson(response.body);

    return _greenhouses;
  }

  @override
  void initState() {
    super.initState();
    getGreenhouses();
    //print(widget.UserID);
  }

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
            title: const Text("Informations"),
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
          body: FutureBuilder(
              future: getGreenhouses(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == null) {
                    Container();
                  }

                  if (snapshot.data.length == 0) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // buildHead(),
                          // const SizedBox(height: 15),
                          // buildNews(),
                          // const SizedBox(height: 15),
                          // buildSearch(),
                          // const SizedBox(height: 15),

                          Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(95, 179, 173, 173),
                                borderRadius: BorderRadius.circular(15.0)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14.0, vertical: 14.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.circle_rounded,
                                        color: Colors.green),
                                    const SizedBox(width: 5),
                                    Text(
                                      "โรงปลูก",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 20,
                                  thickness: 5,
                                  indent: 20,
                                  endIndent: 0,
                                  color: Colors.green,
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Text("สายพันธุ์",
                                          style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 10),
                                      Image.asset(
                                        "images/กระถาง.jpg",
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.circle_rounded,
                                            color: Colors.green,
                                            size: 10,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "0 กระถาง",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(width: 10),
                                          Icon(
                                            Icons.circle_rounded,
                                            color: Colors.green,
                                            size: 10,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "0 ต้น",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  var result = snapshot.data;
                  print(result);
                  return ListView.builder(
                      itemCount: result.length,

                      //reverse: true,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final GH = result[index];
                        const Color oddcolorgh = Colors.orange;
                        const Color evencolorgh = Colors.green;
                        var amountpots = GH.amountpots.toString();
                        var pot;
                        amountpots == 'null'
                            ? pot = '0 กระถาง'
                            : pot = amountpots + ' กระถาง';
                        return Stack(
                          children: [
                            SingleChildScrollView(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // buildHead(),
                                    // const SizedBox(height: 15),
                                    // buildNews(),
                                    // const SizedBox(height: 15),
                                    // buildSearch(),
                                    // const SizedBox(height: 15),
                                    GestureDetector(
                                      onTap: () {
                                        //print(GH.greenHouseId.toString());
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return DetailsGreenHouses(
                                              GreenhouseID:
                                                  GH.greenHouseId.toString());
                                        })).then((value) => setState(() {}));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                95, 179, 173, 173),
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14.0, vertical: 14.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.circle_rounded,
                                                  color: index.isOdd
                                                      ? oddcolorgh
                                                      : evencolorgh,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  GH.nameGh.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              height: 20,
                                              thickness: 5,
                                              indent: 20,
                                              endIndent: 0,
                                              color: index.isOdd
                                                  ? oddcolorgh
                                                  : evencolorgh,
                                            ),
                                            const SizedBox(height: 10),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0)),
                                              padding: const EdgeInsets.all(15),
                                              child: Column(
                                                children: [
                                                  Text(
                                                      GH.nameStrains.toString(),
                                                      style: const TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  const SizedBox(height: 10),
                                                  Image.asset(
                                                    "images/กระถาง.jpg",
                                                    fit: BoxFit.contain,
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.circle_rounded,
                                                        color: index.isOdd
                                                            ? oddcolorgh
                                                            : evencolorgh,
                                                        size: 10,
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                        pot,
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Icon(
                                                        Icons.circle_rounded,
                                                        color: index.isOdd
                                                            ? oddcolorgh
                                                            : evencolorgh,
                                                        size: 10,
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                        GH.plantTotal
                                                                .toString() +
                                                            " ต้น",
                                                        style: const TextStyle(
                                                            fontSize: 16),
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
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                }
                return const LinearProgressIndicator();
              }),
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
                    child: const Icon(FontAwesomeIcons.house),
                    backgroundColor: Colors.yellow,
                    label: "โรงเรือน ",
                    labelStyle: const TextStyle(fontSize: 18),
                    onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return GreenHouses(UserID: widget.UserID);
                        }))),
                SpeedDialChild(
                    backgroundColor: Colors.yellow,
                    child: const Icon(Icons.compost),
                    label: "สายพันธุ์ ",
                    labelStyle: const TextStyle(fontSize: 18),
                    onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Strains(UserID: widget.UserID);
                        }))

                    //onTap: () => showToast('เลือกเพิ่มข้อมูลสายพันธุ์...'),
                    ),
                SpeedDialChild(
                    child: const Icon(Icons.edit_location_alt),
                    backgroundColor: Colors.yellow,
                    label: "สถานที่ปลูก",
                    labelStyle: const TextStyle(fontSize: 18),
                    onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Locations(UserID: widget.UserID);
                        }))
                    //onTap: () => showToast('เลือกเพิ่มข้อมูลสถานที่ปลูก...'),
                    ),
                SpeedDialChild(
                    child: const Icon(Icons.local_drink),
                    backgroundColor: Colors.yellow,
                    label: "กระถาง",
                    labelStyle: const TextStyle(fontSize: 18),
                    onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Pots(UserID: widget.UserID);
                        }))
                    //onTap: () => showToast('เลือกเพิ่มข้อมูลกระถาง...'),
                    ),
                SpeedDialChild(
                    child: const Icon(Icons.home_repair_service),
                    backgroundColor: Colors.yellow,
                    label: "วัสดุ",
                    labelStyle: const TextStyle(fontSize: 18),
                    onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Inventorys(UserID: widget.UserID);
                        }))
                    //onTap: () => showToast('เลือกเพิ่มข้อมูลวัสดุ...'),
                    ),
                SpeedDialChild(
                    child: Icon(FontAwesomeIcons.exclamation),
                    backgroundColor: Colors.yellow,
                    label: "การใช้สารเคมี",
                    labelStyle: TextStyle(fontSize: 18),
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


