import 'package:cannabis_track_and_trace_application/screens/information/widgets/GH1all_info.dart';
import 'package:cannabis_track_and_trace_application/screens/information/widgets/GH1harvest_info.dart';
import 'package:cannabis_track_and_trace_application/screens/information/widgets/GH1plant_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../api/countcht.dart';
import '../../api/hostapi.dart';
import '../../config/styles.dart';

class DetailsGreenHouses extends StatefulWidget {
  final String GreenhouseID;
  const DetailsGreenHouses({Key? key, required this.GreenhouseID})
      : super(key: key);
  @override
  State<DetailsGreenHouses> createState() => _DetailsGreenHousesState();
}

List<String> items = [
  "All",
  "Plant",
  "Harvest",
];

int current = 0;

class _DetailsGreenHousesState extends State<DetailsGreenHouses> {
  late List<Countcht> _countcht;
  late List<Countcht> _countcht1;

  Future getCountcht() async {
    var url = hostAPI +
        '/informations/countcht?year=${DateTime.now().year}&id=${widget.GreenhouseID}';
    print(url);
    var response = await http.get(Uri.parse(url));
    _countcht = countchtFromJson(response.body);

    var url1 = hostAPI +
        '/informations/countcht?year=${DateTime.now().year - 1}&id=${widget.GreenhouseID}';
    print(url);
    var response1 = await http.get(Uri.parse(url1));
    _countcht1 = countchtFromJson(response1.body);

    return [_countcht, _countcht1];
  }

  @override
  void initState() {
    super.initState();
    getCountcht();
    print(widget.GreenhouseID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kBackground,
          title: const Text("Greenhoueses"),
        ),
        body: FutureBuilder(
            future: getCountcht(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == null) {
                  Container();
                }

                if (snapshot.data.length == 0) {
                  return const Center(
                    child: Text(
                      'ไม่พบข้อมูล',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 143, 8, 8)),
                    ),
                  );
                }

                var result = snapshot.data[0];
                var result1 = snapshot.data[1];
               // print( result1[0].countCul.toString());
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      /// CUSTOM TABBAR
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          height: 170,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/gh1.jpg"),
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
                                    'โรงเรือน '+ result[0].nameGreenhouse.toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'สถานที่ ' + result[0].nameLocation.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  // Text(
                                  //   result[0].address.toString(),
                                  //   style: const TextStyle(
                                  //     fontSize: 18,
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          width: double.infinity,
                          height: 70,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: items.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        current = index;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      margin: const EdgeInsets.all(5),
                                      width: 110,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: current == index
                                              ? Colors.green
                                              : Colors.white,
                                          borderRadius: current == index
                                              ? BorderRadius.circular(30)
                                              : BorderRadius.circular(30),
                                          border: current == index
                                              ? null
                                              : Border.all(
                                                  color: Colors.green,
                                                  width: 3.5)),
                                      child: Center(
                                        child: Text(
                                          items[index],
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: current == index
                                                  ? Colors.white
                                                  : colorTabbar),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: current == index,
                                    child: Container(
                                      width: 20,
                                      height: 3,
                                      decoration: const BoxDecoration(
                                          color: Colors.lightGreen,
                                          shape: BoxShape.rectangle),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),

                      /// MAIN BODY
                      SingleChildScrollView(
                        child: Container(
                          //margin: const EdgeInsets.only(top: 30),
                          width: double.infinity,
                          height: 500,
                          child: Scaffold(
                            body: [
                              GH1_AllInfo(countCul: result[0].countCul.toString(), countCulold: result1[0].countCul.toString(), countHar: result[0].countHar.toString(), countHarold: result1[0].countHar.toString(), countTran: result[0].countTran.toString(), countTranold: result1[0].countTran.toString(),),
                              GH1_PlantInfo(GreenhouseID: widget.GreenhouseID,),
                              GH1_HarvestInfo(GreenhouseID: widget.GreenhouseID)
                            ][current],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const LinearProgressIndicator();
            }));
  }
}
