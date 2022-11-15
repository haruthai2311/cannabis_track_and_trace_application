import 'dart:convert';

import 'package:cannabis_track_and_trace_application/widget/forminput.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../api/allharvests.dart';
import '../../../api/gettransfers.dart';
import '../../../api/hostapi.dart';
import '../../../config/styles.dart';

class EditTransfer extends StatefulWidget {
  final String UserID;
  final String TransferID;
  const EditTransfer({Key? key, required this.UserID, required this.TransferID})
      : super(key: key);

  @override
  State<EditTransfer> createState() => _EditTransferState();
}

class _EditTransferState extends State<EditTransfer> {
  DateTime date = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  bool _visible = false;
  late List<Harvests> _Harvests;

  final _ctlWeight = TextEditingController();
  final _ctlLotNo = TextEditingController();
  final _ctlGetByName = TextEditingController();
  final _ctlGetByPlate = TextEditingController();
  final _ctlLicenseNo = TextEditingController();
  final _ctlLicensePlate = TextEditingController();
  final _ctlTrackRemake = TextEditingController();
  final _ctlHarvestNo = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  late List<GetTransfers> _Transfer;

  Future getData() async {
    var url = hostAPI + "/trackings/getHarvests";
    var response = await http.get(Uri.parse(url));
    _Harvests = harvestsFromJson(response.body);

    var urlTransfer =
        hostAPI + '/trackings/getTransfer?id=' + widget.TransferID;

    var responseTransfer = await http.get(Uri.parse(urlTransfer));
    _Transfer = getTransfersFromJson(responseTransfer.body);

    return [_Harvests, _Transfer];
  }

  String? dropdowntype;
  String? selectDropdown;
  var itemtype = ['ใบ', 'ดอก', 'ก้าน'];

