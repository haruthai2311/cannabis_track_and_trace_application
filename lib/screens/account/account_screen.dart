import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:cannabis_track_and_trace_application/screens/account/edit_pass.dart';
import 'package:cannabis_track_and_trace_application/screens/account/edit_personal.dart';
import 'package:cannabis_track_and_trace_application/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import '../../api/hostapi.dart';
import '../../api/user.dart';

class AccountScreen extends StatefulWidget {
  final String UserID;

  const AccountScreen({Key? key, required this.UserID}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
        backgroundColor: kBackground,
        title: const Text('Profile',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 255, 255, 255),
            )),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: getUserdata(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var result = snapshot.data;
              return Column(
                children: [
                  Row(
                    children: [
                      ProfilePicture(
                        name: result[0].fNameE.toString() +
                            ' ' +
                            result[0].lNameE.toString(),
                        radius: 31,
                        fontsize: 21,
                        random: true,
                        tooltip: true,
                        //img: 'https://avatars.githubusercontent.com/u/37553901?v=4',
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            result[0].fNameE.toString() +
                                ' ' +
                                result[0].lNameE.toString(),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          subtitle: Text(
                            result[0].email.toString(),
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 158, 158, 158)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: const [
                      Text(
                        "Manage your account",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditAccountScreen(
                                  UserID: widget.UserID,
                                ),
                              ));
                        },
                        child: Row(
                          children: [
                            ElevatedButton(
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
                              child: const Icon(Icons.manage_accounts_outlined,
                                  size: 30, color: Color(0xFF036568)),
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(15),
                                primary: const Color(0xFFD1F1F2),
                                onPrimary: Colors.black,
                              ),
                            ),
                            const Expanded(
                              child: ListTile(
                                title: Text(
                                  'Personal Information',
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
                      ),
                      GestureDetector(
                        onTap: () {
                           Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Editpassscreen(
                                        UserID: widget.UserID,
                                      ),
                                    ));
                        },
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                //connect page
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Editpassscreen(
                                        UserID: widget.UserID,
                                      ),
                                    ));
                                //connect page
                              },
                              child: Transform.rotate(
                                angle: 180 * math.pi / 100,
                                child: const Icon(Icons.key_rounded,
                                    size: 30, color: Color(0xFF036568)),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(15),
                                primary: const Color(0xFFD1F1F2),
                                onPrimary: Colors.black,
                              ),
                            ),
                            const Expanded(
                              child: ListTile(
                                title: Text(
                                  'Change Password',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                                subtitle: Text(
                                  'Change your password',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color:
                                          Color.fromARGB(255, 158, 158, 158)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              },
                              child: const Icon(Icons.power_settings_new,
                                  size: 30, color: Color(0xFF036568)),
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(15),
                                primary: const Color(0xFFD1F1F2),
                                onPrimary: Colors.black,
                              ),
                            ),
                            const Expanded(
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
                      ),
                    ],
                  )
                ],
              );
            }
            return const LinearProgressIndicator();
          },
        ),
      ),
    );
  }
}
