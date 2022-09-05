import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:cannabis_track_and_trace_application/screens/home/account_screen.dart';
import 'package:cannabis_track_and_trace_application/screens/home/scan_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String UserID;

  const HomeScreen({Key? key, required this.UserID}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //   @override
  // void initState() {
  //   super.initState();
  //   print(widget.UserID);

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
        title: Text(
          "Home Screen",
          // style: Theme.of(context)
          //     .textTheme
          //     .bodySmall!
          //     .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      extendBody: true,
      body: _buildBody(),
    );
  }

  Stack _buildBody() {
    return Stack(children: [
      SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              buildSearch(),
              const SizedBox(height: 15),
              buildTaskHead(),
              const SizedBox(height: 15),
              buildAmount(),
              const SizedBox(height: 15),
              buildGraph(),
              const SizedBox(height: 15),
              buildResult(),
              const SizedBox(height: 150),
            ],
          ),
        ),
      )
    ]);
  }

  Widget buildSearch() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 15.0),
          height: 50,
          decoration: BoxDecoration(
              color: Color.fromARGB(95, 179, 173, 173),
              borderRadius: BorderRadius.circular(15.0)),
          // width: 10,
          child: Row(
            children: [
              Icon(
                Icons.search,
                size: 30,
                color: Colors.black54,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Search",
                style: TextStyle(color: Colors.black54),
              ),
              Expanded(
                  child: Row(
                children: [
                  SizedBox(width: 220),
                  Icon(
                    Icons.settings,
                    size: 30,
                    color: Colors.black54,
                  ),
                ],
              ))
            ],
          ),
        ),
        SizedBox(height: 15),
        Text(
          "รายงารอบการปลูกที่ 1/65",
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget buildTaskHead() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      width: 300,
      height: 150,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x33000000),
            offset: Offset(0, 2),
            spreadRadius: 2,
          )
        ],
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 1, 100, 84),
            Color.fromARGB(255, 2, 158, 140)
          ],
          stops: [0, 1],
          begin: AlignmentDirectional(0, -1),
          end: AlignmentDirectional(0, 1),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      // child: Padding(
      //   padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
      //   child: Column(mainAxisSize: MainAxisSize.max, children: [
      //     Padding(
      //       padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
      //       child: Row(
      //         mainAxisSize: MainAxisSize.max,
      //         children: [
      //           Expanded(
      //               child: Padding(
      //             padding: EdgeInsetsDirectional.fromSTEB(8, 4, 0, 4),
      //             child: Column(
      //                 mainAxisSize: MainAxisSize.max,
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Padding(
      //                     padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
      //                     child: Text(
      //                       'จำนวนต้นทั้งหมด',
      //                     ),
      //                   ),
      //                 ]),
      //           ))
      //         ],
      //       ),
      //     )
      //   ]),
      // ),
    );
  }

  Widget buildAmount() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
      // child: Row(
      //   mainAxisSize: MainAxisSize.max,
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Padding(
      //       padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
      //       child: Container(
      //         width: MediaQuery.of(context).size.width * 0.44,
      //         height: 50,
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //           borderRadius: BorderRadius.circular(8),
      //           border: Border.all(
      //             color: Color(0xFFCFD4DB),
      //             width: 1,
      //           ),
      //         ),
      //         child: Padding(
      //           padding: EdgeInsetsDirectional.fromSTEB(12, 5, 12, 5),
      //           child: Row(
      //             mainAxisSize: MainAxisSize.max,
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Icon(
      //                 Icons.favorite,
      //                 color: Color(0xFF03A9F4),
      //                 size: 24,
      //               ),
      //               Column(
      //                 mainAxisSize: MainAxisSize.max,
      //                 children: [
      //                   Text(
      //                     '371',
      //                   ),
      //                   Text(
      //                     'ต้นปกติ',
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //     Container(
      //       width: MediaQuery.of(context).size.width * 0.44,
      //       height: 50,
      //       decoration: BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.circular(8),
      //         border: Border.all(
      //           color: Color(0xFFCFD4DB),
      //           width: 1,
      //         ),
      //       ),
      //       child: Padding(
      //         padding: EdgeInsetsDirectional.fromSTEB(12, 5, 12, 5),
      //         child: Row(
      //           mainAxisSize: MainAxisSize.max,
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Icon(
      //               Icons.favorite,
      //               color: Colors.red,
      //               size: 24,
      //             ),
      //             Column(
      //               mainAxisSize: MainAxisSize.max,
      //               children: [
      //                 Text('29'),
      //                 Text('ต้นตาย'),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget buildGraph() {
    return Column();
  }

  Widget buildResult() {
    return Column();
  }
}
