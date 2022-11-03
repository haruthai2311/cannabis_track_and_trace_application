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

  Widget buildformNum(title, controllor) {
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
            keyboardType: TextInputType.number,
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

  Widget buildformLog(title, controllor, rol) {
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
            color: Color.fromARGB(255, 245, 245, 245),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Color.fromARGB(255, 238, 238, 240),
              width: 2,
            ),
          ),
          child: TextFormField(
            readOnly: rol,
            controller: controllor,
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

  Widget buildformRemake(title, controllor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: colorDetails3,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 100,
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
            style: const TextStyle(
              color: colorDetails2,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: '**หมายเหตุ**',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Widget buildformSection(title, icon, color) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: color,
            spreadRadius: 1,
          )
        ],
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFCFD4DB),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.black54,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 20, color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
