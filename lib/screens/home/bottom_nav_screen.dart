import 'package:cannabis_track_and_trace_application/screens/account/account_screen.dart';
import 'package:cannabis_track_and_trace_application/screens/home/home_screen.dart';
import 'package:cannabis_track_and_trace_application/screens/information/info_screen.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/show/planttracking_list.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/tracking_screen.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    //print(widget.UserID);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
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
                .copyWith(iconTheme: IconThemeData(color: Colors.white)),
            child: CurvedNavigationBar(
              key: _bottomNavigationKey,
              color: Color.fromARGB(185, 2, 92, 70),
              backgroundColor: Colors.transparent,
              buttonBackgroundColor: Color(0xFF036568),
              height: 55,
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 400),
              index: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              items: [
                const CurvedNavigationBarItem(
                  child: Icon(Icons.home, size: 30),
                  label: 'Home',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const CurvedNavigationBarItem(
                  child: Icon(Icons.assignment_rounded, size: 30),
                  label: 'Tracking',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                CurvedNavigationBarItem(
                  child: IconButton(
                    onPressed: () {
                      barCodeScanner();
                    },
                    icon: const Icon(Icons.camera_alt_outlined, size: 25),
                  ),
                  label: 'Scan',
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const CurvedNavigationBarItem(
                  child: Icon(
                    Icons.info_outline_rounded,
                  ),
                  label: 'Informations',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const CurvedNavigationBarItem(
                  child: Icon(Icons.people_alt_outlined, size: 30),
                  label: 'Account',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
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
