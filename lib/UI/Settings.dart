import 'dart:convert';
import 'package:app_settings/app_settings.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hismobileapp/UI/LoginScreen.dart';
import 'package:hismobileapp/UI/profile.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';
import '../Models/HospitalInfo.dart';
import '../provider/HospitalProvider.dart';
import '../provider/LoginProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'ChangePass.dart';
import 'Family.dart';
import 'Home.dart';
import 'package:arabic_font/arabic_font.dart';
import 'package:http/http.dart' as http;

import 'HospitalInfoS.dart';
class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    getHospitalInf();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
var Terms='';
  @override
  Widget build(BuildContext context) {
    var ThemP = Provider.of<Them>(context, listen: false);

    var LanguageProvider = Provider.of<Language>(context, listen: false);
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var stops = [0.0, 1.00];
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
                  label: LanguageProvider.Llanguage('Home')
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: LanguageProvider.Llanguage('profile')
              ),
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
            title: Widgets.Appbar(context, LanguageProvider.Llanguage('settings'), unitHeightValue,LanguageProvider.langg,LanguageProvider.getDirection()),
          ),
          backgroundColor: HexColor(ThemP.getcolor()),
          body: Container(
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
            child: Directionality(
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
                    child: Container(
                      padding: EdgeInsets.only(left: 11, right: 11),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                      alignment: LanguageProvider.Align(),
                                      child: Text(
                                        LanguageProvider.Llanguage("general"),
                                        style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                            fontSize: 17.5 * unitHeightValue,
                                            color: HexColor(Globalvireables.grey),
                                            fontWeight: FontWeight.w500),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () async {

                                      setState(() {
                                        if (LanguageProvider.getLanguage() ==
                                            'AR') {
                                          LanguageProvider.setLanguage('EN');
                                        } else {
                                          LanguageProvider.setLanguage('AR');
                                        }
                                      });
                                      SharedPreferences pref =
                                          await SharedPreferences.getInstance();
                                      pref.setString(
                                          'language', LanguageProvider.langg);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.language,
                                          color:
                                              HexColor(ThemP.getcolor()),
                                          size: 35 * unitHeightValue,
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          LanguageProvider.Llanguage('language'),
                                          style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                              fontSize: 17.5 * unitHeightValue,
                                              color:
                                                  HexColor(Globalvireables.black),
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Spacer(),
                                        Text(
                                          LanguageProvider.getLanguage(),
                                          style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                            fontSize: 15.5 * unitHeightValue,
                                            color: HexColor(Globalvireables.grey),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Divider(thickness: 1.0, color: Colors.black),
                                  GestureDetector(
                                    onTap: () async {



                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChangePass()),
                                      );



                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.change_circle_outlined,
                                          color:
                                              HexColor(ThemP.getcolor()),
                                          size: 35 * unitHeightValue,
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          LanguageProvider.Llanguage('Gangepasswor'),
                                          style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                              fontSize: 17.5 * unitHeightValue,
                                              color:HexColor(Globalvireables.black),
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  ),


                                  //////////////////////////////////


                                  SizedBox(
                                    height: 6,
                                  ),
                                  Divider(thickness: 1.0, color: Colors.black),
                                  GestureDetector(
                                    onTap: () async {


                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Family()),
                                      );


                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.family_restroom_sharp,
                                          color:
                                          HexColor(ThemP.getcolor()),
                                          size: 35 * unitHeightValue,
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          LanguageProvider.Llanguage('family'),
                                          style: ArabicTextStyle(
                                              arabicFont: ArabicFont.tajawal,
                                              fontSize: 17.5 * unitHeightValue,
                                              color:HexColor(Globalvireables.black),
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  ),


                                  //////////////////////////////////
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Divider(thickness: 1.0, color: Colors.black),

                                  GestureDetector(
                                      onTap: () async {

                                        showLoaderDialog( context);
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.color_lens_outlined,
                                            color: HexColor(
                                                ThemP.getcolor()),
                                            size: 35 * unitHeightValue,
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            LanguageProvider.Llanguage('theme'),
                                            style: ArabicTextStyle(
                                                arabicFont: ArabicFont.tajawal,
                                                fontSize: 17.5 * unitHeightValue,
                                                color: HexColor(
                                                    Globalvireables.black),
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      )),

                                  ///////////////////////////



                                  SizedBox(
                                    height: 6,
                                  ),
                                  Divider(
                                      thickness: 1.0, color: Colors.black
                                  ),

                                  GestureDetector(
                                      onTap: () {

                                        AppSettings.openAppSettings(type:AppSettingsType.notification);

                                        },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.settings_applications_sharp,
                                            color: HexColor(
                                                ThemP.getcolor()),
                                            size: 35 * unitHeightValue,
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            LanguageProvider.Llanguage('Applicationpermissions'),
                                            style: ArabicTextStyle(
                                                arabicFont: ArabicFont.tajawal,
                                                fontSize: 17.5 * unitHeightValue,
                                                color: HexColor(
                                                    Globalvireables.black),
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      )),





                                  ///////////////////////////

                                  SizedBox(
                                    height: 6,
                                  ),
                                  Divider(
                                      thickness: 1.0, color: Colors.black
                                  ),

                                  GestureDetector(
                                      onTap: () async {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: Text(
                                                    LanguageProvider.Llanguage('Logout'),
                                                    style: ArabicTextStyle(
                                                        arabicFont: ArabicFont.tajawal,
                                                        fontSize: 22 *
                                                            unitHeightValue)),
                                                content: Text(
                                                  LanguageProvider.Llanguage("txxt"),
                                                  style: ArabicTextStyle(
                                                      arabicFont: ArabicFont.tajawal,
                                                      fontSize:
                                                      14 * unitHeightValue),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    //  textColor: Colors.black,
                                                    onPressed: () {

                                                      cleanRemember();

                                                      Navigator.of(context)
                                                          .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                LoginScreen(),
                                                          ),
                                                              (Route<dynamic>
                                                          route) =>
                                                          false);
                                                    },
                                                    child: Text(
                                                      LanguageProvider.Llanguage('Logout'),
                                                      style: ArabicTextStyle(
                                                          arabicFont: ArabicFont.tajawal,
                                                          color: Colors.redAccent,
                                                          fontSize: 15 *
                                                              unitHeightValue),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    // textColor: Colors.black,
                                                    onPressed: () {
                                                      Navigator.of(context).pop();


                                                    },
                                                    child: Text(
                                                      LanguageProvider.Llanguage('cancel'),
                                                      style: ArabicTextStyle(
                                                          arabicFont: ArabicFont.tajawal,
                                                          color: Colors.black87,
                                                          fontSize: 15 *
                                                              unitHeightValue),
                                                    ),
                                                  ),
                                                ],






                                              );

                                          },
                                        );

                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.logout_outlined,
                                            color: HexColor(
                                                ThemP.getcolor()),
                                            size: 35 * unitHeightValue,
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            LanguageProvider.Llanguage('Logout'),
                                            style: ArabicTextStyle(
                                                arabicFont: ArabicFont.tajawal,
                                                fontSize: 17.5 * unitHeightValue,
                                                color: HexColor(
                                                    Globalvireables.black),
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      )),

                                  SizedBox(
                                    height: 40,
                                  ),
                                  Align(
                                      alignment: LanguageProvider.Align(),
                                      child: Text(
                                        LanguageProvider.Llanguage("Feedback"),
                                        style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                            fontSize: 17.5 * unitHeightValue,
                                            color:
                                                HexColor(Globalvireables.black),
                                            fontWeight: FontWeight.w400),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                  onTap: ()  {

                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              title: Center(
                                                child: Text(
                                                    textAlign: TextAlign.center,

                                                    LanguageProvider.Llanguage("Feedback"),
                                                    style: ArabicTextStyle(
                                                        arabicFont: ArabicFont.tajawal,
                                                        fontSize: 22 *
                                                            unitHeightValue)),
                                              ),
                                              content: Text(
                                                textAlign: TextAlign.center,

                                                LanguageProvider.Llanguage("descapp"),
                                                style: ArabicTextStyle(
                                                    arabicFont: ArabicFont.tajawal,
                                                    fontSize:
                                                    16 * unitHeightValue),
                                              ),
                                              actions: [

                              Row(children: [
                              Spacer(),
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image(
                                      image: new AssetImage(
                                          "assets/newlogo.png")),
                                ),
                                Spacer(),

                                SizedBox(
                                  width: 120,
                                  height: 120,
                                  child: Image(
                                      image: new AssetImage(
                                          "assets/logo.png")),
                                ),
                                Spacer(),


                              ],)

                                              ],

                                          );
                                        },
                                      );








                                  },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.report_gmailerrorred,
                                          color:
                                              HexColor(ThemP.getcolor()),
                                          size: 35 * unitHeightValue,
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          LanguageProvider.Llanguage("Feedback"),
                                          style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                              fontSize: 17.5 * unitHeightValue,
                                              color:
                                                  HexColor(Globalvireables.black),
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Divider(thickness: 1.0, color: Colors.black),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      // Share.share( 'https://vuemotion.ishjo.com/portal/?user_name=view&password=view123&accession_number="+"3284"+"&key_images=true');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HospitalInfoS()),
                                      );
                                    },
                                    child: Row(children: [
                                      Icon(
                                        Icons.message_outlined,
                                        color: HexColor(ThemP.getcolor()),
                                        size: 35 * unitHeightValue,
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        LanguageProvider.Llanguage("HospitalInfoS"),
                                        style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                            fontSize: 17.5 * unitHeightValue,
                                            color: HexColor(Globalvireables.black),
                                            fontWeight: FontWeight.w500),
                                      )
                                    ]),
                                  ),

                                  Divider(thickness: 1.0, color: Colors.black),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              title: Center(
                                                child: Text(
                                                    textAlign: TextAlign.center,

                                                    LanguageProvider.Llanguage("terms"),
                                                    style: ArabicTextStyle(
                                                        arabicFont: ArabicFont.tajawal,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16 *
                                                            unitHeightValue)),
                                              ),
                                              content: Text(
                                               Terms,
                                                textAlign: TextAlign.center,

                                                style: ArabicTextStyle(
                                                    arabicFont: ArabicFont.tajawal,
                                                    fontSize:
                                                    16 * unitHeightValue),
                                              ),
                                              actions: [


                                              ],

                                          );
                                        },
                                      );




                                    },
                                    child: Row(children: [
                                      Icon(
                                        Icons.privacy_tip,
                                        color: HexColor(ThemP.getcolor()),
                                        size: 35 * unitHeightValue,
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        LanguageProvider.Llanguage("terms"),
                                        style: ArabicTextStyle(
                                            arabicFont: ArabicFont.tajawal,
                                            fontSize: 17.5 * unitHeightValue,
                                            color: HexColor(Globalvireables.black),
                                            fontWeight: FontWeight.w500),
                                      )
                                    ]),
                                  ),
                                  Divider(thickness: 1.0, color: Colors.black),
                                  SizedBox(
                                  height: 6,
                                  ),
                                  GestureDetector(
                                  onTap: () async {
                                  Share.share(subject:'Marka Hospital - ', 'https://play.google.com/store/apps/details?id=com.galaxygroup.hismobileapp');
                                  },
                                  child: Row(children: [
                                  Icon(
                                  Icons.share,
                                  color: HexColor(ThemP.getcolor()),
                                  size: 35 * unitHeightValue,
                                  ),
                                  SizedBox(
                                  width: 6,
                                  ),
                                  Text(
                                  LanguageProvider.Llanguage("shareapp"),
                                  style: ArabicTextStyle(
                                  arabicFont: ArabicFont.tajawal,
                                  fontSize: 17.5 * unitHeightValue,
                                  color: HexColor(Globalvireables.black),
                                  fontWeight: FontWeight.w500),
                                  )
                                  ]),
                                  )




                                ],
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
              ),
              textDirection: LanguageProvider.getDirection(),
            ),
          )),
    ]);
  }
  _onItemTapped(int index) {
    if(index != 0){
    setState(() {
      selectedIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nav[index]),);
    });}
  }
  int selectedIndex = 1;

  final List<Widget> nav = [
    Settings(),
    Home(),
    profile(),
  ];




  showLoaderDialog(BuildContext context) {


    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,

        builder: (context) {
          return SizedBox(
            height: 320,
            child: Column(
              children: <Widget>
              [
SizedBox(height: 15,),
                Row(children: [


                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(Provider.of<Language>(context, listen: false).Llanguage('selectcolor'),

                            style: ArabicTextStyle(
                                arabicFont: ArabicFont.tajawal,
                                fontSize: 18.5 * (MediaQuery.of(context).size.height * 0.00122),
                                color: HexColor(Globalvireables.black),
                                fontWeight: FontWeight.w500)
                        )
                    ),
                  ),

                ],),
                Spacer(),

                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                        onTap: () async {
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setString('them', Globalvireables.basecolor);

                          Provider.of<Them>(context, listen: false).setcolor(Globalvireables.basecolor);
                          Navigator.pop(context);

                          setState(() {   });
                          setState(() {

                          });

                        }, child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: HexColor(Globalvireables.basecolor),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100.0),
                            bottomRight: Radius.circular(100.0),
                            topLeft: Radius.circular(100.0),
                            bottomLeft: Radius.circular(100.0)),
                      ),
                    )),
                    Spacer(),
                    GestureDetector(
                        onTap: () async {
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setString('them', Globalvireables.them1);
                          Provider.of<Them>(context, listen: false).setcolor(Globalvireables.them1);

                          Navigator.pop(context);
                          setState(() {

                          });
                        }, child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color:HexColor(Globalvireables.them1),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100.0),
                            bottomRight: Radius.circular(100.0),
                            topLeft: Radius.circular(100.0),
                            bottomLeft: Radius.circular(100.0)),
                      ),
                    )),
                    Spacer(),
                    GestureDetector(
                        onTap: () async {
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setString('them', Globalvireables.them2);
                          Provider.of<Them>(context, listen: false).setcolor(Globalvireables.them2);

                          Navigator.pop(context);
                          setState(() {

                          });
                        }, child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: HexColor(Globalvireables.them2),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100.0),
                            bottomRight: Radius.circular(100.0),
                            topLeft: Radius.circular(100.0),
                            bottomLeft: Radius.circular(100.0)),
                      ),
                    )),
                    Spacer(),
                  ],
                ),
                Spacer(),

                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                        onTap: () async {
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setString('them', Globalvireables.them3);
                          Provider.of<Them>(context, listen: false).setcolor(Globalvireables.them3);

                          Navigator.pop(context);
                          setState(() {

                          });

                        }, child:Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: HexColor(Globalvireables.them3),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100.0),
                            bottomRight: Radius.circular(100.0),
                            topLeft: Radius.circular(100.0),
                            bottomLeft: Radius.circular(100.0)),
                      ),
                    )),
                    Spacer(),
                    GestureDetector(
                        onTap: () async {
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setString('them', Globalvireables.them4);
                          Provider.of<Them>(context, listen: false).setcolor(Globalvireables.them4);
                          Navigator.pop(context);
                          setState(() {

                          });
                        }, child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: HexColor(Globalvireables.them4),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100.0),
                            bottomRight: Radius.circular(100.0),
                            topLeft: Radius.circular(100.0),
                            bottomLeft: Radius.circular(100.0)),
                      ),
                    )),
                    Spacer(),
                    GestureDetector(
                        onTap: () async {
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setString('them', Globalvireables.them5);
                          Provider.of<Them>(context, listen: false).setcolor(Globalvireables.them5);

                          Navigator.pop(context);
                          setState(() {

                          });
                        },  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: HexColor(Globalvireables.them5),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100.0),
                            bottomRight: Radius.circular(100.0),
                            topLeft: Radius.circular(100.0),
                            bottomLeft: Radius.circular(100.0)),
                      ),
                    )),
                    Spacer()
                  ],
                ),
                Spacer(),

              ]

              ,
            ),
          );
        });


  }


  Future<List<HospitalInfo>> getHospitalInf() async {
    var HosProvider = Provider.of<HospitalProvider>(context, listen: false);
    var LanguageProvider = Provider.of<Language>(context, listen: false);


    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var ip= Loginprovider.getFirebaseIp().toString();



    Uri postsURL =
    Uri.parse(ip+Globalvireables.HospitalInfoURL);
    print(Globalvireables.HospitalInfoURL.toString());
    try {
      http.Response res = await http.post(
        postsURL,
      );

      if (res.statusCode == 200) {
        print("Doctors" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<HospitalInfo> HINFO = body
            .map(
              (dynamic item) => HospitalInfo.fromJson(item),
        )
            .toList();

        print(HINFO[0].Terms.toString()+"sdafdsf");

        Terms=HINFO[0].Terms.toString();

        HosProvider.setTerms(HINFO[0].Terms.toString());
        HosProvider.setFacebook(HINFO[0].Facebook.toString());
        HosProvider.setTwitter(HINFO[0].Twitter.toString());


        return HINFO;
      } else {
        throw "Unable to retrieve Doctors.";
      }
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) =>
        new AlertDialog(
          title: new Text(LanguageProvider.Llanguage('anerrortitle')),
          content: Text(LanguageProvider.Llanguage('anerror')),

          actions: <Widget>[],
        ),
      );
    }

    throw "Unable to retrieve Doctors.";
  }
  cleanRemember() async {
   var prefs = await SharedPreferences.getInstance();

      prefs.setString('username','');
   prefs.setString('password','');

  }

}
