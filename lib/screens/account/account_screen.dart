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
          backgroundColor: Color.fromARGB(255, 50, 78, 63),
          title: Text('Profile',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
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
                          size: 60,
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
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Icon(Icons.person,
                                    color: Color.fromARGB(255, 2, 73, 34)),
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(15),
                                  primary: Color.fromARGB(255, 156, 255, 176),
                                  onPrimary: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    'Personal information',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  subtitle: Text(
                                    'Edit your personnal information',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 158, 158, 158)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Icon(Icons.logout,
                                    color: Color.fromARGB(255, 2, 73, 34)),
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(15),
                                  primary: Color.fromARGB(255, 156, 255, 176),
                                  onPrimary: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    'Log out',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  subtitle: Text(
                                    'Log out of the',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 158, 158, 158)),
                                  ),
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
