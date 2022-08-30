import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
      extendBody: true,
      body: _buildBody(),
    );
  }

  Stack _buildBody() {
    return Stack(children: [
      SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              buildTest(),
              const SizedBox(height: 15),
            ],
          ),
        ),
      )
    ]);
  }

  Widget buildTest() {
    return Container(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          customButton: const Icon(
            Icons.add,
            size: 46,
            color: Colors.red,
          ),
          customItemsIndexes: const [3],
          customItemsHeight: 8,
          items: [
            ...MenuItems.firstItems.map(
              (item) => DropdownMenuItem<MenuItem>(
                value: item,
                child: MenuItems.buildItem(item),
              ),
            ),
            const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
            ...MenuItems.secondItems.map(
              (item) => DropdownMenuItem<MenuItem>(
                value: item,
                child: MenuItems.buildItem(item),
              ),
            ),
            const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
            ...MenuItems.thirdItems.map(
              (item) => DropdownMenuItem<MenuItem>(
                value: item,
                child: MenuItems.buildItem(item),
              ),
            ),
            // const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
            // ...MenuItems.fourItems.map(
            //   (item) => DropdownMenuItem<MenuItem>(
            //     value: item,
            //     child: MenuItems.buildItem(item),
            //   ),
            // ),
            // const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
            // ...MenuItems.fiveItems.map(
            //   (item) => DropdownMenuItem<MenuItem>(
            //     value: item,
            //     child: MenuItems.buildItem(item),
            //   ),
            // ),
          ],
          onChanged: (value) {
            MenuItems.onChanged(context, value as MenuItem);
          },
          itemHeight: 48,
          itemPadding: const EdgeInsets.only(left: 16, right: 16),
          dropdownWidth: 250,
          dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.redAccent,
          ),
          dropdownElevation: 8,
          offset: const Offset(0, 8),
        ),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [strain,  settings];
  static const List<MenuItem> secondItems = [logout];
  static const List<MenuItem> thirdItems = [chemi];
  static const List<MenuItem> fourItems = [chemi];
  static const List<MenuItem> fiveItems = [chemi];

  static const strain = MenuItem(text: 'เพิ่มข้อมูลสายพันธุ์', icon: Icons.home);
  static const loca =
      MenuItem(text: 'เพิ่มข้อมูลสถานที่ปลูก', icon: Icons.location_disabled);
  static const settings =
      MenuItem(text: 'เพิ่มข้อมูลกระถาง', icon: Icons.location_city);
  static const logout = MenuItem(text: 'เพิ่มข้อมูลวัสดุ', icon: Icons.logout);
  static const chemi =
      MenuItem(text: 'เพิ่มข้อมูลการใช้สารเคมี', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.strain:
        //Do something
        break;
      case MenuItems.settings:
        //Do something
        break;
      case MenuItems.loca:
        //Do something
        break;
      case MenuItems.logout:
        //Do something
        break;
      case MenuItems.chemi:
        //Do something
        break;
    }
  }
}
