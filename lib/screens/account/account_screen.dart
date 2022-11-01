import 'package:cannabis_track_and_trace_application/screens/account/edit_pass.dart';
import 'package:cannabis_track_and_trace_application/screens/account/edit_personal.dart';
import 'package:cannabis_track_and_trace_application/screens/home/bottom_nav_screen.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  final String UserID;

  const AccountScreen({Key? key, required this.UserID}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 8, 141, 143),
          title: Text('Profile',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 255, 255, 255),
              )),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.account_circle_sharp,
                          size: 70,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              'Username',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            subtitle: Text(
                              '@email.com',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 158, 158, 158)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Manage your account",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  //connect page
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditAccountScreen(
                                          UserID: widget.UserID,
                                        ),
                                      ));
                                  //connect page
                                },
                                icon: Icon(Icons.person,
                                    size: 40,
                                    color: Color.fromARGB(255, 2, 73, 34)),
                                label: Container(
                                  width: 292, // change width as you need
                                  height: 40, // change height as you need
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Wrap(
                                        children: [
                                          Text(
                                            "Personal information",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color.fromARGB(255, 0, 0,
                                                    0)), // change max line you need
                                          ),
                                          Text(
                                            "Edit your personal information",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color.fromARGB(
                                                  255, 129, 129, 129),
                                            ), // change max line you need
                                          ),
                                        ],
                                      )),
                                ),
                                style: TextButton.styleFrom(
                                  padding:
                                      EdgeInsets.fromLTRB(10.0, 8.0, 20.0, 8.0),
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  //connect page
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditpassScreen(
                                          UserID: widget.UserID,
                                        ),
                                      ));
                                  //connect page
                                },
                                icon: Icon(Icons.key,
                                    size: 40,
                                    color: Color.fromARGB(255, 2, 73, 34)),
                                label: Container(
                                  width: 292, // change width as you need
                                  height: 40, // change height as you need
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Wrap(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Password",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color.fromARGB(
                                                        255,
                                                        0,
                                                        0,
                                                        0)), // change max line you need
                                              ),
                                              Text(
                                                "Edit your password",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromARGB(
                                                      255, 129, 129, 129),
                                                ), // change max line you need
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                                ),
                                style: TextButton.styleFrom(
                                  padding:
                                      EdgeInsets.fromLTRB(10.0, 8.0, 20.0, 8.0),
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  //logout
                                },
                                icon: Icon(Icons.logout,
                                    size: 40,
                                    color: Color.fromARGB(255, 2, 73, 34)),
                                label: Container(
                                  width: 292, // change width as you need
                                  height: 40, // change height as you need
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Logout",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromARGB(255, 0, 0,
                                              0)), // change max line you need
                                    ),
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  padding:
                                      EdgeInsets.fromLTRB(10.0, 8.0, 20.0, 8.0),
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                ),
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
        ),
      ),
    );
  }
}
