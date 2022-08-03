import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:cannabis_track_and_trace_application/screens/tracking/tracking_screen.dart';
import 'package:flutter/material.dart';

class Cultivations extends StatefulWidget {
  @override
  State<Cultivations> createState() => _CultivationsState();
}

class _CultivationsState extends State<Cultivations> {
  DateTime date = DateTime(2022, 7, 25);

  String dropdownStrain = 'N/A';
  var itemStrain = ['N/A', 'สายพันธุ์หางกระรอก', 'สายพันธุ์หางเสือ'];

  String dropdownGH = 'N/A';
  var itemGH = ['N/A', 'โรงเรือน 1', 'โรงเรือน 2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    "บันทึกข้อมูลการปลูก",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 8, 143, 114)),
                  ),
                  const SizedBox(height: 50),
                  buildGreenHouseID(),
                  const SizedBox(height: 20),
                  buildStrainID(),
                  const SizedBox(height: 20),
                  buildNo(),
                  const SizedBox(height: 20),
                  buildSeedData(),
                  const SizedBox(height: 20),
                  buildMoveData(),
                  const SizedBox(height: 20),
                  buildSeedtotal(),
                  const SizedBox(height: 20),
                  buildSeedNet(),
                  const SizedBox(height: 20),
                  buildPlantTotal(),
                  const SizedBox(height: 20),
                  buildPlantLive(),
                  const SizedBox(height: 20),
                  buildPlantDead(),
                  const SizedBox(height: 20),
                  buildPlantRemake(),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(fontSize: 18),
                                primary: Color.fromARGB(255, 10, 94, 3),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                padding: const EdgeInsets.all(15)),
                            onPressed: () {},
                            child: Text("บันทึก"),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(fontSize: 18),
                                primary: Color.fromARGB(255, 197, 16, 4),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                padding: const EdgeInsets.all(15)),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return TrackingScreen();
                              }));
                            },
                            child: Text("ยกเลิก"),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGreenHouseID() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "โรงปลูก :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          padding: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButton(
            dropdownColor: Colors.white,
            iconSize: 30,
            isExpanded: true,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            value: dropdownGH,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: itemGH.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(
                () {
                  dropdownGH = newValue!;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildStrainID() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "สายพันธุ์ :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          padding: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButton(
            dropdownColor: Colors.white,
            iconSize: 30,
            isExpanded: true,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            value: dropdownStrain,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: itemStrain.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(
                () {
                  dropdownStrain = newValue!;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildNo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "รอบการผลิต :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: 'ระบุ',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Widget buildSeedData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "วันที่เพาะเมล็ด :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          padding: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${date.year}/${date.month}/${date.day}',
                //'${date.day}/${date.month}/${date.year}',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              OutlinedButton(
                child: Icon(Icons.date_range_outlined),
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  //if "CANCEL" = null
                  if (newDate == null) return;
                  //if "OK" => DateTime
                  setState(() => date = newDate);
                },
                style: OutlinedButton.styleFrom(
                  shape: StadiumBorder(),
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
                  textStyle: TextStyle(fontSize: 16),
                  primary: Color.fromARGB(255, 10, 91, 97),
                  //onPrimary: Colors.white
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildMoveData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "วันที่ย้ายปลูก :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          padding: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${date.year}/${date.month}/${date.day}',
                //'${date.day}/${date.month}/${date.year}',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              OutlinedButton(
                child: Icon(Icons.date_range_outlined),
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  //if "CANCEL" = null
                  if (newDate == null) return;
                  //if "OK" => DateTime
                  setState(() => date = newDate);
                },
                style: OutlinedButton.styleFrom(
                  shape: StadiumBorder(),
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
                  textStyle: TextStyle(fontSize: 16),
                  primary: Color.fromARGB(255, 10, 91, 97),
                  //onPrimary: Colors.white
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSeedtotal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "จำนวนเมล็ด :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: 'ระบุ',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Widget buildSeedNet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "น้ำหนักเมล็ด :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: 'ระบุ',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Widget buildPlantTotal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "จำนวนต้นทั้งหมด :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: 'ระบุ',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Widget buildPlantLive() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "จำนวนต้นเป็นทั้งหมด :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: 'ระบุ',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Widget buildPlantDead() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "จำนวนต้นตายทั้งหมด :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: 'ระบุ',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Widget buildPlantRemake() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "หมายเหตุ :",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 239, 239),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: '**หมายเหตุ**',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }
}
