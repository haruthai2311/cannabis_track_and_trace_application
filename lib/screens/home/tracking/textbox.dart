import 'package:flutter/material.dart';

class Textbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
