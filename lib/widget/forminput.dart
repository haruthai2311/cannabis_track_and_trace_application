import 'package:flutter/material.dart';
import '../config/styles.dart';

class MyForm {
  Widget buildform(title, controllor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: colorDetails3,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Color.fromARGB(255, 238, 238, 240),
              width: 2,
            ),
          ),
          child: TextFormField(
            controller: controllor,
            keyboardType: TextInputType.text,
            style: const TextStyle(
              color: colorDetails2,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: 'ระบุ',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }
}
