import 'dart:convert';

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hismobileapp/UI/Doctors.dart';
import 'package:hismobileapp/UI/profile.dart';
import 'package:http/http.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../GlobalVar.dart';
import 'package:badges/badges.dart' as badges;

import '../HexaColor.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../Models/Doctor.dart';
import '../Models/HospitalInfo.dart';
import '../Models/NotificationsM.dart';
import '../Models/ProfileM.dart';
import '../Models/VisitsM.dart';
import '../provider/HomeProvider.dart';
import '../provider/HospitalProvider.dart';
import '../provider/LoginProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import 'Appoiments.dart';
import 'ChangePass.dart';
import 'DrugInHOSPITAL.dart';
import 'Examnation.dart';
import 'HospitalInfoS.dart';
import 'Insurance.dart';
import 'Invoices.dart';
import 'MedicalReport.dart';
import 'MedicalReportTList.dart';
import 'Notifications.dart';
import 'PRESCPTION.dart';
import 'Settings.dart';
import 'VitalSigns.dart';
import 'dart:convert';
import 'dart:math' as math;
import 'XrayList.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {

    changepass(context);
    super.initState();
  }

  var data;

  String selectedSpinnerItem = 'Eliseo@gardner.biz';

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController dateinput = TextEditingController();
  var HospitLProvider;
  @override
  Widget build(BuildContext context) {
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var homeP = Provider.of<HomeProvider>(context, listen: false);

    var ThemP = Provider.of<Them>(context, listen: false);

    double unitHeightValue = MediaQuery
        .of(context)
        .size
        .height * 0.00122;
    var LanguageProvider = Provider.of<Language>(context, listen: false);



    var stops = [0.0, 1.00];
    return Stack(children: <Widget>[
    Image.asset(
    "assets/background.png",
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
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
    icon: Icon(Icons.settings,),
    label: LanguageProvider.Llanguage('settings',),
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
    backgroundColor: HexColor(ThemP.getcolor()),
    //backgroundColor: Colors.transparent,
    body: Directionality(
    textDirection: LanguageProvider.getDirection(),
    child: Container(
    width: MediaQuery
        .of(context)
        .size
        .width,
    height: MediaQuery
        .of(context)
        .size
        .height / 1.1,
    decoration: BoxDecoration(
    gradient: LinearGradient(
    colors: [
    HexColor((Globalvireables.white)),
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
    width: MediaQuery
        .of(context)
        .size
        .width,
    height: MediaQuery
        .of(context)
        .size
        .height / 1.24,
    decoration: BoxDecoration(

    image: DecorationImage(
    image: AssetImage("assets/background.png"),
    fit: BoxFit.cover,),
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
    Row(
    children: [
    GestureDetector(
    onTap: () {
    showProfile(context);

    },
      child: Container(
      width: 55 * unitHeightValue,
      height: 55 * unitHeightValue,
      child: Image.asset(
      "assets/persion2.png",
      height: 30,
      width: 30,
      ),
      ),
    ),
    SizedBox(
    width: 10,
    ),
      SizedBox(
    width: MediaQuery.of(context).size.width/1.6
    ,child: Text(
    LanguageProvider.getLanguage() == "AR"
    ? Loginprovider.getnameA()
        : Loginprovider.getnameE(),
    style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
    color: HexColor(Globalvireables.black2),
    fontSize: 19 * unitHeightValue,
    fontWeight: FontWeight.w700),
    ),),
      GestureDetector(
        onTap: () {
          print("name "+Loginprovider.getnameA());

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Notifications()),
          );
        },

   child: badges.Badge(

    badgeAnimation: badges.BadgeAnimation.rotation(
    animationDuration: Duration(seconds: 1),
    colorChangeAnimationDuration: Duration(seconds: 1),
    loopAnimation: false,
    curve: Curves.fastOutSlowIn,
    colorChangeAnimationCurve: Curves.easeInCubic,
    ),
    badgeStyle: badges.BadgeStyle(
    badgeColor: Colors.blue,
    padding: EdgeInsets.all(5),
    badgeGradient: badges.BadgeGradient.linear(
    colors: [HexColor((ThemP.getcolor())), HexColor((ThemP.getcolor()))],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    )),



    badgeContent:
    StreamBuilder<String>(
    stream: getnotificationsCount(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return CircularProgressIndicator.adaptive(); // Display a loading indicator
    } else if (snapshot.hasError) {
      return Text(
        '0',
      );
    } else {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Text(
        "${snapshot.data ?? '0'}",
          style: TextStyle(color: Colors.white),// Display the count or '0' if null
        ),
      ),
    );
    }
    },
    ),

   // Text(,style: TextStyle(color: Colors.white),),
    child: Icon(
    Icons.notifications,
    color: HexColor(ThemP.getcolor()),
    size: 33 * unitHeightValue,
    ),
    )



    )
    ],
    ),
    SizedBox(
    height: 10,
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
      child: Container(
      alignment: LanguageProvider.Align(),

      child: Text(
      LanguageProvider.Llanguage("AlEsraaHospital"),
      style: ArabicTextStyle(
              arabicFont: ArabicFont.tajawal,
      color: HexColor(Globalvireables.black2),
      fontSize: 22 * unitHeightValue,
      fontWeight: FontWeight.w700)
      ),


      ),
    ),

    SizedBox(height: 5,),
    SizedBox(
    child: SizedBox(
    child: TextField(
    controller: dateinput,
    //editing controller of this TextField
    decoration: InputDecoration(



    prefixIcon: Icon(
    Icons.airline_seat_flat, color: HexColor(
    ThemP.getcolor()),
    size: 27 * unitHeightValue,),
    suffixIcon: GestureDetector(
    onTap: () {
    setState(() {

    dateinput.text = LanguageProvider.Llanguage('Searchbyvisit');

    homeP.setVisitDate('');

    homeP.setvisitNo('0');
    homeP.setvisittype('0');

    });
    },
    child: Icon(color: Colors.redAccent,
    dateinput.text.contains(
    LanguageProvider.Llanguage(
    'Searchbyvisit')) || dateinput.text.length!=10
    ? null
    : Icons.cancel)),
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
    color: HexColor(
    ThemP.getcolor()),
    width: 2.0),
    borderRadius:
    BorderRadius.circular(10.0)),
    enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
    color: HexColor(
    ThemP.getcolor()),
    width: 2.0),
    borderRadius:
    BorderRadius.circular(10.0)),
    contentPadding: EdgeInsets.only(
    top: 18,
    bottom: 18,
    right: 20,
    left: 20),
    fillColor:
    HexColor(Globalvireables.white),
    filled: true,
    hintText: LanguageProvider.Llanguage(
    "Searchbyvisit"),
    ),
    readOnly: true,
    //set it true, so that user will not able to edit text
    onTap: () async {
    showDialog(
    context: context,
    builder: (BuildContext context) {
    return Center(
    child: Card(
    child: Padding(
    padding: const EdgeInsets.all(9.0),
    child: Container(
    height: MediaQuery
        .of(context)
        .size
        .height / 2,
    width: MediaQuery
        .of(context)
        .size
        .width / 1.3,
    child: Column(
    children: [
    Padding(
    padding: const EdgeInsets
        .all(8.0),
    child: SizedBox(
    child: Text(
    LanguageProvider.Llanguage('myvisit'),

        style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
            color: HexColor(Globalvireables.black2),
            fontSize: 20 * unitHeightValue,
            fontWeight: FontWeight
                .w900
           )

   ),
    ),
    ),
      Divider(thickness: 1.0, color: Colors.grey),

    SizedBox(
    height: MediaQuery
        .of(context)
        .size
        .height / 3,
    width: MediaQuery
        .of(context)
        .size
        .width / 1.4,
    child: FutureBuilder(
    future: getvisits(
    context, Loginprovider.getuserId()),
    builder: (
    BuildContext context,
    AsyncSnapshot<List<
    VisitsM>> snapshot) {
    if (snapshot.hasData) {
    List<
    VisitsM>? Visits = snapshot
        .data;
    return ListView(
    children: Visits!
        .map((
    VisitsM v) =>
    Column(
      children: [
        Card(
          child: GestureDetector(
          onTap: () {

          homeP.setVisitDate(v
              .visitDate
              .toString().substring(0,10)) ;
          dateinput.text=homeP.getVisitDate();
          homeP.setvisitNo(v
              .visitName
              .toString()) ;

          dateinput.text=homeP.getVisitDate();


          homeP.setvisittype(v
              .VisitType
              .toString()) ;

          setState(() {

          });
          Navigator.pop(context);
          },
          child
              : Padding(
          padding: const EdgeInsets.all(
          8.0),
          child: SizedBox(
          child: Row(
          children: [
          Spacer(),
          Text(
          v
              .visitName
              .toString(),
          style: ArabicTextStyle(
                  arabicFont: ArabicFont.tajawal,
          color: Colors
              .black,
          fontSize: 15 *
          unitHeightValue,
          fontWeight: FontWeight
              .w700),),
          Spacer(),
          Spacer(),
          Text(
          v
              .visitDate
              .toString().substring(0,10),
          style: ArabicTextStyle(
                  arabicFont: ArabicFont.tajawal,
          color: Colors
              .black,
          fontSize: 13 *
          unitHeightValue,
          fontWeight: FontWeight
              .w700),),
          Spacer(),
            Text(
              gettypevisit(v
                  .VisitType
                  .toString()),
              style: ArabicTextStyle(
                  arabicFont: ArabicFont.tajawal,
                  color: Colors
                      .black,
                  fontSize: 13 *
                      unitHeightValue,
                  fontWeight: FontWeight
                      .w700),),
            Spacer(),





          ],)

          ),
          ),
          ),
        ),
      ],
    )

    )
        .toList(),
    );
    } else {
    return Center(
    child: CircularProgressIndicator());
    }
    },
    ),
    ),
      Align(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary:
              HexColor(ThemP.getcolor()),
            ),
            child: Text(
              LanguageProvider.Llanguage('cancel'),
              style: ArabicTextStyle(
                  arabicFont: ArabicFont.tajawal,
                  color:
                  HexColor(Globalvireables.white),
                  fontSize: 14 * unitHeightValue),
            ),
            onPressed: () async {
              Navigator.of(context).pop();

            },
          ),
        ),
      )
    /*  TextButton(
    onPressed: () {
    Navigator.of(context).pop();
    },
    child: Text(
    LanguageProvider.Llanguage('cancel'),
    style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
    color: HexColor(ThemP.getcolor())87,
    fontSize: 15 *
    unitHeightValue),
    ),
    ),*/
    ],
    ),

    ),
    ),
    ),
    );
    },
    );
    },
    ),
    ),


    ),
    SizedBox(
    height: 15,
    ),
    Row(
    children: [
    GestureDetector(
    onTap: () async {


      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Appoiments()),);


    },
    child: Column(
    children: [
 Container(
   decoration: BoxDecoration(
       border: Border.all(color: HexColor(ThemP.getcolor())),
        borderRadius: BorderRadius.circular(15.0),

    ),
    width: MediaQuery
        .of(context)
        .size
        .width /
    4.5,
    height:
    MediaQuery
        .of(context)
        .size
        .width /
    4.5,
    child: Column(
    children: [
      Spacer(),
      SvgPicture.asset("assets/Dates.svg",color: HexColor(ThemP.getcolor()),
        height: 50 * unitHeightValue,
        width: 50 * unitHeightValue,
      ),
      Spacer(),

    ],
    ),
    ),
      SizedBox(
        height: 5,
      ),
    Text(
    LanguageProvider.Llanguage("Appoiments"),
        style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
            color: HexColor(ThemP.getcolor()),
            fontSize: 13 * unitHeightValue,
            fontWeight: FontWeight.w700
        )
    ),





    ],
    ),
    ),
    Spacer(),

    GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Invoices( )),);
 /*     if(homeP.getvisitNo().toString()!='0')
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Invoices( )),);
      else
        showDialog(
          context: context,
          builder: (context) =>
          new AlertDialog(
            title: new Text(LanguageProvider.Llanguage('note')),
            content: Text(LanguageProvider.Llanguage('selectvisitno')),
            actions: <Widget>[],
          ),
        );*/



    },
    child: Column(
    children: [


    Container(
      decoration: BoxDecoration(
        border: Border.all(color: HexColor(ThemP.getcolor())),
        borderRadius: BorderRadius.circular(15.0),

      ),
    width: MediaQuery
        .of(context)
        .size
        .width /
    4.5,
    height:
    MediaQuery
        .of(context)
        .size
        .width /
    4.5,
    child: Column(
    children: [
    Spacer(),
      SvgPicture.asset("assets/invoices.svg",color: HexColor(ThemP.getcolor()),
        height: 50 * unitHeightValue,
        width: 50 * unitHeightValue,
      ),
    Spacer(),
    ],
    ),
    ),
      SizedBox(
        height: 5,
      ),
    Text(
    LanguageProvider.Llanguage("Invoices"),


        style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
            color: HexColor(ThemP.getcolor()),
            fontSize: 13 * unitHeightValue,
            fontWeight: FontWeight.w700
        )



    ),
    ],
    ),
    ),
    Spacer(),
    GestureDetector(
        onTap: () async {

         // if(homeP.getvisitNo().toString()!='0')
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => XrayList()),);
         /* else
            showDialog(
              context: context,
              builder: (context) =>
              new AlertDialog(
                title: new Text(LanguageProvider.Llanguage('note')),
                content: Text(LanguageProvider.Llanguage('selectvisitno')),
                actions: <Widget>[],
              ),
            );
*/

        },


        child: Column(
          children: [

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: HexColor(ThemP.getcolor())),
                borderRadius: BorderRadius.circular(15.0),

              ),
                width: MediaQuery
                    .of(context)
                    .size
                    .width /
                    4.5,
                height:
                MediaQuery
                    .of(context)
                    .size
                    .width /
                    4.5,
                child: Column(
                  children: [
                    Spacer(),
                    SvgPicture.asset("assets/xray.svg",color: HexColor(ThemP.getcolor()),
                      height: 50 * unitHeightValue,
                      width: 50 * unitHeightValue,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            SizedBox(
              height: 5,
            ),
            Text(
                LanguageProvider.Llanguage("Ray"),


                style: ArabicTextStyle(
                    arabicFont: ArabicFont.tajawal,
                    color: HexColor(ThemP.getcolor()),
                    fontSize: 13 * unitHeightValue,
                    fontWeight: FontWeight.w700
                )


            ),
          ],
        ),
      ),
    ],),
    SizedBox(
    height: 5,
    ),
    Row(
    children: [
    GestureDetector(
    onTap: () {

    //  if(homeP.getvisitNo().toString()!='0')
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => Insurance()),);
    /*  else
         showDialog(
          context: context,
          builder: (context) =>
      new AlertDialog(
        title: new Text(LanguageProvider.Llanguage('note')),
        content: Text(LanguageProvider.Llanguage('selectvisitno')),
        actions: <Widget>[],
      ),
      );*/
    },
    child: Column(
    children: [

     Container(
      decoration: BoxDecoration(
        border: Border.all(color: HexColor(ThemP.getcolor())),
        borderRadius: BorderRadius.circular(15.0),

      ),
    width: MediaQuery
        .of(context)
        .size
        .width /
    4.5,
    height:
    MediaQuery
        .of(context)
        .size
        .width /
    4.5,
    child: Column(
    children: [
    Spacer(),
      SvgPicture.asset("assets/Insurance.svg",color: HexColor(ThemP.getcolor()),
        height: 50 * unitHeightValue,
        width: 50 * unitHeightValue,
      ),
    Spacer(),
    ],
    ),
    ),
      SizedBox(
        height: 5,
      ),
    Text(
    LanguageProvider.Llanguage("Insurance"),


        style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
            color: HexColor(ThemP.getcolor()),
            fontSize: 13 * unitHeightValue,
            fontWeight: FontWeight.w700
        )


    ),
    ],
    ),
    ),
    Spacer(),
    GestureDetector(
    onTap: () {

      //if(homeP.getvisitNo().toString()!='0')
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VitalSigns()),);
      /*else
        showDialog(
          context: context,
          builder: (context) =>
          new AlertDialog(
            title: new Text(LanguageProvider.Llanguage('note')),
            content: Text(LanguageProvider.Llanguage('selectvisitno')),
            actions: <Widget>[],
          ),
        );
*/


    },
    child: Column(
    children: [
    Container(
      decoration: BoxDecoration(
        border: Border.all(color: HexColor(ThemP.getcolor())),
        borderRadius: BorderRadius.circular(15.0),

      ),
    width: MediaQuery
        .of(context)
        .size
        .width /
    4.5,
    height:
    MediaQuery
        .of(context)
        .size
        .width /
    4.5,
    child: Column(
    children: [
    Spacer(),
      SvgPicture.asset("assets/VitalSigns.svg",color: HexColor(ThemP.getcolor()),
        height: 50 * unitHeightValue,
        width: 50 * unitHeightValue,
      ),
    Spacer(),
    ],
    ),
    ),
      SizedBox(
        height: 5,
      ),
    Text(
    LanguageProvider.Llanguage("Vitalsigns"),

        style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
            color: HexColor(ThemP.getcolor()),
            fontSize: 13 * unitHeightValue,
            fontWeight: FontWeight.w700
        )

    ),
    ],
    ),
    ),
    Spacer(),
    GestureDetector(
    onTap: () async {


     // if(homeP.getvisitNo().toString()!='0')
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PRESCPTION()),);
      /*else
        showDialog(
          context: context,
          builder: (context) =>
          new AlertDialog(
            title: new Text(LanguageProvider.Llanguage('note')),
            content: Text(LanguageProvider.Llanguage('selectvisitno')),
            actions: <Widget>[],
          ),
        );*/
  },
      child: Column(
      children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: HexColor(ThemP.getcolor())),
          borderRadius: BorderRadius.circular(15.0),

        ),
      width: MediaQuery
          .of(context)
          .size
          .width /
      4.5,
      height:
      MediaQuery
          .of(context)
          .size
          .width /
      4.5,
      child: Column(
      children: [
      Spacer(),
        SvgPicture.asset("assets/Medical.svg",color: HexColor(ThemP.getcolor()),
          height: 50 * unitHeightValue,
          width: 50 * unitHeightValue,
        ),
      Spacer(),
      ],
      ),
      ),
        SizedBox(
          height: 5,
        ),
      Text(
      LanguageProvider.Llanguage("Prescription"),

          style: ArabicTextStyle(

              arabicFont: ArabicFont.tajawal,
              color: HexColor(ThemP.getcolor()),
              fontSize: 13 * unitHeightValue,
              fontWeight: FontWeight.w700
          )


      ),
      ],
      ),
    )
    ],
    ),
    SizedBox(
    height: 5,
    ),
    Row(
    children: [
    GestureDetector(
    onTap: () async {


    //  if(homeP.getvisitNo().toString()!='0')
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Examnation()),);
    /*  else
        showDialog(
          context: context,
          builder: (context) =>
          new AlertDialog(
            title: new Text(LanguageProvider.Llanguage('note')),
            content: Text(LanguageProvider.Llanguage('selectvisitno')),
            actions: <Widget>[],
          ),
        );*/


    },
    child: Column(
    children: [

   Container(
      decoration: BoxDecoration(
        border: Border.all(color: HexColor(ThemP.getcolor())),
        borderRadius: BorderRadius.circular(15.0),

      ),
    width: MediaQuery
        .of(context)
        .size
        .width /
    4.5,
    height:
    MediaQuery
        .of(context)
        .size
        .width /
    4.5,
    child: Column(
    children: [
    Spacer(),
      SvgPicture.asset("assets/Checkup.svg",color: HexColor(ThemP.getcolor()),
        height: 50 * unitHeightValue,
        width: 50 * unitHeightValue,
      ),
    Spacer(),
    ],
    ),
    ),
      SizedBox(
        height: 5,
      ),
    Text(
    LanguageProvider.Llanguage("examination"),

        style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
            color: HexColor(ThemP.getcolor()),
            fontSize: 13 * unitHeightValue,
            fontWeight: FontWeight.w700
        )



    ),
    ],
    ),
    ),
    Spacer(),
      GestureDetector(
        onTap: () async {


         // if(homeP.getvisitNo().toString()!='0')
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DrugInHOSPITAL()),);
      /*    else
            showDialog(
              context: context,
              builder: (context) =>
              new AlertDialog(
                title: new Text(LanguageProvider.Llanguage('note')),
                content: Text(LanguageProvider.Llanguage('selectvisitno')),
                actions: <Widget>[],
              ),
            );*/


},
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  border: Border.all(color: HexColor(ThemP.getcolor())),
                  borderRadius: BorderRadius.circular(15.0),

                ),
                width: MediaQuery
                    .of(context)
                    .size
                    .width /
                    4.5,
                height:
                MediaQuery
                    .of(context)
                    .size
                    .width /
                    4.5,
                child: Column(
                  children: [
                    Spacer(),
                    SvgPicture.asset("assets/Medical_In.svg",color: HexColor(ThemP.getcolor()),
                      height: 50 * unitHeightValue,
                      width: 50 * unitHeightValue,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            SizedBox(
              height: 5,
            ),
            Text(
                LanguageProvider.Llanguage("drugH"),

                style: ArabicTextStyle(
                    arabicFont: ArabicFont.tajawal,
                    color: HexColor(ThemP.getcolor()),
                    fontSize: 13 * unitHeightValue,
                    fontWeight: FontWeight.w700
                )



            ),
          ],
        ),
      ),

      Spacer(),

      GestureDetector(
        onTap: () async {


        //  if(homeP.getvisitNo().toString()!='0')
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MedicalReportTList()),);
         /* else
            showDialog(
              context: context,
              builder: (context) =>
              new AlertDialog(
                title: new Text(LanguageProvider.Llanguage('note')),
                content: Text(LanguageProvider.Llanguage('selectvisitno')),
                actions: <Widget>[],
              ),
            );*/



         },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: HexColor(ThemP.getcolor())),
                borderRadius: BorderRadius.circular(15.0),

              ),
              width: MediaQuery
                  .of(context)
                  .size
                  .width /
                  4.5,
              height:
              MediaQuery
                  .of(context)
                  .size
                  .width /
                  4.5,
              child: Column(
                children: [
                  Spacer(),
                  SvgPicture.asset("assets/medicalreport.svg",color: HexColor(ThemP.getcolor()),
                    height: 50 * unitHeightValue,
                    width: 50 * unitHeightValue,
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
                LanguageProvider.Llanguage("medicalreport"),

                style: ArabicTextStyle(
                    arabicFont: ArabicFont.tajawal,
                    color: HexColor(ThemP.getcolor()),
                    fontSize: 13 * unitHeightValue,
                    fontWeight: FontWeight.w700
                )



            ),
          ],
        ),
      ),



    ],
    ),
    SizedBox(
    height: 40,
    ),



    Row(
    children: [
    Container(
    alignment: Alignment.topLeft,
    child: Text(
    LanguageProvider.Llanguage("Top"),
    style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
    color: HexColor(Globalvireables.black2),
    fontSize: 20 * unitHeightValue,
    fontWeight: FontWeight.w700),
    ),
    ),
    Spacer(),
    GestureDetector(
    onTap: () async {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => Doctors()),
    );
    },
    child: Container(
      color: Colors.transparent,
      alignment: Alignment.topLeft,
    child: Text(
    LanguageProvider.Llanguage("SeeAll"),
    style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
    color: HexColor(Globalvireables.grey),
    fontSize: 16 * unitHeightValue,
    ),
    ),
    ),
    ),
    ],
    ),







    SizedBox(
    height: 10,
    ),
    Container(
      color: Colors.transparent,
      child: SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width / 1.1,
      height: MediaQuery
          .of(context)
          .size
          .width / 2,
      child: FutureBuilder(
      future: getDoctors(context),
      builder: (BuildContext context,
      AsyncSnapshot<List<Doctor>> snapshot) {
      if (snapshot.hasData) {
      List<Doctor>? Doctors = snapshot.data;
      return Container(
        color: Colors.transparent,
        child: ListView(
        children: Doctors!
            .map((Doctor Doctor) =>
        Container(
          color: Colors.transparent,
          child: SizedBox(
          child: Card(
          shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(30),
          // if you need this
          side: BorderSide(
          width:
          MediaQuery
              .of(context)
              .size
              .height,
          //  color: HexColor(ThemP.getcolor())12.withOpacity(0.1),
          ),
          ),
          child: LanguageProvider
              .getLanguage() ==
          "EN"
          ? Row(
          children: [
          Image.asset(
          "assets/doctor2.png",
          height: 90 *
          unitHeightValue,
          width: 90 *
          unitHeightValue,
          ),
          Spacer(),
          Container(
            color: Colors.transparent,
            margin:
          EdgeInsets.all(
          10),
          child: Column(
          children: [
          Center(
          child: Text(
          Doctor
              .firsT_NAME_A
              .toString() +
          " " +
          Doctor
              .fatheR_NAME_A
              .toString() +
          " " +
          Doctor
              .lasT_NAME_A
              .toString(),
          style: ArabicTextStyle(
                  arabicFont: ArabicFont.tajawal,
          fontSize:
          16 *
          unitHeightValue,
          fontWeight:
          FontWeight
              .w700,
          color: Colors
              .black87),
          ),
          ),
          Center(
          child: Text(
          Doctor
              .depName
              .toString(),
          style: ArabicTextStyle(
                  arabicFont: ArabicFont.tajawal,
          fontSize:
          14 *
          unitHeightValue),
          ),
          ),
          ],
          ),
          ),
          Spacer(),
          ],
          )
              : Row(
          children: [
          Spacer(),
          Container(
          margin:
          EdgeInsets.all(
          10),
          child: Column(
          children: [
          Center(
          child: Text(
          Doctor
              .firsT_NAME_A
              .toString() +
          " " +
          Doctor
              .fatheR_NAME_A
              .toString() +
          " " +
          Doctor
              .lasT_NAME_A
              .toString(),
          style: ArabicTextStyle(
                  arabicFont: ArabicFont.tajawal,
          fontSize:
          16 *
          unitHeightValue,
          fontWeight:
          FontWeight
              .w700,
          color: Colors
              .black87),
          ),
          ),
          Center(
          child: Text(
          Doctor
              .depName
              .toString(),
          style: ArabicTextStyle(
                  arabicFont: ArabicFont.tajawal,
          fontSize:
          14 *
          unitHeightValue),
          ),
          ),
          ],
          ),
          ),
          Spacer(),


          Padding(
          padding: const EdgeInsets.only(left: 9.0),
          child: Container(
          child: Image.asset(
          "assets/doctor2.png",
          height: 90 *
          unitHeightValue,
          width: 90 *
          unitHeightValue,
          )),
          ),
          ],
          ))),
        ))
            .toList(),
        ),
      );
      } else {
      return Center(
      child: CircularProgressIndicator());
      }
      },
      ),
      ),
    ),





    ],
    ),
    ),
    ),
    ),
    ),
    ),
    ))
    ,
    ]
    );
  }


  Future<List<Doctor>> getDoctors(BuildContext context) async {

    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var ip= Loginprovider.getFirebaseIp().toString();


    var LanguageProvider = Provider.of<Language>(context, listen: false);
    Uri postsURL =
    Uri.parse(ip+Globalvireables.DoctorsURL);
    try {
      var map = new Map<String, dynamic>();
      map['lan'] = LanguageProvider.getLanguage();
      map['search'] = "all";

      http.Response res = await http.post(
        postsURL,
        body: map,

      );

      if (res.statusCode == 200) {
        print("Doctors" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<Doctor> Doctors = body
            .map(
              (dynamic item) => Doctor.fromJson(item),
        )
            .toList();

        return Doctors;
      } else {
        throw "Unable to retrieve Doctors.";
      }
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) =>
        new AlertDialog(
          title: new Text('بيانات الأطباء'),
          content: Text(e.toString()),
          actions: <Widget>[],
        ),
      );
    }

    throw "Unable to retrieve Doctors.";
  }
  Future<List<VisitsM>> getvisits(BuildContext context, String p) async {

    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var ip= Loginprovider.getFirebaseIp().toString();


    var LanguageProvider = Provider.of<Language>(context, listen: false);
    Uri postsURL = Uri.parse(ip+Globalvireables.VisitsApi);
    try {
      var map = new Map<String, dynamic>();
      map['patientNo'] = p;
      http.Response res = await http.post(
        postsURL,
        body: map,
      );

      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);



        print(body.toString());

        List<VisitsM> visits = body
            .map(
              (dynamic item) => VisitsM.fromJson(item),
        )
            .toList();

        return visits;
      } else {
        throw "Unable to retrieve Doctors.";
      }
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) =>
        new AlertDialog(
          title: new Text('بيانات الزيارت'),
          content: Text(e.toString()),
          actions: <Widget>[],
        ),
      );
    }

    throw "Unable to retrieve Doctors.";
  }
  _onItemTapped(int index) {


    if(index != 1){
    setState(() {
      selectedIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nav[index]),
      );
    });}
  }
  int selectedIndex = 1;
  final List<Widget> nav = [
    Settings(),
    Home(),
    profile(),
  ];
  changepass(BuildContext c) async {
  var prefs = await SharedPreferences.getInstance();
if(prefs.getString('changepass')==null || prefs.getString('changepass')!='yes'){
  showLoaderDialog(c);
}
}










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
            height: 200,
            child: Column(
              children: <Widget> [
SizedBox(height: 20,),
                Center(
                  child: Text(
                    Provider.of<Language>(context, listen: false).Llanguage("Gangepasswor"),
                    style: ArabicTextStyle(
                        arabicFont: ArabicFont.tajawal,
                        fontSize: 17.5 * (MediaQuery
                            .of(context)
                            .size
                            .height * 0.00122),
                        color: HexColor(Globalvireables.black),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 20,),

                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    Provider.of<Language>(context, listen: false).Llanguage("Gangepasswormost"),
                    style: ArabicTextStyle(
                        arabicFont: ArabicFont.tajawal,
                        fontSize: 14 * (MediaQuery
                            .of(context)
                            .size
                            .height * 0.00122),
                        color: HexColor(Globalvireables.black),
                        fontWeight: FontWeight.w500),
                  ),
                ),

                Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 40,
                    width:
                    MediaQuery.of(context).size.width / 3,
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    color: HexColor(Globalvireables.white),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: HexColor(Provider.of<Them>(context, listen: false).getcolor()),
                      ),
                      child: Text(
                        Provider.of<Language>(context, listen: false).Llanguage('gochange'),
                        style: ArabicTextStyle(
                            arabicFont: ArabicFont.tajawal,
                            color:
                            HexColor(Globalvireables.white),
                            fontSize: 14 * (MediaQuery
                                .of(context)
                                .size
                                .height * 0.00122)),
                      ),
                      onPressed: () async {

                        Navigator.of(context).pop();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePass()),
                        );

                      },
                    ),
                  ),
                ),
                SizedBox(height: 20,),


              ],
            ),
          );
        });

   /* AlertDialog alert = AlertDialog(

      content: Container(
        height: 200,
        child: Column(
          children: [

            Center(
              child: Text(
                Provider.of<Language>(context, listen: false).Llanguage("Gangepasswor"),
                style: ArabicTextStyle(
                    arabicFont: ArabicFont.tajawal,
                    fontSize: 17.5 * (MediaQuery
                        .of(context)
                        .size
                        .height * 0.00122),
                    color: HexColor(Globalvireables.black),
                    fontWeight: FontWeight.w500),
              ),
            ),
SizedBox(height: 20,),

            Center(
              child: Text(
                textAlign: TextAlign.center,
                Provider.of<Language>(context, listen: false).Llanguage("Gangepasswormost"),
                style: ArabicTextStyle(
                    arabicFont: ArabicFont.tajawal,
                    fontSize: 14 * (MediaQuery
                        .of(context)
                        .size
                        .height * 0.00122),
                    color: HexColor(Globalvireables.black),
                    fontWeight: FontWeight.w500),
              ),
            ),

Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 40,
                width:
                MediaQuery.of(context).size.width / 3,
                margin: EdgeInsets.only(top: 10, bottom: 5),
                color: HexColor(Globalvireables.white),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: HexColor(Globalvireables.basecolor),
                  ),
                  child: Text(
                    Provider.of<Language>(context, listen: false).Llanguage('gochange'),
                    style: ArabicTextStyle(
                        arabicFont: ArabicFont.tajawal,
                        color:
                        HexColor(Globalvireables.white),
                        fontSize: 14 * (MediaQuery
                            .of(context)
                            .size
                            .height * 0.00122)),
                  ),
                  onPressed: () async {

                    Navigator.of(context).pop();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePass()),
                    );

                  },
                ),
              ),
            )


          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );*/
  }



  showProfile(BuildContext context) {

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,

        context: context,
        builder: (context) {
          return SizedBox(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.15,

              child: SafeArea(
                child: Container(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/1.24,
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [

                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.1,
                            height: MediaQuery.of(context).size.height / 1.2,
                            child: FutureBuilder(
                              future: getProfile(context,Provider.of<LoginProvider>(context, listen: false).userId),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<ProfileM>> snapshot) {
                                if (snapshot.hasData) {
                                  List<ProfileM>? Doctors = snapshot.data;
                                  return   ListView(
                                    children: Doctors!
                                        .map((ProfileM Doctor) => SizedBox(
                                        child: Column(children: [
                                          Doctor.gender=='1'? Container(
                                            width: 120 * (MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.00122),
                                            height: 120 * (MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.00122),
                                            child: Image.asset(
                                              "assets/persion2.png",
                                              height: 120,
                                              width: 120,
                                            ),
                                          ):
                                          Container(
                                            width: 120 * (MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.00122),
                                            height: 120 * (MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.00122),
                                            child: Image.asset(
                                              "assets/girl.png",
                                              height: 120,
                                              width: 120,
                                            ),
                                          ),

                                          SizedBox(height: 20,),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width/1.2,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                // if you need this
                                                side: BorderSide(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  //  color: HexColor(ThemP.getcolor())12.withOpacity(0.1),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Icon(
                                                      Icons.person,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width/1.7,

                                                    child: Padding(
                                                      padding: const EdgeInsets.all(10),
                                                      child: Center(child: Text(Doctor.fulLANAME.toString(),
                                                        style: ArabicTextStyle(
                                                            arabicFont: ArabicFont.tajawal,
                                                            color: HexColor(Globalvireables.black2),
                                                            fontSize: 18 * (MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.00122),
                                                            fontWeight: FontWeight.w700),
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width/1.2,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                // if you need this
                                                side: BorderSide(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  //  color: HexColor(ThemP.getcolor())12.withOpacity(0.1),
                                                ),
                                              ),

                                              child:     SizedBox(
                                                width: MediaQuery.of(context).size.width/1.6,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10),
                                                      child: Icon(
                                                        Icons.person,
                                                      ),
                                                    ),

                                                    Padding(
                                                      padding: const EdgeInsets.all(10),
                                                      child: SizedBox(
                                                        width: MediaQuery.of(context).size.width/1.7
                                                        ,
                                                        child: Center(child: Text(Doctor.fulLENAME.toString(),

                                                          maxLines: 3,
                                                          overflow: TextOverflow.ellipsis,

                                                          style: ArabicTextStyle(
                                                              arabicFont: ArabicFont.tajawal,
                                                              color: HexColor(Globalvireables.black2),
                                                              fontSize: 18 * ( MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.00122),
                                                              fontWeight: FontWeight.w700),
                                                        )),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),



                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width/1.2,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                // if you need this
                                                side: BorderSide(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  //  color: HexColor(ThemP.getcolor())12.withOpacity(0.1),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Icon(
                                                      Icons.phone,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Center(child: Text(Doctor.mobilENO.toString(),
                                                      style: ArabicTextStyle(
                                                          arabicFont: ArabicFont.tajawal,
                                                          color: HexColor(Globalvireables.black2),
                                                          fontSize: 18 * (MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.00122),
                                                          fontWeight: FontWeight.w700),
                                                    )),
                                                  ),
                                                ],
                                              ),

                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width/1.2,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                // if you need this
                                                side: BorderSide(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  //  color: HexColor(ThemP.getcolor())12.withOpacity(0.1),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Icon(
                                                      Icons.child_friendly_rounded,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Center(child: Text(Doctor.bdate.toString().substring(0,10),
                                                      style: ArabicTextStyle(
                                                          arabicFont: ArabicFont.tajawal,
                                                          color: HexColor(Globalvireables.black2),
                                                          fontSize: 18 * (MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.00122),
                                                          fontWeight: FontWeight.w700),
                                                    )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width/1.2,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                // if you need this
                                                side: BorderSide(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  //  color: HexColor(ThemP.getcolor())12.withOpacity(0.1),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Icon(
                                                      Icons.girl_sharp,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Center(child: Text(Doctor.gender.toString()=='1'?'ذكر':'أنثى',
                                                      style: ArabicTextStyle(
                                                          arabicFont: ArabicFont.tajawal,
                                                          color: HexColor(Globalvireables.black2),
                                                          fontSize: 18 * (MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.00122),
                                                          fontWeight: FontWeight.w700),
                                                    )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),


                                          SizedBox(height: 240,),
                                          Text("Version 1.0 - Galaxy Group")


                                        ],)))
                                        .toList(),
                                  );
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            ),
                          ),
                          // getProfile();

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });

  }


  Future<List<ProfileM>> getProfile(BuildContext context,String patientNo) async {

    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var ip= Loginprovider.getFirebaseIp().toString();


    Uri postsURL =
    Uri.parse(ip+Globalvireables.profileURL);
    try {
      var map = new Map<String, dynamic>();
      map['PatientNo'] = patientNo;

      http.Response res = await http.post(
        postsURL,
        body: map,

      );

      if (res.statusCode == 200) {
        print("Profile" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<ProfileM> Doctors = body
            .map(
              (dynamic item) => ProfileM.fromJson(item),
        )
            .toList();

        return Doctors;
      } else {
        throw "Unable to retrieve Profile.";
      }
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) =>
        new AlertDialog(
          title: new Text('بيانات المريض'),
          content: Text(e.toString()),
          actions: <Widget>[],
        ),
      );
    }

    throw "Unable to retrieve Profile.";
  }

  String gettypevisit(String string) {
  var vname=string;
  if(vname=='1'){
    vname='طوارئ';
  }else if(vname=='2'){
    vname='كلى';
  }if(vname=='3'){
    vname='خارجي';
  }if(vname=='4'){
    vname='داخلي';
  }


  return "زيارة " +vname;


  }




  Stream<String> getnotificationsCount() async* {
    Uri postsURL = Uri.parse(Globalvireables.NotificationURL); // Fix the typo in GlobalVariables
    print(Globalvireables.HospitalInfoURL.toString()); // Fix the typo in GlobalVariables
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    var map = <String, dynamic>{};
    map['PatientNo'] = Loginprovider.getuserId().toString();
    map['NotificationType'] = 'screen';
    try {
      final http.Response res = await http.post(
        postsURL,
        body: map,
      );

      if (res.statusCode == 200) {
        print("Doctors: " + res.body.toString());

        final List<dynamic> body = jsonDecode(res.body);

        print(res.body.toString() + "screenscreen");

        final List<NotificationsM> HINFO = body
            .map(
              (dynamic item) => NotificationsM.fromJson(item),
        )
            .toList();

        int count = HINFO.length; // Calculate the count directly

        print("count: " + count.toString());

        yield count.toString();
      } else {
        throw "Unable to retrieve Doctors. orrr";
      }
    } catch (e) {
      print("Error: " + e.toString());
    }
  }




}
