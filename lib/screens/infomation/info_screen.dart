import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:cannabis_track_and_trace_application/screens/infomation/chemical_uses.dart';
import 'package:cannabis_track_and_trace_application/screens/infomation/inventorys.dart';
import 'package:cannabis_track_and_trace_application/screens/infomation/locations.dart';
import 'package:cannabis_track_and_trace_application/screens/infomation/pots.dart';
import 'package:cannabis_track_and_trace_application/screens/infomation/strains.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Strains();
              }));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Strains();
                      }));
                    },
                    child: Text('เพิ่มข้อมูลสายพันธุ์'),
                  ),
                ),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Locations();
                      }));
                    },
                    child: Text('เพิ่มข้อมูลสถานที่ปลูก'),
                  ),
                ),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Pots();
                      }));
                    },
                    child: Text('เพิ่มข้อมูลกระถาง'),
                  ),
                ),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Inventorys();
                      }));
                    },
                    child: Text('เพิ่มข้อมูลวัสดุ'),
                  ),
                ),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ChemicalUses();
                      }));
                    },
                    child: Text('เพิ่มข้อมูลการใช้สารเคมี'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
