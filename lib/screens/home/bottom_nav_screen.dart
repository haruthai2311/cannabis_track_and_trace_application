import 'package:cannabis_track_and_trace_application/screens/account/account_screen.dart';
import 'package:cannabis_track_and_trace_application/screens/home/home_screen.dart';
import 'package:cannabis_track_and_trace_application/screens/information/info_screen.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/tracking_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../information/info_screen.dart';
import '../tracking/show/planttracking_list.dart';

class BottomNavScreen extends StatefulWidget {
  final String UserID;
  const BottomNavScreen({Key? key, required this.UserID}) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  // String UserID;
  //_BottomNavScreenState({required this.UserID});

  int _currentIndex = 0;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  @override
  void initState() {
    super.initState();
    //print(widget.UserID);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        body: [
          HomeScreen(UserID: widget.UserID),
          TrackingScreen(UserID: widget.UserID),
          Container(),
          InfoScreen(UserID: widget.UserID),
          AccountScreen(UserID: widget.UserID),
        ][_currentIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
          child: CurvedNavigationBar(
            key: navigationKey,
            color: const Color.fromARGB(115, 2, 116, 68),
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: const Color.fromARGB(255, 2, 92, 70),
            height: 50,

            /// 60.0
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 400),
            index: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            items: <Widget>[
              const Icon(Icons.home, size: 30),
              const Icon(Icons.assignment_rounded, size: 30),
              //Icon(Icons.camera_alt_outlined, size: 30),
              IconButton(
                  onPressed: () {
                    barCodeScanner();
                  },
                  icon: const Icon(Icons.camera_alt_outlined)),
              const Icon(Icons.info_outline_rounded, size: 30),
              const Icon(Icons.people_alt_outlined, size: 30),
            ],
          ),
        ),
      ),
    );
  }

  String? barResult;
  //String? qrResult;

  Future barCodeScanner() async {
    //String result;

    try {
      await FlutterBarcodeScanner.scanBarcode(
              "#FFBF00", "Cancel", true, ScanMode.BARCODE)
          .then((String code) {
        // if (code != "-1") {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => ListPlantTrackingPage(
        //               code: code, UserID: widget.UserID)));
        // } else {
        //   Navigator.maybePop(context);
        // }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListPlantTrackingPage(
                      code: '222222',
                      UserID: widget.UserID,
                    )));
      });

      if (!mounted) {
        return;
      }
    } on PlatformException {
      return "Failed to get plateform version";
    }
  }
}
