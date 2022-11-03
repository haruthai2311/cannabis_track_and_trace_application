import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:flutter/material.dart';

class FormDetail {
  Widget buildSubject(title, controllor, icon, color) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color(0xFFF1F4F8),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 10)),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: colorDetails3,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              controllor,
              style: const TextStyle(
                color: colorDetails2,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSubjectDat(title, controllor) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color(0xFFF1F4F8),
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: Colors.black54,
                    size: 20,
                  ),
                  SizedBox(width: 12),
                  Text(
                    title,
                    style: TextStyle(
                      color: colorDetails3,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 35),
                  Text(
                    controllor,
                    style: TextStyle(
                      color: colorDetails2,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildText(title, controllor) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: colorDetails3,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          controllor,
          style: TextStyle(
            color: colorDetails2,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
