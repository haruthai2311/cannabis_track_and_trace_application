import 'package:cannabis_track_and_trace_application/screens/home/bottom_nav_screen.dart';
import 'package:cannabis_track_and_trace_application/screens/home/home_screen.dart';
import 'package:cannabis_track_and_trace_application/screens/login/widgets/inputfield_login.dart';
import 'package:cannabis_track_and_trace_application/screens/register/register.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg_login.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Cannabis Track and                 Trace Application",
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
                      FormInput(),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                          height: 63, //height of button
                          width: 193, //width of button
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  textStyle: TextStyle(fontSize: 20),
                                  primary: Color(0xFF036568),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  padding: const EdgeInsets.all(20)),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return BottomNavScreen();
                                }));
                              },
                              child: Text("Login"))),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
