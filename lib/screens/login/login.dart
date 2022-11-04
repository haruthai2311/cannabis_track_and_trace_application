import 'dart:convert';
import 'package:cannabis_track_and_trace_application/screens/home/bottom_nav_screen.dart';
import 'package:cannabis_track_and_trace_application/screens/register/register.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import '../../api/hostapi.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  //For LinearProgressIndicator.
  bool _visible = false;

  final _ctlUsername = TextEditingController();
  final _ctlPassword = TextEditingController();

  Future login() async {
    var url = hostAPI + "/users/login";
    // Showing LinearProgressIndicator.
    setState(() {
      _visible = true;
    });
    //print(_ctlUsername.text);
    //print(_ctlPassword.text);

    var response = await http.post(Uri.parse(url),
        body: {"username": _ctlUsername.text, "password": _ctlPassword.text});
    if (response.statusCode == 200) {
      //Server response into variable
      //print(response.body);
      var msg = jsonDecode(response.body);

      //Check Login Status
      if (msg['success'] == true) {
        setState(() {
          //hide progress indicator
          _visible = false;
        });
        var UserID = msg['user']["UserID"].toString();
        // Navigate to Home Screen
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BottomNavScreen(UserID: UserID),
        ));
      } else {
        setState(() {
          //hide progress indicator
          _visible = false;

          //Show Error Message Dialog
          showMessage(msg["message"]);
        });
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg_login.jpg"),
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
                          "Cannabis Track and \n Trace Application",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 30),
                          child: Image.asset(
                            "images/kulogo.png",
                            width: 200,
                            height: 200,
                            fit: BoxFit.contain,
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
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              height: 63, //height of button
                              width: 193, //width of button
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      textStyle: const TextStyle(fontSize: 20),
                                      primary: const Color(0xFF036568),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      padding: const EdgeInsets.all(20)),
                                  onPressed: () {
                                    login();
                                    // Navigator.pushAndRemoveUntil(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           const BottomNavScreen(
                                    //               UserID: "14")),
                                    //   (Route<dynamic> route) => false,
                                    // );
                                  },
                                  child: const Text("Login"))),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                "Don’t have an account? ",
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xDDAA3333)),
                              ),
                              SizedBox(width: 10),
                              Hero(
                                tag: '1',
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF036568)),
                                ),
                              )
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
