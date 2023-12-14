import 'dart:convert';

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hismobileapp/provider/LoginProvider.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../Models/NotificationsM.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'Examnation.dart';
import 'Home.dart';
import 'Settings.dart';
import 'package:http/http.dart' as http;
import 'XrayList.dart';

class Notifications extends StatefulWidget {
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ThemP = Provider.of<Them>(context, listen: false);

    var colors = [
      HexColor((Globalvireables.secondcolor)),
      HexColor((ThemP.getcolor()))
    ];
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var stops = [0.0, 1.00];
    var LanguageProvider = Provider.of<Language>(context, listen: false);

    return Stack(children: <Widget>[
      Image.asset(
        "assets/background.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 8,
            selectedItemColor: HexColor(Globalvireables.white),
            unselectedItemColor: Colors.white,
            backgroundColor: HexColor(ThemP.getcolor()),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: LanguageProvider.Llanguage('settings'),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: LanguageProvider.Llanguage('Home')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: LanguageProvider.Llanguage('Notifications')),
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
                LanguageProvider.Llanguage('Notifications'),
                unitHeightValue,
                LanguageProvider.langg,
                LanguageProvider.getDirection(),'false'
            ),
          ),
          backgroundColor: HexColor(ThemP.getcolor()),
          // backgroundColor: Colors.transparent,
          body: Directionality(
            textDirection: LanguageProvider.getDirectionPres(),
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
                      height: MediaQuery.of(context).size.height / 1.24,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/background.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(0.0),
                            bottomRight: Radius.circular(40.0),
                            topLeft: Radius.circular(0.0),
                            bottomLeft: Radius.circular(40.0)),
                      ),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.11,
                        height: MediaQuery.of(context).size.height / 1.4,
                        child: FutureBuilder(
                          future: getnotifications(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<NotificationsM>> snapshot) {
                            if (snapshot.hasData) {
                              List<NotificationsM>? NotificationList = snapshot.data;
                              return NotificationList!.isNotEmpty
                                  ? ListView(
                                      children: NotificationList!
                                          .map((NotificationsM inv) => SizedBox(
                                                  child: GestureDetector(
                                                onTap: () {
                                                  
                                                  if(inv.type=='0'){
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => Examnation()),);
                                                  }else{
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => XrayList()),);
                                                  }
                                                  
                                                  
                                                },
                                                child: Card(
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: HexColor(
                                                              ThemP.getcolor()),
                                                          width: 0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      child: SizedBox(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Expanded(
                                                                  child: Row(
                                                                    children: [

                                                                    /*  Icon(
                                                                        Icons.settings,
                                                                      ),*/

                                                                      Padding(
                                                                        padding: const EdgeInsets.only(left: 4,right: 4),

                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                              color: HexColor(ThemP.getcolor()),
                                                                              shape: BoxShape.circle
                                                                          ),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(9.0),
                                                                            child:
                                                                            Icon(
                                                                             Icons.maps_ugc_rounded,
                                                                              color: Colors.white,
                                                                              size: 27,
                                                                            ),
                                                                            /*SvgPicture.asset("assets/xray.svg",color: Colors.white,
                                                                              height: 25 * unitHeightValue,
                                                                              width: 25 * unitHeightValue,
                                                                            ),*/
                                                                          ),
                                                                        ),
                                                                      ),
Spacer(),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(top: 14.0,left: 4,right: 4),
                                                                        child: Align(
                                                                          alignment:
                                                                              Alignment.topRight,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              SizedBox(
                                                                                width: MediaQuery.of(context).size.width / 1.4,
                                                                                child: Text(
                                                                                  inv.hdr.toString(),
                                                                                  maxLines: 3,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  textAlign: TextAlign.right,
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: MediaQuery.of(context).size.width / 1.4,
                                                                                child: Text(
                                                                                  inv.dtl.toString(),
                                                                                  maxLines: 3,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  textAlign: TextAlign.right,
                                                                                ),
                                                                              ),

                                                                              SizedBox(height: 5,),

                                                                              Padding(
                                                                                padding: const EdgeInsets.only(bottom: 8.0),
                                                                                child: SizedBox(
                                                                                  width: MediaQuery.of(context).size.width / 1.4,
                                                                                  child: Text(
                                                                                    GetTime(inv.date.toString()),
                                                                                    maxLines: 3,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    textAlign: TextAlign.right,
                                                                                    style: TextStyle(fontSize: 12),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),



    /*     Padding(


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
                                                                                Text(textAlign: TextAlign.center, inv.date.toString().substring(0, 3), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, height: 1)),
                                                                                Text(textAlign: TextAlign.center, inv.date.toString().substring(6, 11), style: TextStyle(fontSize: 14, height: 1)),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              width: 2,
                                                                            ),
                                                                            Text(
                                                                              retDay(inv.date.toString()),
                                                                              style: TextStyle(fontSize: 38, fontWeight: FontWeight.w800, color: HexColor(ThemP.getcolor())),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )*/
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                              )))
                                          .toList(),
                                    )
                                  : Image.asset(
                                      "assets/null5.png",
                                      height: 100,
                                      width: 100,
                                    );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      )),
                ),
              ),
            ),
          )),
    ]);
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

  int selectedIndex = 1;

  final List<Widget> nav = [
    Settings(),
    Home(),
    Notifications(),
  ];

  Future<List<NotificationsM>> getnotifications() async {
    Uri postsURL = Uri.parse(Globalvireables.NotificationURL);
    print(Globalvireables.HospitalInfoURL.toString());
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    var map = new Map<String, dynamic>();
    map['PatientNo'] = Loginprovider.getuserId().toString();
    map['NotificationType'] = 'screen';
    try {
      http.Response res = await http.post(
        postsURL,
        body: map,
      );

      if (res.statusCode == 200) {
        print("Doctors" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        print(res.body.toString() + "resresresres");

        List<NotificationsM> HINFO = body
            .map(
              (dynamic item) => NotificationsM.fromJson(item),
            )
            .toList();

        print(HINFO[0].dtl.toString() + "sdafdsf");

        return HINFO;
      } else {
        throw "Unable to retrieve Doctors. orrr";
      }
    } catch (e) {}

    throw "Unable to retrieve Doctors.";
  }

  String retYear(String DATE) {
    try {
      var parts;

      if (DATE.contains('-'))
        parts = DATE.split('-');
      else if (DATE.contains('  '))
        parts = DATE.split('  ');
      else
        parts = DATE.split(' ');

      String y = parts[0].trim();

      return y.toString();
    } catch (_) {
      return "";
    }
  }

  String dattw(String date) {
    var parts = date.split('-');
    int y = int.parse(parts[0].trim());
    int m = int.parse(parts[1].trim());
    int d = int.parse(parts[2].trim());

    return ("");
  }

  String retMonth(String DATE) {
    try {
      var parts;
      String newMonth = "";
      if (DATE.contains('-'))
        parts = DATE.split('-');
      else if (DATE.contains('  '))
        parts = DATE.split('  ');
      else
        parts = DATE.split(' ');

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
    } catch (_) {
      return "";
    }
  }

  String retDay(String DATE) {
    try {
      var parts;
      if (DATE.contains('-'))
        parts = DATE.split('-');
      else if (DATE.contains('  '))
        parts = DATE.split('  ');
      else
        parts = DATE.split(' ');

      String d = parts[2].trim().substring(0, 2);

      return d.toString();
    } catch (_) {
      return '';
    }
  }

   GetTime(String time) {

    print("Timmme :: "+time);


    time=time.replaceAll('AM', ' AM');
    time=time.replaceAll('PM', ' PM');



    if(time.length<10)
      return '';
else {
      // Specify the target time

      //  String dateTimeString = "Oct 31 2023 01:40 PM";
      String dateTimeString = time;
      DateFormat format = DateFormat("MMM dd yyyy hh:mm a");
      DateTime targetTime = format.parse(dateTimeString);

      DateTime currentTime = DateTime.now();

      // Calculate the difference in time
      Duration difference = targetTime.difference(currentTime);

      // Calculate the difference in hours and minutes
      int differenceinDays = difference.inDays.abs();
      int differenceInHours = difference.inHours.abs();
     /* int differenceInMinutes = (difference -
          Duration(hours: differenceInHours)).inMinutes;*/

      int differenceInMinutes = (difference.inMinutes.abs());

      print (' قبل ' + differenceinDays.toString() + ' يوم  ');
      print (' قبل ' + differenceInHours.toString() + ' ساعة  ');
      print (' قبل ' + differenceInMinutes.toString() + ' دقيقة  ');
      if(differenceinDays>0){
  return (' قبل ' + differenceinDays.toString() + ' يوم  ');

}
    else  if (differenceInHours > 0)
        return (' قبل ' + differenceInHours.toString() + ' ساعة  ');
      else
        return (' قبل ' + differenceInMinutes.toString() + ' دقيقة  ');
    }
   }

}
