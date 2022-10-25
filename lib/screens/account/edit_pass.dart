// ignore_for_file: deprecated_member_use
import 'package:flat_3d_button/flat_3d_button.dart';
import 'package:cannabis_track_and_trace_application/screens/home/bottom_nav_screen.dart';
import 'package:flutter/material.dart';

class Editpassscreen extends StatefulWidget {
  final String UserID;

  const Editpassscreen({Key? key, required this.UserID}) : super(key: key);

  @override
  State<Editpassscreen> createState() => _EditpassscreenState();
}

class _EditpassscreenState extends State<Editpassscreen> {
  late double screenWidth, screenHight;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHight = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 50, 78, 63),
            title: Text('Edit your password',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 255, 255, 255),
                )),
            actions: [
              IconButton(
                  icon: const Icon(Icons.upload),
                  color: Color.fromARGB(255, 255, 255, 255),
                  onPressed: () {}),
            ]),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              editpasspresent(),
              editnameTH(),
              editsurnameTH(),
              nosucced(),
            ],
          ),
        ),
      ),
    );
  }

  Container editpasspresent() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: screenWidth * 0.8,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'รหัสผ่านปัจจุบัน',
          labelStyle: TextStyle(color: Color.fromARGB(255, 139, 139, 139)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Color.fromARGB(255, 2, 98, 2))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 2, 98, 2))),
        ),
      ),
    );
  }

  Container editnameTH() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: screenWidth * 0.8,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'กรอกรหัสผ่านใหม่',
          labelStyle: TextStyle(color: Color.fromARGB(255, 139, 139, 139)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Color.fromARGB(255, 2, 98, 2))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 2, 98, 2))),
        ),
      ),
    );
  }

  Container editsurnameTH() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: screenWidth * 0.8,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'กรอกรหัสผ่านใหม่อีกครั้ง',
          labelStyle: TextStyle(color: Color.fromARGB(255, 139, 139, 139)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Color.fromARGB(255, 2, 98, 2))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 2, 98, 2))),
        ),
      ),
    );
  }

  Container nosucced() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: screenWidth * 0.8,
      child: Flat3dButton(
        child: Text(
          'กลับ',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        color: Colors.green,
        onPressed: () {},
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(30),
        // ),
      ),
    );
  }
}
