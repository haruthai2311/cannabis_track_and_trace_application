import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:cannabis_track_and_trace_application/screens/infomation/chemical_uses.dart';
import 'package:cannabis_track_and_trace_application/screens/infomation/inventorys.dart';
import 'package:cannabis_track_and_trace_application/screens/infomation/locations.dart';
import 'package:cannabis_track_and_trace_application/screens/infomation/pots.dart';
import 'package:cannabis_track_and_trace_application/screens/infomation/strains.dart';
import 'package:cannabis_track_and_trace_application/screens/test.dart';
import 'package:cannabis_track_and_trace_application/widget/Circle_Gradient_Icon.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  final String UserID;
  const InfoScreen({Key? key, required this.UserID}) : super(key: key);
  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
        title: Text(
          "Infomation",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
      extendBody: true,
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
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
                buildHead(),
                const SizedBox(height: 15),
                buildNews(),
                const SizedBox(height: 15),
                buildSearch(),
                const SizedBox(height: 15),
                buildGH1(),
                const SizedBox(height: 15),
                buildGH2(),
                const SizedBox(height: 15),
                //_onGoingTask()
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildHead() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello,",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "ชื่อคน Login",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )
          ],
        ),
        // CircleAvatar(
        //   radius: 30.0,
        //   backgroundImage: AssetImage("assets/images/doctor1.png"),
        // )
      ],
    );
  }

  Widget buildNews() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 223, 200, 228),
          borderRadius: BorderRadius.circular(15.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Image.asset(
          //   "assets/images/surgeon.png",
          //   width: 90,
          //   height: 100,
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ข้อมูลทั้วไป?",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 120,
                child: Text(
                  "ข้อมูลกัญชา",
                  style: TextStyle(color: Colors.black87, fontSize: 13),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                child: Container(
                  width: 150,
                  height: 35,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSearch() {
    return Container(
      padding: EdgeInsets.only(left: 15.0),
      height: 65,
      decoration: BoxDecoration(
          color: Color.fromARGB(95, 179, 173, 173),
          borderRadius: BorderRadius.circular(15.0)),
      // width: 10,
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 30,
            color: Colors.black54,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "How can we help you?",
            style: TextStyle(color: Colors.black54),
          )
        ],
      ),
    );
  }

  Widget buildGH1() {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(95, 179, 173, 173),
          borderRadius: BorderRadius.circular(15.0)),
      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "โรงเรือน G1(EVAP)",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
            child: Column(
              children: [
                Text("สายพันธุ์หางกระรอก", style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Image.asset(
                  "images/กระถาง.jpg",
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildGH2() {
    return Container();
  }

//   Widget buildTest() {
//     return Container(
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton2(
//           customButton: const Icon(
//             Icons.add,
//             size: 46,
//             color: Colors.red,
//           ),
//           customItemsIndexes: const [3],
//           customItemsHeight: 8,
//           items: [
//             ...MenuItems.firstItems.map(
//               (item) => DropdownMenuItem<MenuItem>(
//                 value: item,
//                 child: MenuItems.buildItem(item),
//               ),
//             ),
//             const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
//             ...MenuItems.secondItems.map(
//               (item) => DropdownMenuItem<MenuItem>(
//                 value: item,
//                 child: MenuItems.buildItem(item),
//               ),
//             ),
//             const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
//             ...MenuItems.thirdItems.map(
//               (item) => DropdownMenuItem<MenuItem>(
//                 value: item,
//                 child: MenuItems.buildItem(item),
//               ),
//             ),
//           ],
//           onChanged: (value) {
//             MenuItems.onChanged(context, value as MenuItem);
//           },
//           itemHeight: 48,
//           itemPadding: const EdgeInsets.only(left: 16, right: 16),
//           dropdownWidth: 250,
//           dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
//           dropdownDecoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Colors.redAccent,
//           ),
//           dropdownElevation: 8,
//           offset: const Offset(0, 8),
//         ),
//       ),
//     );
//   }
// }

// class MenuItem {
//   final String text;
//   final IconData icon;

//   const MenuItem({
//     required this.text,
//     required this.icon,
//   });
// }

// class MenuItems {
//   static const List<MenuItem> firstItems = [home, share, settings];
//   static const List<MenuItem> secondItems = [logout];
//   static const List<MenuItem> thirdItems = [chemi];

//   static const home = MenuItem(text: 'เพิ่มข้อมูลสายพันธุ์', icon: Icons.home);
//   static const share =
//       MenuItem(text: 'เพิ่มข้อมูลสถานที่ปลูก', icon: Icons.location_disabled);
//   static const settings =
//       MenuItem(text: 'เพิ่มข้อมูลกระถาง', icon: Icons.location_city);
//   static const logout = MenuItem(text: 'เพิ่มข้อมูลวัสดุ', icon: Icons.logout);
//   static const chemi =
//       MenuItem(text: 'เพิ่มข้อมูลการใช้สารเคมี', icon: Icons.logout);

//   static Widget buildItem(MenuItem item) {
//     return Row(
//       children: [
//         Icon(item.icon, color: Colors.white, size: 22),
//         const SizedBox(
//           width: 10,
//         ),
//         Text(
//           item.text,
//           style: const TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }

//   static onChanged(BuildContext context, MenuItem item) {
//     switch (item) {
//       case MenuItems.home:
//         //Do something
//         break;
//       case MenuItems.settings:
//         //Do something
//         break;
//       case MenuItems.share:
//         //Do something
//         break;
//       case MenuItems.logout:
//         //Do something
//         break;
//       case MenuItems.chemi:
//         //Do something
//         break;
//     }
//   }
}
