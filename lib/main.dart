import 'package:cannabis_track_and_trace_application/screens/login/login.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/add/transfers.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/show/list_cultivations.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/show/list_harvests.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/show/list_transfers.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/show/planttracking_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          //visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: const LoginScreen());
        //home: const ListPlantTrackingPage(UserID: '14', code: '222222',));
        home: ListTransfers(UserID: '14',));
  }
}
