import 'dart:convert';

import 'package:cannabis_track_and_trace_application/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;

import '../../api/hostapi.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  bool _visible = false;

  final _ctlFnameT = TextEditingController();
  final _ctlLnameT = TextEditingController();
  final _ctlFnameE = TextEditingController();
  final _ctlLnameE = TextEditingController();
  final _ctlemail = TextEditingController();
  final _ctlUsername = TextEditingController();
  final _ctlPassword = TextEditingController();
  final _ctlConPass = TextEditingController();

  void Clear() {
    _ctlFnameT.clear();
    _ctlLnameT.clear();
    _ctlFnameE.clear();
    _ctlLnameE.clear();
    _ctlemail.clear();
    _ctlUsername.clear();
    _ctlPassword.clear();
    _ctlConPass.clear();
  }

  Future register() async {
    //var url = "http://172.20.10.7:3000/users/register";
    var url = hostAPI + "/users/register";
    // Showing LinearProgressIndicator.
    setState(() {
      _visible = true;
    });

    var response = await http.post(Uri.parse(url), body: {
      "fnameT": _ctlFnameT.text,
      "lnameT": _ctlLnameT.text,
      "fnameE": _ctlFnameE.text,
      "lnameE": _ctlLnameE.text,
      "email": _ctlemail.text,
      "username": _ctlUsername.text,
      "password": _ctlPassword.text,
      "confirmPassword": _ctlConPass.text
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
        showMessage(msg["message"]);
        Clear();
        // Navigator.of(context).push(MaterialPageRoute(
        //  builder: (context) =>LoginScreen(),
        //));
        //showMessage(context, 'บันทึกเรียบร้อยแล้ว');
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

  @override
  void initState() {
    super.initState();
    //register();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg_register.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF036568)),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _ctlFnameT,
                            obscureText: false,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: const InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                fillColor: Color(0xFFF2F2F2),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Color(0xFFC1BD02),
                                ),
                                hintText: "ชื่อ(ภาษาไทย)",
                                hintStyle: TextStyle(
                                    color: Color(0xFF828282), fontSize: 16),
                                contentPadding: EdgeInsets.zero),
                            validator: RequiredValidator(
                                errorText: 'กรุณาป้อนชื่อภาษาไทย'),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _ctlLnameT,
                            obscureText: false,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: const InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                fillColor: Color(0xFFF2F2F2),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Color(0xFFC1BD02),
                                ),
                                hintText: "นามสกุล(ภาษาไทย)",
                                hintStyle: TextStyle(
                                    color: Color(0xFF828282), fontSize: 16),
                                contentPadding: EdgeInsets.zero),
                            validator: RequiredValidator(
                                errorText: 'กรุณาป้อนนามสกุลภาษาไทย'),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _ctlFnameE,
                            obscureText: false,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: const InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                fillColor: Color(0xFFF2F2F2),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Color(0xFFC1BD02),
                                ),
                                hintText: "ชื่อ(ภาษาอังกฤษ)",
                                hintStyle: TextStyle(
                                    color: Color(0xFF828282), fontSize: 16),
                                contentPadding: EdgeInsets.zero),
                            validator: RequiredValidator(
                                errorText: 'กรุณาป้อนชื่อภาษาอังกฤษ'),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _ctlLnameE,
                            obscureText: false,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: const InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                fillColor: Color(0xFFF2F2F2),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Color(0xFFC1BD02),
                                ),
                                hintText: "นามสกุล(ภาษาอังกฤษ)",
                                hintStyle: TextStyle(
                                    color: Color(0xFF828282), fontSize: 16),
                                contentPadding: EdgeInsets.zero),
                            validator: RequiredValidator(
                                errorText: 'กรุณาป้อนนามสกุลภาษาอังกฤษ'),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _ctlemail,
                            obscureText: false,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: const InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                fillColor: Color(0xFFF2F2F2),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Color(0xFFC1BD02),
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    color: Color(0xFF828282), fontSize: 16),
                                contentPadding: EdgeInsets.zero),
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'กรุณาป้อนอีเมล'),
                              EmailValidator(errorText: 'รูปแบบอีเมลไม่ถูกต้อง')
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _ctlUsername,
                            obscureText: false,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: const InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                fillColor: Color(0xFFF2F2F2),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Color(0xFFC1BD02),
                                ),
                                hintText: "Username",
                                hintStyle: TextStyle(
                                    color: Color(0xFF828282), fontSize: 16),
                                contentPadding: EdgeInsets.zero),
                            validator: RequiredValidator(
                                errorText: 'กรุณาป้อน Username'),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _ctlPassword,
                            obscureText: _isHidden,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: InputDecoration(
                                errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                fillColor: const Color(0xFFF2F2F2),
                                filled: true,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_outlined,
                                  color: Color(0xFFC1BD02),
                                ),
                                suffixIcon: InkWell(
                                  onTap: _togglePasswordView,
                                  child: Icon(
                                    _isHidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: const Color(0xFF828282),
                                  ),
                                ),
                                hintText: "Password",
                                hintStyle: const TextStyle(
                                    color: Color(0xFF828282), fontSize: 16),
                                contentPadding: EdgeInsets.zero),
                            validator: RequiredValidator(
                                errorText: 'กรุณาป้อนรหัสผ่าน'),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _ctlConPass,
                            obscureText: _isHidden,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: InputDecoration(
                                errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                fillColor: const Color(0xFFF2F2F2),
                                filled: true,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF2F2F2)),
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_outlined,
                                  color: Color(0xFFC1BD02),
                                ),
                                suffixIcon: InkWell(
                                  onTap: _togglePasswordView,
                                  child: Icon(
                                    _isHidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: const Color(0xFF828282),
                                  ),
                                ),
                                hintText: "Confirm Password",
                                hintStyle: const TextStyle(
                                    color: Color(0xFF828282), fontSize: 16),
                                contentPadding: EdgeInsets.zero),
                            validator: RequiredValidator(
                                errorText: 'กรุณายืนยันรหัสผ่าน'),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                            height: 63, //height of button
                            width: 193, //width of button
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 20),
                                    //primary: Color(0xFF036568),
                                    primary: const Color(0xFF036568),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    padding: const EdgeInsets.all(20)),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    register();
                                  }
                                },
                                child: const Text("Register"))),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                "If you already have an account, just ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(221, 233, 5, 5)),
                              ),
                              SizedBox(width: 10),
                              Hero(
                                tag: '1',
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 139, 11, 2)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
