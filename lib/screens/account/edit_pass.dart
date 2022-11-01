import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../api/hostapi.dart';
import '../../../config/styles.dart';

class EditpassScreen extends StatefulWidget {
  final String UserID;

  const EditpassScreen({Key? key, required this.UserID}) : super(key: key);

  @override
  State<EditpassScreen> createState() => _EditpassScreenState();
}

class _EditpassScreenState extends State<EditpassScreen> {
  bool _isHiddenP = true;
  bool _isHiddenNP = true;
  bool _isHiddenCNP = true;
  bool _visible = false;

  final _ctlPassword = TextEditingController();
  final _ctlNewPasseord = TextEditingController();
  final _ctlConfirmnewPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit your password"),
        backgroundColor: kBackground,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.save_as_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Changepassword();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                "แก้ไขรหัสผ่าน",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 8, 143, 114)),
              ),
              const SizedBox(height: 50),
              const SizedBox(height: 20),
              password(),
              const SizedBox(height: 20),
              newpassword(),
              const SizedBox(height: 20),
              confirmpassword(),
            ],
          ),
        ),
      ),
      // }
    );
  }

  Widget password() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "รหัสผ่านปัจจุบัน :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          // height: 60,
          padding: const EdgeInsets.only(left: 15, right: 15),
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
            controller: _ctlPassword,
            obscureText: _isHiddenP,
            style: const TextStyle(color: Colors.black, fontSize: 18),
            decoration: InputDecoration(
              border: InputBorder.none,
              //contentPadding: EdgeInsets.only(left: 15),
              hintText: 'กรอกรหัสผ่านปัจจุบัน',
              hintStyle: TextStyle(color: Colors.black38, fontSize: 18),
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    _isHiddenP = !_isHiddenP;
                  });
                },
                child: Icon(
                  _isHiddenP ? Icons.visibility : Icons.visibility_off,
                  color: const Color(0xFF828282),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget newpassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "รหัสผ่านใหม่ :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
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
            controller: _ctlNewPasseord,
            obscureText: _isHiddenNP,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              //contentPadding: EdgeInsets.only(left: 15),
              hintText: 'กรอกรหัสผ่านใหม่',
              hintStyle: TextStyle(color: Colors.black38, fontSize: 18),
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    _isHiddenNP = !_isHiddenNP;
                  });
                },
                child: Icon(
                  _isHiddenNP ? Icons.visibility : Icons.visibility_off,
                  color: const Color(0xFF828282),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget confirmpassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ยืนยันรหัสผ่านใหม่ :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
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
            controller: _ctlConfirmnewPassword,
            obscureText: _isHiddenCNP,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              //contentPadding: EdgeInsets.only(left: 15),
              hintText: 'ยืนยันรหัสผ่านใหม่อีกครั้ง',
              hintStyle: TextStyle(color: Colors.black38, fontSize: 18),
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    _isHiddenCNP = !_isHiddenCNP;
                  });
                },
                child: Icon(
                  _isHiddenCNP ? Icons.visibility : Icons.visibility_off,
                  color: const Color(0xFF828282),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future Changepassword() async {
    var url = hostAPI + "/users/changepassword";
    // Showing LinearProgressIndicator.
    setState(() {
      _visible = true;
    });

    var response = await http.put(Uri.parse(url), body: {
      "id": widget.UserID,
      "password": _ctlPassword.text,
      "newpassword": _ctlNewPasseord.text,
      "confirmnewPassword": _ctlConfirmnewPassword.text,
    });
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
    if (response.statusCode == 200) {
      print(response.body);
      var msg = jsonDecode(response.body);

      //Check Login Status
      if (msg['success'] == true) {
        setState(() {
          //hide progress indicator
          _visible = false;
        });
        showMessagesuccess(msg["message"]);
      } else {
        setState(() {
          //hide progress indicator
          _visible = false;

          //Show Error Message Dialog
          showMessage(msg["message"]);
        });
        //showMessage(context, 'เกิดข้อผิดพลาด');
      }
    } else {
      setState(() {
        //hide progress indicator
        _visible = false;

        //Show Error Message Dialog
        showMessage("Error during connecting to Server.");
      });
    }
  }

  Future<dynamic> showMessage(String msg) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> showMessagesuccess(String msg) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

  // Future<Null> confirmDialog() async {
  //   showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('ยืนยันการเปลี่ยนรหัสผ่าน'),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             children: const <Widget>[
  //               Text('กรุณากดยืนยันเพื่อดำเนินการเปลี่ยนรหัสผ่าน'),
  //               //Text('Would you like to approve of this message?'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('ยืนยัน'),
  //             onPressed: () {
  //               Changepassword();
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: Text('ยกเลิก'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  