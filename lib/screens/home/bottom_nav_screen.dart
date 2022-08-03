import 'package:cannabis_track_and_trace_application/screens/home/account_screen.dart';
import 'package:cannabis_track_and_trace_application/screens/home/home_screen.dart';
import 'package:cannabis_track_and_trace_application/screens/home/scan_screen.dart';
import 'package:cannabis_track_and_trace_application/screens/infomation/info_screen.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/tracking_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  final List _screens = [
    HomeScreen(),
    TrackingScreen(),
    ScanScreen(),
    InfoScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        top: false,
        child: Scaffold(
          extendBody: true,
          body: _screens[_currentIndex],
          bottomNavigationBar: Theme(
            data: Theme.of(context)
                .copyWith(iconTheme: IconThemeData(color: Colors.white)),
            child: CurvedNavigationBar(
              key: navigationKey,
              color: Color.fromARGB(115, 2, 116, 68),
              backgroundColor: Colors.transparent,
              buttonBackgroundColor: Color.fromARGB(255, 2, 92, 70),
              height: 50,               /// 60.0
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 400),
              index: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              items: const <Widget>[
                Icon(Icons.home, size: 30),
                Icon(Icons.assignment_rounded, size: 30),
                Icon(Icons.camera_alt_outlined, size: 30),
                Icon(Icons.info_outline_rounded, size: 30),
                Icon(Icons.people_alt_outlined, size: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}