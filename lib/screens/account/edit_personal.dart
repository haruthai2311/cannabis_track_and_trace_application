import 'dart:convert';

import 'package:cannabis_track_and_trace_application/widget/forminput.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../api/hostapi.dart';
import '../../../config/styles.dart';
import '../../api/user.dart';

class EditAccountScreen extends StatefulWidget {
  final String UserID;

  const EditAccountScreen({Key? key, required this.UserID}) : super(key: key);

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _visible = false;

  final _ctlFirstNameT = TextEditingController();
  final _ctlLastnameT = TextEditingController();
  final _ctlFirstNameE = TextEditingController();
  final _ctlLastnameE = TextEditingController();
  final _ctlEmail = TextEditingController();

  late List<UserData> _userdata;

  Future getUserdata() async {
    var url = hostAPI + '/users/getUserbyid?ID=${widget.UserID}';
    print(url);
    var response = await http.get(Uri.parse(url));
    _userdata = userDataFromJson(response.body);

    return _userdata;
  }

  @override
  void initState() {
    super.initState();
    getUserdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit information"),
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
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                kBackground,
                Colors.white60,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: FutureBuilder(
            future: getUserdata(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var result = snapshot.data;
                _ctlFirstNameT.text = result[0].fNameT.toString();
                _ctlLastnameT.text = result[0].lNameT.toString();
                _ctlFirstNameE.text = result[0].fNameE.toString();
                _ctlLastnameE.text = result[0].lNameE.toString();
                _ctlEmail.text = result[0].email.toString();
                return SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 20),
                          child: Container(
                            width: 60,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Color(0xFFDBE2E7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const Text(
                          "แก้ไขข้อมูลผู้ใช้",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 8, 143, 114)),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Divider(
                            height: 24,
                            thickness: 2,
                            color: Color(0xFFF1F4F8),
                          ),
                        ),
                        const SizedBox(height: 10),
                        MyForm().buildform("ชื่อ (ภาษาไทย):", _ctlFirstNameT),
                        const SizedBox(height: 20),
                        MyForm().buildform("นามสกุล (ภาษาไทย):", _ctlLastnameT),
                        const SizedBox(height: 20),
                        MyForm()
                            .buildform("ชื่อ (ภาษาอังกฤษ):", _ctlFirstNameE),
                        const SizedBox(height: 20),
                        MyForm()
                            .buildform("นามสกุล (ภาษาอังกฤษ):", _ctlLastnameE),
                        const SizedBox(height: 20),
                        MyForm().buildform("อีเมล:", _ctlEmail),
                      ],
                    ),
                  ),
                ));
              }
              return const LinearProgressIndicator();
            },
          ),
        ));
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
                Editdata();
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

  Future Editdata() async {
    var url = hostAPI + "/users/editProfile";
    // Showing LinearProgressIndicator.
    setState(() {
      _visible = true;
    });

    var response = await http.put(Uri.parse(url), body: {
      "userID": widget.UserID,
      "fnameT": _ctlFirstNameT.text,
      "lnameT": _ctlLastnameT.text,
      "fnameE": _ctlFirstNameE.text,
      "lnameE": _ctlLastnameE.text,
      "email": _ctlEmail.text,
      "UpdateBy": widget.UserID,
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
        //showMessage(msg["message"]);
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
}
