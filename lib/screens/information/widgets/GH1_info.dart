import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GH1_info extends StatefulWidget {
  const GH1_info({Key? key}) : super(key: key);

  @override
  State<GH1_info> createState() => _GH1_infoState();
}

class _GH1_infoState extends State<GH1_info> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        height: 170,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/GH.jpg"),
            fit: BoxFit.cover,
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x33000000),
              offset: Offset(0, 2),
              spreadRadius: 2,
            )
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'โรงเรือน G1(EVAP)',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'สถานที่',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'หมายเหตุ',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
