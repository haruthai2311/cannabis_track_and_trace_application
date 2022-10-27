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

  Future getAllCultivations() async {
    var url = hostAPI + '/trackings/AllCultivations';
    print(url);
    var response = await http.get(Uri.parse(url));
    _listCultivation = cultivationsFromJson(response.body);

    var urlCountDisease = hostAPI + '/trackings/CountDisease';
    var responseCountDisease = await http.get(Uri.parse(urlCountDisease));
    _countDisease = countFromJson(responseCountDisease.body);

    var urlCountInsect = hostAPI + '/trackings/CountInsect';

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

  void clearSearch() {
    if (focus.hasFocus) {
      _searchController.clear();
    } else {
      if (_searchController.text.isNotEmpty) {
        _searchController.clear();
        setState(() {});
      } else {
        _searchController.clear();
      }
    }
  }

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
        // extendBody: true,
        body: FutureBuilder(
            future: getAllCultivations(),
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
                var countDisease = snapshot.data[1];
                var countInsect = snapshot.data[1];

                var culGH = [];
                for (var i = 0; i < result.length; i++) {
                  culGH.add(result[i].culGh);
                }
                //print(result);
                return Stack(children: [
                  SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                height: 65,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(95, 179, 173, 173),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: SearchField(
                                  searchInputDecoration: InputDecoration(
                                    border: InputBorder.none,
                                    //contentPadding: EdgeInsets.only(left: 15),
                                    hintText: 'Search',
                                    hintStyle: const TextStyle(
                                        color: Colors.black54, fontSize: 18),
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      size: 30,
                                      color: Colors.black54,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () {
                                        if (_searchController.text.isEmpty) {
                                          focus.unfocus();
                                        }
                                        clearSearch();
                                      },
                                      iconSize: 30,
                                      color: Colors.black54,
                                    ),
                                  ),

                                  focusNode: focus,
                                  suggestions: culGH
                                      .map((culgh) => SearchFieldListItem(
                                          culgh.toString(),
                                          item: culGH))
                                      .toList(),
                                  // suggestionState: Suggestion.hidden,
                                  hasOverlay: true,
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
                                      print(result[culGH.indexOf(select)]
                                              .cultivationId
                                              .toString() +
                                          "  " +
                                          result[culGH.indexOf(select)]
                                              .culGh
                                              .toString());
                                      print(_searchController.text);
                                    });
                                    //_formKey.currentState!.validate();
                                    focus.unfocus();
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Container(child:
                              LayoutBuilder(builder: (context, constraints) {
                            if (_searchController.text.isEmpty) {
                              return Column(
                                children: [
                                  Text(
                                    "รายงานรอบการปลูกที่  " +
                                        result[0].no.toString(),
                                    style: TextStyle(fontSize: 18),
                                  ),

                                  const SizedBox(height: 10),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    height: 170,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'จำนวนต้นทั้งหมด',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                result[0]
                                                        .plantTotal
                                                        .toString() +
                                                    '  ต้น',
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 70),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(height: 40),
                                              const Text(
                                                'โรงเรือน',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                result[0].nameGh.toString(),
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5, bottom: 10, top: 10),
                                    //padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: const Color(0xFFCFD4DB),
                                              width: 1,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 166, 245, 168),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.favorite,
                                                    color: Colors.green,
                                                    size: 20,
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          result[0]
                                                              .plantLive
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    const Text(
                                                      'ต้นปกติ',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Color.fromARGB(
                                                            255, 14, 117, 17),
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
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: const Color(0xFFCFD4DB),
                                              width: 1,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 209, 207, 207),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.favorite,
                                                    color: Color.fromARGB(
                                                        255, 230, 28, 13),
                                                    size: 20,
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      result[0]
                                                          .plantDead
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const Text(
                                                      'ต้นตาย',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Color.fromARGB(
                                                            255, 230, 28, 13),
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
                                  ),
                                  const SizedBox(height: 10),
                                  //*กราฟ*//
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 4,
                                          color:
                                              Color.fromARGB(255, 176, 4, 211),
                                          offset: Offset(0, 0),
                                          spreadRadius: 2,
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 134, 3, 160),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: CircularPercentIndicator(
                                                  percent:
                                                      result[0].percentageLive /
                                                          100,
                                                  radius: 80,
                                                  lineWidth: 20,
                                                  animation: true,
                                                  progressColor: colorGraph1,
                                                  backgroundColor: colorGraph2,
                                                  center: Text(
                                                    result[0]
                                                            .percentageLive
                                                            .toString() +
                                                        '%',
                                                    style: const TextStyle(
                                                        fontSize: 26,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                  ),
                                  const SizedBox(height: 10),
                                  Column(
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          border: Border.all(
                                            color: const Color(0xFFCFD4DB),
                                            width: 1,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 90,
                                                    child:
                                                        const VerticalDivider(
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: const [
                                                      Text(
                                                        'การสำรวจโรค',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: colorResult1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                padding:
                                                    EdgeInsets.only(right: 15),
                                                child: Text(
                                                  countDisease[0]
                                                          .count
                                                          .toString() +
                                                      ' กระถาง',
                                                  style: TextStyle(
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Color(0xFFCFD4DB),
                                            width: 1,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 90,
                                                    child:
                                                        const VerticalDivider(
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: const [
                                                      Text(
                                                        'การสำรวจแมลง',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: colorResult2,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                padding:
                                                    EdgeInsets.only(right: 15),
                                                child: Text(
                                                  countInsect[0]
                                                          .count
                                                          .toString() +
                                                      ' กระถาง',
                                                  style: TextStyle(
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
                                  ),
                                  const SizedBox(height: 70),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  Text(
                                    "รายงานรอบการปลูกที่  " +
                                        result[culGH.indexOf(select)]
                                            .no
                                            .toString(),
                                    style: TextStyle(fontSize: 18),
                                  ),

                                  const SizedBox(height: 10),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    height: 150,
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 4,
                                          color: Color(0x33000000),
                                          offset: Offset(0, 2),
                                          spreadRadius: 2,
                                        )
                                      ],
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 1, 100, 84),
                                          Color.fromARGB(255, 2, 158, 140)
                                        ],
                                        stops: [0, 1],
                                        begin: AlignmentDirectional(0, -1),
                                        end: AlignmentDirectional(0, 1),
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'จำนวนต้นทั้งหมด',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                result[culGH.indexOf(select)]
                                                        .plantTotal
                                                        .toString() +
                                                    '  ต้น',
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 50),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'โรงเรือน',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(width: 50),
                                              Text(
                                                result[culGH.indexOf(select)]
                                                    .nameGh
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5, bottom: 10, top: 10),
                                    //padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: const Color(0xFFCFD4DB),
                                              width: 1,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 166, 245, 168),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.favorite,
                                                    color: Colors.green,
                                                    size: 20,
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          result[culGH.indexOf(
                                                                  select)]
                                                              .plantLive
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    const Text(
                                                      'ต้นปกติ',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Color.fromARGB(
                                                            255, 14, 117, 17),
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
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: const Color(0xFFCFD4DB),
                                              width: 1,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 209, 207, 207),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.favorite,
                                                    color: Color.fromARGB(
                                                        255, 230, 28, 13),
                                                    size: 20,
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      result[culGH
                                                              .indexOf(select)]
                                                          .plantDead
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const Text(
                                                      'ต้นตาย',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Color.fromARGB(
                                                            255, 230, 28, 13),
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
                                  ),
                                  const SizedBox(height: 10),
                                  //*กราฟ*//
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 4,
                                          color:
                                              Color.fromARGB(255, 176, 4, 211),
                                          offset: Offset(0, 0),
                                          spreadRadius: 2,
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 134, 3, 160),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: CircularPercentIndicator(
                                                  percent: result[culGH
                                                              .indexOf(select)]
                                                          .percentageLive /
                                                      100,
                                                  radius: 80,
                                                  lineWidth: 20,
                                                  animation: true,
                                                  progressColor: colorGraph1,
                                                  backgroundColor: colorGraph2,
                                                  center: Text(
                                                    result[culGH.indexOf(
                                                                select)]
                                                            .percentageLive
                                                            .toString() +
                                                        '%',
                                                    style: const TextStyle(
                                                        fontSize: 26,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                  ),
                                  const SizedBox(height: 10),
                                  Column(
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          border: Border.all(
                                            color: const Color(0xFFCFD4DB),
                                            width: 1,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 90,
                                                    child:
                                                        const VerticalDivider(
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: const [
                                                      Text(
                                                        'การสำรวจโรค',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: colorResult1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                padding:
                                                    EdgeInsets.only(right: 15),
                                                child: Text(
                                                  //countDisease[culGH.indexOf(select)].count.toString()+' กระถาง',
                                                  ' กระถาง',
                                                  style: TextStyle(
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Color(0xFFCFD4DB),
                                            width: 1,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 90,
                                                    child:
                                                        const VerticalDivider(
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: const [
                                                      Text(
                                                        'การสำรวจแมลง',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: colorResult2,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                padding:
                                                    EdgeInsets.only(right: 15),
                                                child: Text(
                                                  //countInsect[culGH.indexOf(select)].count.toString()+' กระถาง',
                                                  ' กระถาง',
                                                  style: TextStyle(
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
                                  ),
                                  const SizedBox(height: 70),
                                ],
                              );
                            }
                          })),
                        ],
                      ),
                    ),
                  )
                ]);
              }
              return const LinearProgressIndicator();
            }));
  }
}