  String? dropdownHvtID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Transfer Edit'),
          backgroundColor: kBackground,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.save_as_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                confirmDialog();
              },
            )
          ],
        ),
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                kBackground,
                Colors.white60,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var dataHarvests = snapshot.data[0];
                var dataTransfer = snapshot.data[1];
                var itemHvtID = ['N/A'];
                for (var i = 0; i < dataHarvests.length; i++) {
                  itemHvtID.add(dataHarvests[i].harvestId.toString());
                }
                print(itemHvtID);

                String TypeTransfer;
                String type = dataTransfer[0].type.toString();
                if (type == "1") {
                  TypeTransfer = "ใบ";
                } else if (type == "2") {
                  TypeTransfer = "ดอก";
                } else if (type == "3") {
                  TypeTransfer = "ก้าน";
                } else {
                  TypeTransfer = "N/A";
                }
                selectDropdown ??= type;
                dropdownHvtID ??= dataTransfer[0].harvestId.toString();

                _ctlWeight.text = dataTransfer[0].weight.toString() + ' kg';
                _ctlLotNo.text = dataTransfer[0].lotNo.toString();
                _ctlGetByName.text = dataTransfer[0].getByName.toString();
                _ctlGetByPlate.text = dataTransfer[0].licenseNo.toString();
                _ctlLicenseNo.text = dataTransfer[0].licenseNo.toString();
                _ctlLicensePlate.text = dataTransfer[0].licensePlate.toString();
                _ctlTrackRemake.text = dataTransfer[0].remark.toString();
                var hintHarvestNo = dataTransfer[0].harvestNo.toString();
                date = dataTransfer[0].transferDate;

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 5, 0, 20),
                            child: Container(
                              width: 60,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Color(0xFFDBE2E7),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const Text(
                            "แก้ไขข้อมูลการส่งมอบ",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Divider(
                              height: 24,
                              thickness: 2,
                              color: Color(0xFFF1F4F8),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "หมายเลขการเก็บเกี่ยว :",
                                style: const TextStyle(
                                  color: colorDetails3,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 238, 238, 240),
                                    width: 2,
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    dropdownColor: Colors.white,
                                    iconSize: 30,
                                    isExpanded: true,
                                    style: const TextStyle(
                                      color: colorDetails2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    hint: Text(
                                      dataTransfer[0].harvestId.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    value: dropdownHvtID,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: itemHvtID.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(
                                        () {
                                          dropdownHvtID = newValue!;
                                          if (itemHvtID
                                                  .indexOf(dropdownHvtID!) ==
                                              0) {
                                            _ctlHarvestNo.text = "";
                                          } else {
                                            _ctlHarvestNo.text = dataHarvests[
                                                    itemHvtID.indexOf(
                                                            dropdownHvtID!) -
                                                        1]
                                                .harvestNo
                                                .toString();
                                          }

                                          //print(itemHvtID.indexOf(dropdownHvtID));
                                          //print(result[itemHvtID.indexOf(dropdownHvtID) - 1].harvestNo.toString());
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ครั้งที่ :",
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
                                  readOnly: true,
                                  controller: _ctlHarvestNo,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                    color: colorDetails2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 15),
                                    hintText: hintHarvestNo,
                                    hintStyle: TextStyle(
                                      color: colorDetails2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          buildTransferDate(),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "ประเภท :",
                                style: const TextStyle(
                                  color: colorDetails3,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 238, 238, 240),
                                    width: 2,
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    dropdownColor: Colors.white,
                                    iconSize: 30,
                                    isExpanded: true,
                                    style: const TextStyle(
                                      color: colorDetails2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    hint: Text(
                                      TypeTransfer,
                                      style: const TextStyle(
                                        color: colorDetails2,
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    value: dropdowntype,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: itemtype.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(
                                        () {
                                          dropdowntype = newValue!;
                                          if (dropdowntype == "N/A") {
                                            selectDropdown = "00";
                                          } else if (dropdowntype == "ใบ") {
                                            selectDropdown = "01";
                                          } else if (dropdowntype == "ดอก") {
                                            selectDropdown = "02";
                                          } else {
                                            selectDropdown = "03";
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          MyForm().buildformNum("น้ำหนัก (kg) : ", _ctlWeight),
                          const SizedBox(height: 20),
                          MyForm().buildformNum("หมายเลขล็อต : ", _ctlLotNo),
                          const SizedBox(height: 20),
                          MyForm().buildform("ชื่อผู้รับ : ", _ctlGetByName),
                          const SizedBox(height: 20),
                          MyForm().buildform("ชื่อสถานที่ : ", _ctlGetByPlate),
                          const SizedBox(height: 20),
                          MyForm()
                              .buildformNum("เลขที่ใบอนุญาต : ", _ctlLicenseNo),
                          const SizedBox(height: 20),
                          MyForm().buildformNum(
                              "ป้ายทะเบียนรถ : ", _ctlLicensePlate),
                          const SizedBox(height: 20),
                          MyForm()
                              .buildformRemake("หมายเหตุ : ", _ctlTrackRemake),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const LinearProgressIndicator();
            },
          ),
        ));
  }

  Widget buildTransferDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "วันที่ :",
          style: const TextStyle(
            color: colorDetails3,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Color.fromARGB(255, 238, 238, 240),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${date.year}/${date.month}/${date.day}',
                //'${date.day}/${date.month}/${date.year}',
                style: const TextStyle(
                  color: colorDetails2,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              OutlinedButton(
                child: const Icon(Icons.date_range_outlined),
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
                  shape: const StadiumBorder(),
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
                  textStyle: const TextStyle(fontSize: 16),
                  primary: const Color.fromARGB(255, 10, 91, 97),
                  //onPrimary: Colors.white
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<Null> confirmDialog() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ยืนยันการแก้ไข'),
          content: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                Text('กรุณากดยืนยันเพื่อดำเนินการแก้ไข'),
                //Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ยืนยัน'),
              onPressed: () {
                Editdata();
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

  Future Editdata() async {
    var url = hostAPI + "/trackings/editTransfers";
    // Showing LinearProgressIndicator.
    setState(() {
      _visible = true;
    });

    var response = await http.put(Uri.parse(url), body: {
      "TransferID": widget.TransferID,
      "HarvestID": dropdownHvtID.toString(),
      "TransferDate": date.toString(),
      "Type": selectDropdown.toString(),
      "Weight": _ctlWeight.text,
      "LotNo": _ctlLotNo.text,
      "GetByName": _ctlGetByName.text,
      "GetByPlace": _ctlGetByPlate.text,
      "LicenseNo": _ctlLicenseNo.text,
      "LicensePlate": _ctlLicensePlate.text,
      "Remark": _ctlTrackRemake.text,
      "UpdateBy": widget.UserID,
    });
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
    if (response.statusCode == 200) {
      print(response.body);
      var msg = jsonDecode(response.body);

      //Check Login Status
      if (msg['success'] == true) {
        setState(() {
          //hide progress indicator
          _visible = false;
        });
        //showMessage(msg["message"]);
      } else {
        setState(() {
          //hide progress indicator
          _visible = false;

          //Show Error Message Dialog
          showMessage(msg["message"]);
        });
        //showMessage(context, 'เกิดข้อผิดพลาด');
      }
    } else {
      setState(() {
        //hide progress indicator
        _visible = false;

        //Show Error Message Dialog
        showMessage("Error during connecting to Server.");
      });
    }
  }

  Future<dynamic> showMessage(String msg) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
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
