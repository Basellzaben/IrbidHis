import 'dart:convert';

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hismobileapp/UI/profile.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../Models/AppoimentsM.dart';
import '../provider/HomeProvider.dart';
import '../provider/LoginProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'Settings.dart';
import 'package:intl/intl.dart';

class Appoiments extends StatefulWidget {
  @override
  State<Appoiments> createState() => _AppoimentsState();
}

class _AppoimentsState extends State<Appoiments> {
  @override
  void initState() {
    //setsearch(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int selectedIndex = 1;

  final List<Widget> nav = [
    Settings(),
    Home(),
    profile(),
  ];
  TextEditingController dateinputC = TextEditingController();
  var state = false;

  setsearch(BuildContext context) {
    var homeP = Provider.of<HomeProvider>(context, listen: false);

    //  dateinputC.text = homeP.getVisitDate();
  }

  final key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var stops = [0.0, 1.00];
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    var ThemP = Provider.of<Them>(context, listen: false);

    return Stack(children: <Widget>[
      Image.asset(
        "assets/background.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            key: key,
            type: BottomNavigationBarType.fixed,
            elevation: 8,
            selectedItemColor: HexColor(Globalvireables.white),
            unselectedItemColor: Colors.white,
            backgroundColor: HexColor(ThemP.getcolor()),
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: LanguageProvider.Llanguage(
                  'settings',
                ),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: LanguageProvider.Llanguage('Home')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: LanguageProvider.Llanguage('profile')),
            ],
            iconSize: 30 * unitHeightValue,
            unselectedFontSize: 12 * unitHeightValue,
            selectedFontSize: 16 * unitHeightValue,
            showUnselectedLabels: true,
            currentIndex: selectedIndex,
            selectedIconTheme:
                IconThemeData(color: HexColor(Globalvireables.white)),
            onTap: _onItemTapped,
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 800.0,
            elevation: 4.0,
            title: Widgets.Appbar(
                context,
                LanguageProvider.Llanguage('Appoiments'),
                unitHeightValue,
                LanguageProvider.langg,
                LanguageProvider.getDirection()),
          ),
          backgroundColor: HexColor(ThemP.getcolor()),
          // backgroundColor: Colors.transparent,
          body: Directionality(
            textDirection: LanguageProvider.getDirection(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.15,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    HexColor((Globalvireables.secondcolor)),
                    HexColor((ThemP.getcolor()))
                  ],
                  stops: stops,
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Container(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/background.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(0.0),
                          bottomRight: Radius.circular(29.0),
                          topLeft: Radius.circular(0.0),
                          bottomLeft: Radius.circular(29.0)),
                    ),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: state
                                            ? HexColor(ThemP.getcolor())
                                            : HexColor(Globalvireables.grey),
                                      ),
                                      child: Text(
                                        LanguageProvider.Llanguage('History'),
                                        style: ArabicTextStyle(
                                            arabicFont: ArabicFont.tajawal,
                                            color:
                                                HexColor(Globalvireables.white),
                                            fontSize: 15 * unitHeightValue),
                                      ),
                                      onPressed: () async {
                                        if (!state) {
                                          setState(() {
                                            state = true;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: state
                                            ? HexColor(Globalvireables.grey)
                                            : HexColor(ThemP.getcolor()),
                                      ),
                                      child: Text(
                                        LanguageProvider.Llanguage('Schedule'),
                                        style: ArabicTextStyle(
                                            arabicFont: ArabicFont.tajawal,
                                            color:
                                                HexColor(Globalvireables.white),
                                            fontSize: 15 * unitHeightValue),
                                      ),
                                      onPressed: () async {
                                        if (state) {
                                          setState(() {
                                            state = false;
                                          });
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.11,
                            height: MediaQuery.of(context).size.height / 1.4,
                            child: FutureBuilder(
                              future: getAppoiments(
                                  context, Loginprovider.getuserId(), "20"),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<AppoimentsM>> snapshot) {
                                if (snapshot.hasData) {
                                  List<AppoimentsM>? Appoiments = snapshot.data;

                                  return Appoiments!.isNotEmpty
                                      ? ListView(
                                          children: Appoiments!
                                              .map((AppoimentsM inv) =>
                                                  SizedBox(
                                                      child: GestureDetector(
                                                    onTap: () {},
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        // Padding(
                                                        // padding: const EdgeInsets.all(8.0),
                                                        // child: Align(
                                                        // alignment: Alignment.topLeft,
                                                        // child: Text(
                                                        // textAlign: TextAlign.left,
                                                        // inv.sessionDate.toString() == null
                                                        // ||  inv.sessionDate.toString() == 'NULL'
                                                        // || inv.sessionDate.toString() ==
                                                        // 'null'? '' : inv.sessionDate.toString().substring(10,inv.sessionDate.toString().length-3)
                                                        //
                                                        //                .trim()),
                                                        //      ),
                                                        //    ),
                                                        Card(
                                                            color: Colors.white,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                  color: HexColor(
                                                                      ThemP
                                                                          .getcolor()),
                                                                  width: 1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(13),
                                                              child: SizedBox(
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Container(
                                                                                  width: MediaQuery.of(context).size.width / 1.3,
                                                                                  child: Text(
                                                                                    maxLines: 10,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    textAlign: TextAlign.left,
                                                                                    inv.doctornamEE.toString() == null || inv.doctornamEE.toString() == 'NULL' || inv.doctornamEE.toString() == 'null' ? '' : inv.doctornamEE.toString().trim(),
                                                                                    style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontWeight: FontWeight.w900),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(textAlign: TextAlign.left, inv.sessionNameE.toString() == null || inv.sessionNameE.toString() == 'NULL' || inv.sessionNameE.toString() == 'null' ? '' : "DR . " + inv.sessionNameE.toString().trim()),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8.0),
                                                                          child: Container(
                                                                              color: HexColor(ThemP.getcolor()),
                                                                              child: SizedBox(
                                                                                height: 50,
                                                                                width: 2,
                                                                              )),
                                                                        ),
                                                                        SizedBox(
                                                                          child:
                                                                            Row(
                                                                            children: [
                                                                              Column(
                                                                                children: [
                                                                                  Text(textAlign: TextAlign.center, retMonth(inv.sessionDate.toString()), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, height: 1)),
                                                                                  Text(textAlign: TextAlign.center, retYear(inv.sessionDate.toString()), style: TextStyle(fontSize: 14, height: 1)),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                width: 2,
                                                                              ),
                                                                              Text(
                                                                                retDay(inv.sessionDate.toString()),
                                                                                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800, color: HexColor(ThemP.getcolor())),
                                                                              )
                                                                            ],
                                                                          ),







                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  )))
                                              .toList(),
                                        )
                                      : Image.asset(
                                          "assets/null5.png",
                                          height: 100,
                                          width: 100,
                                        );
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )),
    ]);
  }

  Future<List<AppoimentsM>> getAppoiments(
      BuildContext context, String patientid, String date) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);

    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    Uri postsURL = Uri.parse(Loginprovider.getFirebaseIp().toString() +
        Globalvireables.AppoimentsURL);
    try {
      String state1 = '3649';
      String state2 = '2';
      var homeP = Provider.of<HomeProvider>(context, listen: false);

      var type;
      if (homeP.getvisittype() == '1' ||
          homeP.getvisittype() == '2' ||
          homeP.getvisittype() == '3' ||
          homeP.getvisittype() == '4')
        type = homeP.getvisittype();
      else
        type = '0';

      print("typerr" + " " + type);

      var map = new Map<String, dynamic>();
      map['PatientNo'] = patientid;
      map['searchDate'] = date;
      map['VisitType'] = type;
      if (state) {
        state1 = '3650';
        state2 = '1';
      }
      map['state'] = state1;
      map['state2'] = state2;
      http.Response res = await http.post(
        postsURL,
        body: map,
      );

      if (res.statusCode == 200) {
        print("Appoiments" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<AppoimentsM> Appoiments = body
            .map(
              (dynamic item) => AppoimentsM.fromJson(item),
            )
            .toList();

        return Appoiments;
      } else {
        throw "Unable to retrieve Appoiments." + res.statusCode.toString();
      }
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) => Expanded(
          child: new AlertDialog(
            title: new Text('بيانات المواعي'),
            content: Text(e.toString()),
            actions: <Widget>[],
          ),
        ),
      );
    }

    throw "Unable to retrieve Appoiments.";
  }

