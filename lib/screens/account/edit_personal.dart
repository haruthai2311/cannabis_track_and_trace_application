import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../api/allcultivations.dart';
import '../../../api/allgreenhouses.dart';
import '../../../api/allstrains.dart';
import '../../../api/hostapi.dart';
import '../../../config/styles.dart';

class EditAccountScreen extends StatefulWidget {
  final String UserID;

  const EditAccountScreen({Key? key, required this.UserID}) : super(key: key);

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  @override
  void initState() {
    super.initState();
  }

  String? dropdownStrain;

  String? dropdownGH;
  final f = DateFormat('dd/MM/yyyy  hh:mm:ss');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit your personal information"),
          backgroundColor: kBackground,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.save_as_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                confirmDialog();
              },
            )
          ],
        ),
        body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "แก้ไขข้อมูลส่วนบุคคล",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 8, 143, 114)),
                    ),
                    const SizedBox(height: 50),
                    const SizedBox(height: 20),
                    email(),
                    const SizedBox(height: 20),
                    firstName(),
                    const SizedBox(height: 20),
                    usernameth(),
                    const SizedBox(height: 20),
                    nameeng(),
                    const SizedBox(height: 20),
                    usernameeng(),
                  ],
                ),
              ),
            );
            // }
            return const LinearProgressIndicator();
          },
        ));
  }

  Widget email() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "อีเมล์:",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: '',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Widget firstName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ชื่อภาษาไทย:",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: '',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Widget usernameth() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "นามสกุลภาษาไทย:",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: '',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Widget nameeng() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Firstname:",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: '',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Widget usernameeng() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Username:",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: '',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Future<Null> confirmDialog() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ยืนยันการแก้ไข'),
          content: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                Text('กรุณากดยืนยันเพื่อดำเนินการแก้ไข'),
                //Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ยืนยัน'),
              onPressed: () {
                // EditData();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
