import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanScreen extends StatefulWidget {
  final String UserID;
  const ScanScreen({Key? key, required this.UserID}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String? barResult;
  //String? qrResult;

  Future barCodeScanner() async {
    String result;

    try {
      result = await FlutterBarcodeScanner.scanBarcode(
          "#FFBF00", "Cancel", true, ScanMode.BARCODE);
      if (!mounted) return;
      setState(() {
        barResult = result;
      });
    } on PlatformException {
      result = "Failed to get plateform version";
    }
  }

  // Future qrCodeScanner() async {
  //   String qResult;
  //   try {
  //     qResult = await FlutterBarcodeScanner.scanBarcode(
  //         "#FFBF00", "Cancel", true, ScanMode.QR);
  //   } on PlatformException {
  //     qResult = "Failed to get Plateform Version";
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     qrResult = qResult;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: MaterialButton(
                    onPressed: barCodeScanner,
                    color: Colors.amber,
                    shape: const StadiumBorder(),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.camera_alt_outlined,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "Scan Barcode",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Text(
                  barResult == null
                      ? "Scan a Code"
                      : "Scan Result is : $barResult",
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
