import 'package:cannabis_track_and_trace_application/api/countdiseaseandinsect.dart';
import 'package:cannabis_track_and_trace_application/config/styles.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:searchfield/searchfield.dart';
import '../../api/allcultivations.dart';
import '../../api/hostapi.dart';

class HomeScreen extends StatefulWidget {
  final String UserID;

  const HomeScreen({Key? key, required this.UserID}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Cultivations> _listCultivation;
  late List<Count> _countDisease;
  late List<Count> _countInsect;

  String? CulIDParameters;
  Future getAllCultivations() async {
    var url = hostAPI + '/trackings/AllCultivations';
    print(url);
    var response = await http.get(Uri.parse(url));
    _listCultivation = cultivationsFromJson(response.body);

    var urlCountDisease =
        hostAPI + '/trackings/CountDisease?culid=$CulIDParameters';
    print(urlCountDisease);
    var responseCountDisease = await http.get(Uri.parse(urlCountDisease));
    _countDisease = countFromJson(responseCountDisease.body);

    var urlCountInsect =
        hostAPI + '/trackings/CountInsect?culid=$CulIDParameters';
    print(urlCountInsect);
    var responseCountInsect = await http.get(Uri.parse(urlCountInsect));
    _countInsect = countFromJson(responseCountInsect.body);

    return [_listCultivation, _countDisease, _countInsect];
  }

  //DateTime date = new DateTime(now.year, now.month, now.day);

  @override
  void initState() {
    super.initState();
    getAllCultivations();
    print(DateTime.now().year);
  }

  @override
  void dispose() {
    _searchController.dispose();
    focus.dispose();
    super.dispose();
  }

  final _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final focus = FocusNode();

  // void clearSearch() {
  //   if (focus.hasFocus) {
  //     _searchController.clear();
  //   } else {
  //     if (_searchController.text.isNotEmpty) {
  //       _searchController.clear();
  //       CulIDParameters = null;
  //       setState(() {});
  //     } else {
  //       _searchController.clear();
  //     }
  //   }
  // }

  String select = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kBackground,
          title: const Text(
            "Home",
          ),
        ),
        extendBody: true,
        body: FutureBuilder(
            future: getAllCultivations(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == null) {
                  Container();
                }
                //print(snapshot.data[0].length);
                if (snapshot.data[0].length == 0) {
                  var culGH = ["N/A"];
                  return Stack(children: [
                    SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 238, 238, 240),
                                      width: 2,
                                    ),
                                  ),
                                  child: SearchField(
                                    searchInputDecoration: InputDecoration(
                                      border: InputBorder.none,
                                      //contentPadding: EdgeInsets.only(left: 15),
                                      hintText: 'เลือกรอบการปลูก',
                                      hintStyle: const TextStyle(
                                          color: Colors.black54, fontSize: 18),
                                      prefixIcon: const Icon(
                                        Icons.search,
                                        size: 30,
                                        color: Colors.black54,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.clear,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          if (_searchController.text.isEmpty) {
                                            focus.unfocus();
                                            if (_searchController
                                                .text.isNotEmpty) {
                                              _searchController.clear();
                                              FocusScope.of(context)
                                                  .requestFocus(FocusNode());
                                              //focus.unfocus();
                                              CulIDParameters = null;
                                              setState(() {});
                                            } else {
                                              _searchController.clear();
                                            }
                                          }
                                          //clearSearch();
                                        },
                                        iconSize: 25,
                                        color: Colors.black54,
                                      ),
                                    ),

                                    //focusNode: focus,
                                    suggestions: culGH
                                        .map((culgh) => SearchFieldListItem(
                                            culgh.toString(),
                                            item: culGH))
                                        .toList(),
                                    // suggestionState: Suggestion.hidden,
                                    //hasOverlay: true,
                                    controller: _searchController,
                                    // hint: 'Search by country name',
                                    maxSuggestionsInViewPort: 5,
                                    itemHeight: 50,

                                    // validator: (x) {
                                    //   if (x!.isEmpty || !containsCountry(x)) {
                                    //     return 'Please Enter a valid Country';
                                    //   }
                                    //   return null;
                                    // },
                                    inputType: TextInputType.text,
                                    onSuggestionTap: (newValue) {
                                      setState(() {
                                        select = newValue.searchKey;
                                        // print(culGH.indexOf(select));
                                        /*ถ้าเอาไปใช้จริงให้ใส่เงื่อนไข If เหมือนตัวอย่างข้างล่าง
                          if (itemHvtID.indexOf(dropdownHvtID!) ==
                                            0) {
                                          _ctlHarvestNo.text = "";
                                        } else {
                                          _ctlHarvestNo.text = dataHarvests[
                                                  itemHvtID.indexOf(
                                                          dropdownHvtID!) -
                                                      1]
                                              .harvestNo
                                              .toString();
                                        } */
                                        // CulIDParameters =
                                        //     result[culGH.indexOf(select)]
                                        //         .cultivationId
                                        //         .toString();
                                        // print(result[culGH.indexOf(select)]
                                        //     .cultivationId
                                        //     .toString());
                                        //     "  " +
                                        //     result[culGH.indexOf(select)]
                                        //         .culGh
                                        //         .toString());
                                        // print(_searchController.text);
                                      });
                                      //_formKey.currentState!.validate();
                                      focus.unfocus();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            LayoutBuilder(builder: (context, constraints) {
                              return Column(
                                children: [
                                  buildTaskHead("", "", ""),
                                  const SizedBox(height: 10),
                                  buildAmount("", ""),
                                  const SizedBox(height: 10),
                                  buildGraph(0),
                                  const SizedBox(height: 10),
                                  buildResult("-", "-"),
                                  const SizedBox(height: 70),
                                ],
                              );
                            })
                          ],
                        ),
                      ),
                    )
                  ]);
                }

                var result = snapshot.data[0];
                var countDisease = snapshot.data[1];
                var countInsect = snapshot.data[1];

                var culGH = [];
                for (var i = 0; i < result.length; i++) {
                  culGH.add(result[i].culGh);
                }

                CulIDParameters ??= result[0].cultivationId.toString();
                //print(CulIDParameters);
                //print(result[0].cultivationId);
                return Stack(children: [
                  SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 238, 238, 240),
                                    width: 2,
                                  ),
                                ),
                                child: SearchField(
                                  searchInputDecoration: InputDecoration(
                                    border: InputBorder.none,
                                    //contentPadding: EdgeInsets.only(left: 15),
                                    hintText: 'เลือกรอบการปลูก',
                                    hintStyle: const TextStyle(
                                        color: Colors.black54, fontSize: 18),
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      size: 30,
                                      color: Colors.black54,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        if (_searchController.text.isEmpty) {
                                          focus.unfocus();
                                          if (_searchController
                                              .text.isNotEmpty) {
                                            _searchController.clear();
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            //focus.unfocus();
                                            CulIDParameters = null;
                                            setState(() {});
                                          } else {
                                            _searchController.clear();
                                          }
                                        }
                                        //clearSearch();
                                      },
                                      iconSize: 25,
                                      color: Colors.black54,
                                    ),
                                  ),

                                  //focusNode: focus,
                                  suggestions: culGH
                                      .map((culgh) => SearchFieldListItem(
                                          culgh.toString(),
                                          item: culGH))
                                      .toList(),
                                  // suggestionState: Suggestion.hidden,
                                  //hasOverlay: true,
                                  controller: _searchController,
                                  // hint: 'Search by country name',
                                  maxSuggestionsInViewPort: 5,
                                  itemHeight: 50,

                                  // validator: (x) {
                                  //   if (x!.isEmpty || !containsCountry(x)) {
                                  //     return 'Please Enter a valid Country';
                                  //   }
                                  //   return null;
                                  // },
                                  inputType: TextInputType.text,
                                  onSuggestionTap: (newValue) {
                                    setState(() {
                                      select = newValue.searchKey;
                                      print(culGH.indexOf(select));
                                      /*ถ้าเอาไปใช้จริงให้ใส่เงื่อนไข If เหมือนตัวอย่างข้างล่าง
                          if (itemHvtID.indexOf(dropdownHvtID!) ==
                                            0) {
                                          _ctlHarvestNo.text = "";
                                        } else {
                                          _ctlHarvestNo.text = dataHarvests[
                                                  itemHvtID.indexOf(
                                                          dropdownHvtID!) -
                                                      1]
                                              .harvestNo
                                              .toString();
                                        } */
                                      CulIDParameters =
                                          result[culGH.indexOf(select)]
                                              .cultivationId
                                              .toString();
                                      print(result[culGH.indexOf(select)]
                                          .cultivationId
                                          .toString());
                                      //     "  " +
                                      //     result[culGH.indexOf(select)]
                                      //         .culGh
                                      //         .toString());
                                      // print(_searchController.text);
                                    });
                                    //_formKey.currentState!.validate();
                                    focus.unfocus();
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          LayoutBuilder(builder: (context, constraints) {
                            if (_searchController.text.isEmpty) {
                              return Column(
                                children: [
                                  buildTaskHead(
                                      result[0].no.toString(),
                                      result[0].plantTotal.toString(),
                                      result[0].nameGh.toString()),
                                  const SizedBox(height: 10),
                                  buildAmount(result[0].plantLive.toString(),
                                      result[0].plantDead.toString()),
                                  const SizedBox(height: 10),
                                  buildGraph(result[0].percentageLive),
                                  const SizedBox(height: 10),
                                  buildResult(countDisease[0].count.toString(),
                                      countInsect[0].count.toString()),
                                  const SizedBox(height: 70),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  buildTaskHead(
                                      result[culGH.indexOf(select)]
                                          .no
                                          .toString(),
                                      result[culGH.indexOf(select)]
                                          .plantTotal
                                          .toString(),
                                      result[culGH.indexOf(select)]
                                          .nameGh
                                          .toString()),
                                  const SizedBox(height: 10),
                                  buildAmount(
                                      result[culGH.indexOf(select)]
                                          .plantLive
                                          .toString(),
                                      result[culGH.indexOf(select)]
                                          .plantDead
                                          .toString()),
                                  const SizedBox(height: 10),
                                  buildGraph(result[culGH.indexOf(select)]
                                      .percentageLive),
                                  const SizedBox(height: 10),
                                  buildResult(countDisease[0].count.toString(),
                                      countInsect[0].count.toString()),
                                  const SizedBox(height: 70),
                                ],
                              );
                            }
                          })
                        ],
                      ),
                    ),
                  )
                ]);
              }
              return const LinearProgressIndicator();
            }));
  }

  Widget buildTaskHead(String CulNo, String plantTotal, String nameGh) {
    return Column(
      children: [
        Text(
          "รายงานรอบการปลูกที่  " + CulNo,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(left: 5, right: 5),
          height: 170,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("images/Home1.jpg"),
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
            borderRadius: BorderRadius.circular(40),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'จำนวนต้นทั้งหมด',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      plantTotal + '  ต้น',
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(width: 70),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      'โรงเรือน',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      nameGh,
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAmount(String plantLive, String plantDead) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 10),
      //padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 170,
            height: 80,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x33000000),
                  offset: Offset(2, 4),
                  spreadRadius: 2,
                )
              ],
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(
                color: const Color(0xFFCFD4DB),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 166, 245, 168),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.green,
                      size: 30,
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            plantLive,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Text(
                        'ต้นปกติ',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 14, 117, 17),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 170,
            height: 80,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x33000000),
                  offset: Offset(2, 4),
                  spreadRadius: 2,
                )
              ],
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(
                color: const Color(0xFFCFD4DB),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 209, 207, 207),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Color.fromARGB(255, 230, 28, 13),
                      size: 30,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        plantDead,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'ต้นตาย',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 230, 28, 13),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      //
    );
  }

  Widget buildGraph(double percentageLive) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color.fromARGB(255, 176, 4, 211),
            offset: Offset(0, 0),
            spreadRadius: 2,
          )
        ],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromARGB(255, 134, 3, 160),
          width: 3,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text(
              'การเจริญเติบโตทั่วไป',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CircularPercentIndicator(
                    percent: percentageLive / 100,
                    radius: 80,
                    lineWidth: 20,
                    animation: true,
                    progressColor: colorGraph1,
                    backgroundColor: colorGraph2,
                    center: Text(
                      percentageLive.toString() + '%',
                      style: const TextStyle(
                          fontSize: 26,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.label,
                          color: colorGraph1,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'ต้นดี',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.label,
                          color: colorGraph2,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'ต้นไม่ดี ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResult(CDisease, CInsect) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x33000000),
                offset: Offset(2, 4),
                spreadRadius: 2,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      height: 90,
                      child: VerticalDivider(
                        color: colorResult1,
                        thickness: 5,
                        indent: 3,
                        endIndent: 3,
                        width: 5,
                      ),
                    ),
                    const Icon(
                      Icons.search,
                      size: 50,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'การสำรวจโรค',
                          style: TextStyle(
                              fontSize: 20,
                              color: colorResult1,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'พบโรค',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text(
                    CDisease + ' กระถาง',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x33000000),
                offset: Offset(2, 4),
                spreadRadius: 2,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      height: 90,
                      child: VerticalDivider(
                        color: colorResult2,
                        thickness: 5,
                        indent: 3,
                        endIndent: 3,
                        width: 5,
                      ),
                    ),
                    const Icon(
                      Icons.search,
                      size: 50,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'การสำรวจแมลง',
                          style: TextStyle(
                              fontSize: 20,
                              color: colorResult2,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'พบแมลง',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text(
                    CInsect + ' กระถาง',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