  _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nav[index]),
      );
    });
  }

  String retturndatenewformat(String DATE) {
    String newMonth = "";
    var parts = DATE.substring(0, 10).split('-');
    String y = parts[0].trim();
    int m = int.parse(parts[1].trim());
    String d = parts[2].trim();

    if (m == 1) {
      newMonth = 'January';
    } else if (m == 2) {
      newMonth = 'Februay';
    } else if (m == 3) {
      newMonth = 'March';
    } else if (m == 4) {
      newMonth = 'April';
    } else if (m == 5) {
      newMonth = 'May';
    } else if (m == 6) {
      newMonth = 'June';
    } else if (m == 7) {
      newMonth = 'July';
    } else if (m == 8) {
      newMonth = 'August';
    } else if (m == 9) {
      newMonth = 'September';
    } else if (m == 10) {
      newMonth = 'October';
    } else if (m == 11) {
      newMonth = 'November';
    } else if (m == 12) {
      newMonth = 'December';
    }

    return newMonth + " " + d + "," + y;
  }

  String retDay(String DATE) {
    var parts = DATE.split('-');
    String d = parts[2].trim().substring(0, 2);

    return d.toString();
  }

  String retYear(String DATE) {
    var parts = DATE.split('-');
    String y = parts[0].trim();

    return y.toString();
  }

  String retMonth(String DATE) {
    String newMonth = "";
    var parts = DATE.split('-');
    int m = int.parse(parts[1].trim());
    if (m == 1) {
      newMonth = 'JAN';
    } else if (m == 2) {
      newMonth = 'FEB';
    } else if (m == 3) {
      newMonth = 'MAR';
    } else if (m == 4) {
      newMonth = 'APR';
    } else if (m == 5) {
      newMonth = 'MAY';
    } else if (m == 6) {
      newMonth = 'JUN';
    } else if (m == 7) {
      newMonth = 'JUL';
    } else if (m == 8) {
      newMonth = 'AUG';
    } else if (m == 9) {
      newMonth = 'SEP';
    } else if (m == 10) {
      newMonth = 'OCT';
    } else if (m == 11) {
      newMonth = 'NOV';
    } else if (m == 12) {
      newMonth = 'DEC';
    }
    return newMonth.toString();
  }
}
