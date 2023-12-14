import 'dart:convert';

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hismobileapp/provider/LoginProvider.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';

import '../Models/ChangePassM.dart';
import '../Models/ProfileM.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'Settings.dart';
import 'package:http/http.dart' as http;

class profile extends StatefulWidget {
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var ThemP = Provider.of<Them>(context, listen: false);

    var colors = [HexColor((Globalvireables.secondcolor)), HexColor((ThemP.getcolor()))];
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var stops = [ 0.0, 1.00];
    var LanguageProvider = Provider.of<Language>(context, listen: false);
   var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

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
            title: Widgets.Appbar(context,LanguageProvider.Llanguage('profile')
           ,unitHeightValue,LanguageProvider.langg,LanguageProvider.getDirection()),
         ),
          backgroundColor: HexColor(ThemP.getcolor()),
          // backgroundColor: Colors.transparent,

          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/1.15,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  HexColor((Globalvireables.secondcolor)), HexColor((ThemP.getcolor()))
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
                  height: MediaQuery.of(context).size.height/1.24,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.cover,),
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
                          future: getProfile(context,Loginprovider.getuserId()),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<ProfileM>> snapshot) {
                            if (snapshot.hasData) {
                              List<ProfileM>? Doctors = snapshot.data;
                              return   Container(margin: EdgeInsets.only(bottom: 16),
                                child: ListView(
                                  children: Doctors!
                                      .map((ProfileM Doctor) => SizedBox(
                                      child: Column(children: [
                                        Doctor.gender=='1'? Container(
                                          width: 120 * unitHeightValue,
                                          height: 120 * unitHeightValue,
                                          child: Image.asset(
                                            "assets/persion2.png",
                                            height: 120,
                                            width: 120,
                                          ),
                                        ):
                                        Container(
                                          width: 120 * unitHeightValue,
                                          height: 120 * unitHeightValue,
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
                                              //  color: Colors.black12.withOpacity(0.1),
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
                                                      fontSize: 18 * unitHeightValue,
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
                                                //  color: Colors.black12.withOpacity(0.1),
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
                                                              fontSize: 18 * unitHeightValue,
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
                                                //  color: Colors.black12.withOpacity(0.1),
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
                                                        fontSize: 18 * unitHeightValue,
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
                                                //  color: Colors.black12.withOpacity(0.1),
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
                                                  child: Center(child: Text(Doctor.gender.toString()=='1'?(LanguageProvider.getLanguage()=='AR'?'ذكر':'Male')
                                                      :(LanguageProvider.getLanguage()=='AR'?'أنثى':'female'),
                                                    style: ArabicTextStyle(
                                                        arabicFont: ArabicFont.tajawal,
                                                        color: HexColor(Globalvireables.black2),
                                                        fontSize: 18 * unitHeightValue,
                                                        fontWeight: FontWeight.w700),
                                                  )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        GestureDetector(
                                          onTap: (){

                                            showModalBottomSheet(

                                                context: context,

                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.vertical(
                                                    top: Radius.circular(20),
                                                  ),
                                                ),
                                                clipBehavior: Clip.antiAliasWithSaveLayer,


                                                builder: (context) {
                                                  return Padding(
                                                    padding: const EdgeInsets.all(20),
                                                    child: SizedBox(
                                                      child: Column(children: [
                                                        TextField(
                                                          controller: _phoneController,
                                                          decoration: InputDecoration(
                                                            prefixIcon: Icon(Icons.phone,color: HexColor(ThemP.getcolor())),
                                                            border: OutlineInputBorder(),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: HexColor(
                                                                        Globalvireables.black),
                                                                    width: 0.0),
                                                                borderRadius:
                                                                BorderRadius.circular(10.0)),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: HexColor(
                                                                        ThemP.getcolor()),
                                                                    width: 1.0),
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
                                                                "phone"),
                                                          ),
                                                        ),


                                                        Align(
                                                          alignment: Alignment.bottomCenter,
                                                          child: Container(
                                                            height: 50,
                                                            width:
                                                            MediaQuery.of(context).size.width / 1.2,
                                                            margin: EdgeInsets.only(top: 40, bottom: 5),
                                                            color: HexColor(Globalvireables.white),
                                                            child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                primary:
                                                                HexColor(ThemP.getcolor()),
                                                              ),
                                                              child: Text(
                                                                LanguageProvider.Llanguage('update'),
                                                                style: ArabicTextStyle(
                                                                    arabicFont: ArabicFont.tajawal,
                                                                    color:
                                                                    HexColor(Globalvireables.white),
                                                                    fontSize: 13 * unitHeightValue),
                                                              ),
                                                              onPressed: () async {
                                                                UpdateInformationTel(context,Loginprovider.getuserId(),_phoneController.text);

                                                              },
                                                            ),
                                                          ),
                                                        )


                                                      ],),


                                                    ),
                                                  );});

                                          },
                                          child: SizedBox(
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
                                                  //  color: Colors.black12.withOpacity(0.1),
                                                ),
                                              ),
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width/1.7,

                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10),
                                                      child: Icon(
                                                        Icons.phone,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width/1.9,

                                                      child: Padding(
                                                        padding: const EdgeInsets.all(10),
                                                      child: Text(Doctor.mobilENO.toString(),
                                                          maxLines: 3,
                                                          overflow: TextOverflow.ellipsis,

                                                          style: ArabicTextStyle(
                                                              arabicFont: ArabicFont.tajawal,
                                                              color: HexColor(Globalvireables.black2),
                                                              fontSize: 18 * unitHeightValue,
                                                              fontWeight: FontWeight.w700),
                                                        ),
                                                      ),
                                                    ),

Spacer(),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Icon(
                                                        Icons.edit,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),

                                            ),
                                          ),
                                        ),

                                        GestureDetector(
                                          onTap: (){

                                            showModalBottomSheet(

                                                context: context,

                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.vertical(
                                                    top: Radius.circular(20),
                                                  ),
                                                ),
                                                clipBehavior: Clip.antiAliasWithSaveLayer,


                                                builder: (context) {
                                                  return Padding(
                                                    padding: const EdgeInsets.all(20),
                                                    child: SizedBox(
                                                      child: Column(children: [
                                                        TextField(
                                                          controller: _emailController,
                                                          decoration: InputDecoration(
                                                            prefixIcon: Icon(Icons.email,color: HexColor(ThemP.getcolor())),
                                                            border: OutlineInputBorder(),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: HexColor(
                                                                        Globalvireables.black),
                                                                    width: 0.0),
                                                                borderRadius:
                                                                BorderRadius.circular(10.0)),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: HexColor(
                                                                        ThemP.getcolor()),
                                                                    width: 1.0),
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
                                                                "email"),
                                                          ),
                                                        ),


                                                        Align(
                                                          alignment: Alignment.bottomCenter,
                                                          child: Container(
                                                            height: 50,
                                                            width:
                                                            MediaQuery.of(context).size.width / 1.2,
                                                            margin: EdgeInsets.only(top: 40, bottom: 5),
                                                            color: HexColor(Globalvireables.white),
                                                            child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                primary:
                                                                HexColor(ThemP.getcolor()),
                                                              ),
                                                              child: Text(
                                                                LanguageProvider.Llanguage('update'),
                                                                style: ArabicTextStyle(
                                                                    arabicFont: ArabicFont.tajawal,
                                                                    color:
                                                                    HexColor(Globalvireables.white),
                                                                    fontSize: 13 * unitHeightValue),
                                                              ),
                                                              onPressed: () async {
                                                                UpdateInformationEmail(context,Loginprovider.getuserId(),_emailController.text);
                                                              },
                                                            ),
                                                          ),
                                                        )


                                                      ],),


                                                    ),
                                                  );});

                                          },
                                          child: SizedBox(
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
                                                  //  color: Colors.black12.withOpacity(0.1),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Icon(
                                                      Icons.email,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width/1.8,

                                                    child: Padding(
                                                      padding: const EdgeInsets.all(10),
                                                     child: Text(Doctor.email.toString().length<5?'- - - - - - - -':Doctor.email.toString(),
                                                        style: ArabicTextStyle(
                                                            arabicFont: ArabicFont.tajawal,
                                                            color: HexColor(Globalvireables.black2),
                                                            fontSize: 18 * unitHeightValue,
                                                            fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),
Spacer(),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Icon(
                                                      Icons.edit,
                                                    ),
                                                     )

                                                ],
                                              ),

                                            ),
                                          ),
                                        ),

                                        SizedBox(height: 240,),
                                        Text("Version 1.0 - Galaxy Group")


                                      ],)))
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
                      // getProfile();

                     ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    ]);
  }
  _onItemTapped(int index) {
    if(index != 2){
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

  UpdateInformationTel(BuildContext context,String patientNo
      ,String tel) async {


    print("userid :"+patientNo.toString());

    var LanguageProvider = Provider.of<Language>(context, listen: false);

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(LanguageProvider.getLanguage()=="AR"?'تحديث البيانات':'Updating'),
          content: Text(LanguageProvider.getLanguage()=="AR"?'جار تحديث البيانات ...':'Updating...'),
        ));

    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var ip= Loginprovider.getFirebaseIp().toString();


    Uri postsURL =
    Uri.parse(ip+Globalvireables.UpdateInformationURL);
    try {
      var map = new Map<String, dynamic>();
      map['PatientNo'] = patientNo;
      map['tel'] = tel;
      map['email'] = 'null';

      http.Response res = await http.post(
        postsURL,
        body: map,

      ).whenComplete(() => Navigator.pop(context));

      if (res.statusCode == 200) {
        print("UpdateInformation" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<ChangePassM> Doctors = body
            .map(
              (dynamic item) => ChangePassM.fromJson(item),
        )
            .toList();


        if(Doctors[0].response=='1S'){

          var prefs = await SharedPreferences.getInstance();

          prefs.setString('UpdateInformation','yes');

          Navigator.pop(context);
          await showDialog(
            context: context,
            builder: (context) =>
            new AlertDialog(
              title: new Text(LanguageProvider.Llanguage('update')),
              content: Text(LanguageProvider.Llanguage('doneupdte')),
            ),
          );

        }else{
          Navigator.pop(context);
          await showDialog(
            context: context,
            builder: (context) =>
            new AlertDialog(
              title: new Text(LanguageProvider.Llanguage('anerrortitle')),
              content: Text(LanguageProvider.Llanguage('anerror')),     actions: <Widget>[],
            ),
          );
        }


      } else {
        Navigator.pop(context);

        new AlertDialog(
          title: new Text(LanguageProvider.Llanguage('anerrortitle')),
          content: Text(LanguageProvider.Llanguage('anerror')),   actions: <Widget>[],
        );
      }
    } catch (e) {
      Navigator.pop(context);

      await showDialog(
        context: context,
        builder: (context) =>
        new AlertDialog(
          title: new Text(LanguageProvider.Llanguage('anerrortitle')),
          content: Text(LanguageProvider.Llanguage('anerror')),      actions: <Widget>[],
        ),
      );
    }

  }


  UpdateInformationEmail(BuildContext context,String patientNo
  ,String email) async {


    print("userid :"+patientNo.toString());

    var LanguageProvider = Provider.of<Language>(context, listen: false);

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(LanguageProvider.getLanguage()=="AR"?'تحديث البيانات':'Updating'),
          content: Text(LanguageProvider.getLanguage()=="AR"?'جار تحديث البيانات ...':'Updating...'),
        ));

    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var ip= Loginprovider.getFirebaseIp().toString();


    Uri postsURL =
    Uri.parse(ip+Globalvireables.UpdateInformationURL);
    try {
      var map = new Map<String, dynamic>();
      map['PatientNo'] = patientNo;
      map['email'] = email;
      map['tel'] = 'null';

      http.Response res = await http.post(
        postsURL,
        body: map,

      ).whenComplete(() => Navigator.pop(context));

      if (res.statusCode == 200) {
        print("UpdateInformation" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<ChangePassM> Doctors = body
            .map(
              (dynamic item) => ChangePassM.fromJson(item),
        )
            .toList();


        if(Doctors[0].response=='1S'){

          var prefs = await SharedPreferences.getInstance();

          prefs.setString('UpdateInformation','yes');

          Navigator.pop(context);
          await showDialog(
            context: context,
            builder: (context) =>
            new AlertDialog(
              title: new Text(LanguageProvider.Llanguage('update')),
              content: Text(LanguageProvider.Llanguage('doneupdte')),     ),
          );

        }else{
          Navigator.pop(context);
          await showDialog(
            context: context,
            builder: (context) =>
            new AlertDialog(
              title: new Text(LanguageProvider.Llanguage('anerrortitle')),
              content: Text(LanguageProvider.Llanguage('anerror')),     actions: <Widget>[],
            ),
          );
        }


      } else {
        Navigator.pop(context);

        new AlertDialog(
          title: new Text(LanguageProvider.Llanguage('anerrortitle')),
          content: Text(LanguageProvider.Llanguage('anerror')),         actions: <Widget>[],
        );
      }
    } catch (e) {
      Navigator.pop(context);

      await showDialog(
        context: context,
        builder: (context) =>
        new AlertDialog(
          title: new Text(LanguageProvider.Llanguage('anerrortitle')),
          content: Text(LanguageProvider.Llanguage('anerror')),          actions: <Widget>[],
        ),
      );
    }

  }



  Future<List<ProfileM>> getProfile(BuildContext context,String patientNo) async {

    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var ip= Loginprovider.getFirebaseIp().toString();



    Uri postsURL =
    Uri.parse(ip+Globalvireables.profileURL);
    try {

      print("patientNo" + patientNo.toString());


      var map = new Map<String, dynamic>();
      map['PatientNo'] = Loginprovider.getuserId();
      http.Response res = await http.post(
        postsURL,
        body: map,

      );

      print("Profileinput" + map.toString());


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

}
