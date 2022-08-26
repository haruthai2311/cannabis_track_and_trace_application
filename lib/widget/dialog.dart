import 'package:flutter/material.dart';

class MyDialog {
  Future<void> showDialogCancel(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ยืนยันการยกเลิก'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('คุณต้องการยกเลิกใช่หรือไม่?'),
                //Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ยืนยัน'),
              onPressed: () {
                //print('Confirmed');
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
