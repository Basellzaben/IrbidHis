import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hismobileapp/UI/profile.dart';
import 'package:local_auth/local_auth.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:arabic_font/arabic_font.dart';
import '../Models/VitalSignsM.dart';
import '../Models/VitalSignsM.dart';
import '../provider/HomeProvider.dart';
import '../provider/LoginProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'Settings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class VitalSigns extends StatefulWidget {
  @override
  State<VitalSigns> createState() => _VitalSignsState();
}

class _VitalSignsState extends State<VitalSigns> {
  @override
  void initState() {
   // setsearch(context);
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
  TextEditingController dateinput = TextEditingController();
  setsearch(BuildContext context){

    var homeP = Provider.of<HomeProvider>(context, listen: false);
    if(homeP.getVisitDate().toString().length==10)
    dateinput.text=homeP.getVisitDate();
  }
  @override
  Widget build(BuildContext context) {
    var ThemP = Provider.of<Them>(context, listen: false);

    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var stops = [0.0, 1.00];
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
          appBar: AppBar( backgroundColor: Colors.white,
            bottomOpacity: 800.0,
            elevation: 4.0,
            title: Widgets.Appbar(
                context,
                LanguageProvider.Llanguage("Vitalsigns"),

                unitHeightValue,
                LanguageProvider.langg,
                LanguageProvider.getDirection()),
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
                        bottomRight: Radius.circular(29.0),
                        topLeft: Radius.circular(0.0),
                        bottomLeft: Radius.circular(29.0)),
                  ),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          child: TextField(
                            controller: dateinput, //editing controller of this TextField
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.date_range,color: HexColor(
                                  ThemP.getcolor()),size: 27*unitHeightValue,),
                              suffixIcon: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      dateinput.text=LanguageProvider.Llanguage('SearchbyDate');
                                    });
                                   },
                                  child: Icon(color: Colors.redAccent,dateinput.text.isEmpty||dateinput.text.toString()==LanguageProvider.Llanguage('SearchbyDate')
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
                                  "SearchbyDate"),
                            ),
                            readOnly: true,  //set it true, so that user will not able to edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context, initialDate: DateTime.now(),
                                  firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101)
                              );

                              if(pickedDate != null ){
                                print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(formattedDate); //formatted date output using intl package =>  2021-03-16

                                setState(() {
                                  dateinput.text = formattedDate; //set output date to TextField value.
                                });
                              }else{
                                print("Date is not selected");
                              }
                            },
                          ),
                        ),


                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {

                                return  AlertDialog(
                                    insetPadding: EdgeInsets.zero,
                                    content: Directionality(
                                      textDirection: LanguageProvider.getDirectionPres(),
                                      child: RepaintBoundary(
                                        child: SingleChildScrollView(
                                          child: RepaintBoundary(
                                            child: Column(
                                              children: [

                                                RepaintBoundary(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(0.0),
                                                    child: Column(children: [

                                                      Center(
                                                        child: Text(
                                                          LanguageProvider.Llanguage('normallevel'),
                                                          style: ArabicTextStyle(
                                                              arabicFont: ArabicFont.tajawal,
                                                              color: Colors.black45,
                                                              fontSize: 15 * unitHeightValue),
                                                        ),
                                                      ),

                                                      Divider(thickness: 0.3, color: Colors.black),


                                                      Padding(
                                                        padding: EdgeInsets.only(left: 4,right: 4,top: 10),
                                                        child: Row(children: [
                                                          Container(
                                                              alignment: Alignment.center,
                                                              child: Text("اسم المؤشر",style: ArabicTextStyle(
                                                                  arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w600),)),
                                                          Spacer(),
                                                          Container(
                                                              alignment: Alignment.center,
                                                              child: Text("الحد الأعلى",style: ArabicTextStyle(
                                                                  arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w600),)),
                                                          Spacer(),
                                                          Container(
                                                              alignment: Alignment.center,
                                                              child: Text("الحد الادنى",style: ArabicTextStyle(
                                                                  arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w600),)),


                                                        ],),
                                                      ),







                                                      Padding(
                                                        padding: EdgeInsets.only(left: 4,right: 4,top: 10),
                                                        child: Row(children: [
                                                          Container(
                                                            width: MediaQuery.of(context).size.width/4,
                                                              alignment: Alignment.center,
                                                              child: Text("الضغط",style: ArabicTextStyle(
                                                                  arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black),)),
                                                          Spacer(),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width/4,
                                                              alignment: Alignment.center,
                                                              child: Text("129/84",style: ArabicTextStyle(
                                                                  arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black),)),
                                                          Spacer(),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width/4,
                                                              alignment: Alignment.center,
                                                              child: Text("120/80",style: ArabicTextStyle(
                                                                  arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black),)),


                                                        ],),
                                                      ),

                                                      Padding(
                                                        padding: EdgeInsets.only(left: 4,right: 4,top: 10),
                                                        child: Row(children: [
                                                          Container(
                                                              width: MediaQuery.of(context).size.width/4,
                                                              alignment: Alignment.center,
                                                              child: Text("معدل التنفس",style: ArabicTextStyle(
                                                                  arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black),)),
                                                          Spacer(),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width/4,
                                                              alignment: Alignment.center,
                                                              child: Text("16",style: ArabicTextStyle(
                                                                  arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black),)),
                                                          Spacer(),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width/4,
                                                              alignment: Alignment.center,
                                                              child: Text("12",style: ArabicTextStyle(
                                                                  arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black),)),


                                                        ],),
                                                      ),

                                                      Padding(
                                                        padding: EdgeInsets.only(left: 4,right: 4,top: 10),
                                                        child: Row(children: [
                                                          Container(
                                                              width: MediaQuery.of(context).size.width/4,
                                                              alignment: Alignment.center,
                                                              child: Text("نسبه الاكسجين",style: ArabicTextStyle(
                                                                  arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black),)),
                                                          Spacer(),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width/4,
                                                              alignment: Alignment.center,
                                                              child: Text("100%",style: ArabicTextStyle(
                                                                  arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black),)),
                                                          Spacer(),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width/4,
                                                              alignment: Alignment.center,
                                                              child: Text("95%",style: ArabicTextStyle(
                                                                  arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black),)),


                                                        ],),
                                                      ),



                                                      Padding(
                                                        padding: EdgeInsets.only(left: 4,right: 4,top: 10),
                                                        child: Row(children: [
                                                          Container(
                                                              width: MediaQuery.of(context).size.width/4,
                                                              alignment: Alignment.center,
                                                              child: Text("حراره الجسم",style: ArabicTextStyle(
                                                                  arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black),)),
                                                          Spacer(),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width/4,
                                                              alignment: Alignment.center,
                                                              child: Text("37.2",style: ArabicTextStyle(
                                                                  arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black),)),
                                                          Spacer(),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width/4,
                                                              alignment: Alignment.center,
                                                              child: Text("36.1",style: ArabicTextStyle(
                                                                  arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black),)),


                                                        ],),
                                                      ),



                                                      Padding(
                                                        padding: EdgeInsets.only(left: 4,right: 4,top: 10),
                                                        child: Row(children: [
                                                          Container(
                                                              width: MediaQuery.of(context).size.width/4,
                                                              alignment: Alignment.center,
                                                              child: Text("دقات القلب",style: ArabicTextStyle(
                                                                  arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black),)),
                                                          Spacer(),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width/4,
                                                              alignment: Alignment.center,
                                                              child: Text("100",style: ArabicTextStyle(
                                                                  arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black),)),
                                                          Spacer(),
                                                          Container(
                                                              width: MediaQuery.of(context).size.width/4,
                                                              alignment: Alignment.center,
                                                              child: Text("60",style: ArabicTextStyle(
                                                                  arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black),)),


                                                        ],),
                                                      ),


SizedBox(height: 30,),

                                                      Text(
                                                       'تنبيه : جميع النسب المذكورة تقريبية وتعتمد على عوامل كثيرة، لذا يجب عليك استشارة طبيبك للحصول على المعلومات',
                                                        style: ArabicTextStyle(
                                                            arabicFont: ArabicFont.tajawal,
                                                            color: Colors.black45,
                                                            fontSize: 15 * unitHeightValue),
                                                      ),

                                                      SizedBox(height: 30,),

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



                                                    ],),
                                                  ),
                                                ),


                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    actions: [


                                    ],
                                  );


                              },
                            );

                          },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15,bottom: 15),
                        child: Row(children: [

Spacer(),


                                   Text(
                                     LanguageProvider.Llanguage('normallevel'),
                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color: Colors.black45,
                                          fontSize: 15 * unitHeightValue),
                                    ),
SizedBox(width: 3,),
                          Icon(
                            Icons.info_outline_rounded,
                            color: Colors.black38,
                            size: 25.0,
                          ),

                        ],),
                      ),
                    ),


                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.1,
                          height: MediaQuery.of(context).size.height / 1.24,
                          child: FutureBuilder(
                            future: getVitalSigns(context, Loginprovider.getuserId(), dateinput.text.isEmpty||dateinput.text.toString()==LanguageProvider.Llanguage('SearchbyDate')?"202":dateinput.text),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<VitalSignsM>> snapshot) {
                              if (snapshot.hasData) {
                                List<VitalSignsM>? VitalSigns = snapshot.data;
                                return VitalSigns!.asMap().length>0  ? Container(margin: EdgeInsets.only(bottom: 80),
                                  child: ListView(
                                    children: VitalSigns!
                                        .map((VitalSignsM VitalSignsM) =>
                                    VitalSignsM.vITALSIGNSAllModelS!.isNotEmpty?

                                       Card(
                                        child: ExpansionTile(
                                        title:  Padding(
                                        padding: EdgeInsets.all(8.0),
                                    child:

                                    SizedBox(
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                  textAlign: TextAlign
                                                      .center,
                                                  retMonth( VitalSignsM.datee.toString()),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight
                                                          .w800,
                                                      height: 1)),
                                              Text(
                                                  textAlign: TextAlign
                                                      .center,
                                                  retYear( VitalSignsM.datee.toString()),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      height: 1)),
                                            ],

                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              color:Colors.black,
                                              height: 33,width: 1.8,),
                                          ),
                                          Text(
                                            retDay( VitalSignsM.datee.toString()),
                                            style: TextStyle(
                                                fontSize: 35,
                                                fontWeight: FontWeight
                                                    .w800,
                                                color: HexColor(
                                                    ThemP
                                                        .getcolor())),
                                          )

                                        ],),
                                    )

                                          /*Center(

                                        child: Text(
                                          retturndatenewformat(
                                              VitalSignsM.datee
                                                  .toString())+ " - " +VitalSignsM.vITALSIGNSAllModelS![0].reaDTIME.toString()
                                          ,
                                          style: ArabicTextStyle(
                                              arabicFont: ArabicFont.tajawal,
                                              color: HexColor(ThemP.getcolor()),
                                              fontSize: 20,
                                              fontWeight:
                                              FontWeight.w700),
                                        ))*/,
                                  ),

                                    children: [
                                    Padding(
                                    padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                              child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 0.0,
                              mainAxisSpacing: 0.0,
                              ),
                              itemCount: VitalSignsM.vITALSIGNSAllModelS!.asMap().length,
                              itemBuilder: (context, index) {
                              return Container(
                              color: Colors.transparent,
                              child: Column(
                              children: [
                              SizedBox(height: 15,),
                              CircularPercentIndicator(
                              radius: 50.0 *
                              unitHeightValue,
                              lineWidth: 10.0,
                              percent: 0.50,
                              progressColor:
                              present(VitalSignsM
                                  .vITALSIGNSAllModelS![
                              index]
                                  .desCA
                                  .toString()
                              ,VitalSignsM
                                  .vITALSIGNSAllModelS![
                              index]
                                  .vitaLSIGNREAD
                                  .toString()),
                              center: new Text(

                              VitalSignsM
                                  .vITALSIGNSAllModelS![
                              index]
                                  .vitaLSIGNREAD
                                  .toString(),
                              style: ArabicTextStyle(
                              arabicFont: ArabicFont.tajawal,
                              fontWeight:
                              FontWeight
                                  .w900,
                              fontSize: 18 *
                              unitHeightValue),
                              ),

                              ),
                              SizedBox(
                              height: 15,
                              ),
                              Expanded(
                              child: Text(
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              VitalSignsM.vITALSIGNSAllModelS![index]
                                  .desCA
                                  .toString(),
                              style: ArabicTextStyle(
                              arabicFont: ArabicFont.tajawal,
                              fontWeight:
                              FontWeight
                                  .w700,
                              fontSize: 16 *
                              unitHeightValue),
                              ),

                              ),

                                VitalSignsM.vITALSIGNSAllModelS![index]
                                    .desCA
                                    .toString()=="ضغط"?
                                Expanded(child: Text('129/84 -  120/80'+"الحد الطبيعي : ")):Container(),

                                VitalSignsM.vITALSIGNSAllModelS![index]
                                    .desCA
                                    .toString()=="حرارة"?
                                Expanded(child:Text("الحد الطبيعي : 37.2 - 36.1")):Container(),

                                VitalSignsM.vITALSIGNSAllModelS![index]
                                    .desCA
                                    .toString()=="النبض"?
                                Expanded(child:Text("الحد الطبيعي : 100 - 60")):Container(),
                                VitalSignsM.vITALSIGNSAllModelS![index]
                                    .desCA
                                    .toString()=="معدل الاكسجين"?
                                Expanded(child:Text("الحد الطبيعي : %100 - %60")):Container(),
                                VitalSignsM.vITALSIGNSAllModelS![index]
                                    .desCA
                                    .toString()=="سكري"?
                                Expanded(child:Text("الحد الطبيعي : 120 - 60")):Container()



                              ],
                              ),
                              );
                              },
                              ),
                              ),
                              ),
                                    ],
                                  ),
                                )





                                                /* SizedBox(
                                                    child: GridView.builder(
                                                      physics: ClampingScrollPhysics(),
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: snapshot.data!.length,
                                                      itemBuilder: (BuildContext context, int index) =>
                                                              Padding(
                                                        padding: EdgeInsets.all(2),
                                                        child: SizedBox(
                                                          child: Column(
                                                            children: [
                                                              CircularPercentIndicator(
                                                                radius: 50.0 *
                                                                    unitHeightValue,
                                                                lineWidth: 15.0,
                                                                percent: 0.50,
                                                                center: new Text(
                                                                  VitalSignsM
                                                                      .vITALSIGNSAllModelS![
                                                                          index]
                                                                      .vitaLSIGNREAD
                                                                      .toString(),
                                                                  style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize: 16 *
                                                                          unitHeightValue),
                                                                ),
                                                                progressColor: HexColor(
                                                                    Globalvireables
                                                                        .basecolor),
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Text(
                                                                VitalSignsM
                                                                    .vITALSIGNSAllModelS![
                                                                        index]
                                                                    .desCA
                                                                    .toString(),
                                                                style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize: 16 *
                                                                        unitHeightValue),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 5,
                                                      crossAxisSpacing: 5.0,
                                                      mainAxisSpacing: 5.0,
                                                    ),
                                                    ),
                                                  ),*/


                                        :SizedBox()
                                    )
                                        .toList(),
                                  ),
                                ):Image.asset(
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
          )),
    ]);
  }

  Future<List<VitalSignsM>> getVitalSigns(





      BuildContext context, String patientNo, String searchDate) async {
    var homeP = Provider.of<HomeProvider>(context, listen: false);


    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var ip= Loginprovider.getFirebaseIp().toString();

    print(" dateinput.text :"+ patientNo);

    Uri postsURL = Uri.parse(ip+Globalvireables.VitalSignsURL);
    try {
      var map = new Map<String, dynamic>();
      map['PatientNo'] = patientNo;
      map['searchDate'] = searchDate;
      map['vno'] = homeP.getvisitNo();
      map['VisitType'] = homeP.getvisittype();

      http.Response res = await http.post(
        postsURL,
        body: map,
      );

      if (res.statusCode == 200) {
        print("VitalSigns" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<VitalSignsM> VitalSignss = body
            .map(
              (dynamic item) => VitalSignsM.fromJson(item),
            )
            .toList();

        return VitalSignss;
      } else {
        throw "Unable to retrieve VitalSigns." + e.toString();
      }
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('بيانات الأطباء'),
          content: Text(e.toString()),
          actions: <Widget>[],
        ),
      );
    }

    throw "Unable to retrieve VitalSigns." + e.toString();
  }

  _onItemTapped(int index) {
    setState(() {
      var homeP = Provider.of<HomeProvider>(context, listen: false);


      if(index==1){
        homeP.setVisitDate('');

        homeP.setvisitNo('0');
        homeP.setvisittype('0');

      }
      selectedIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nav[index]),
      );
    });
  }
  Color present(String name,String result){
    Color C;
    C=Colors.green;

    if(name=="ضغط"){
      var parts = result.split('/');
      String on = parts[0].trim();
      String of = parts[1].trim();

      if(double.parse(on)>80){
        C=Colors.redAccent;
      }
      if(double.parse(of)>120){
        C=Colors.redAccent;
      }
      if(double.parse(on)<80){
        C=Colors.redAccent;
      }
      if(double.parse(of)<120){
        C=Colors.redAccent;
      }}
    else if(name=="حرارة"){
if(double.parse(result)>38.0){
  C=Colors.redAccent;
}
    }else if(name=="تنفس"){
      if(double.parse(result)>16.0 || double.parse(result)<12){
        C=Colors.redAccent;
      }
    }else if(name=="النبض"){
      if(double.parse(result)>100.0 || double.parse(result)<60.0){
        C=Colors.redAccent;
      }
    }else if(name=="معدل الاكسجين"){
      if(double.parse(result)>100.0 || double.parse(result)<95.0){
        C=Colors.redAccent;
      }
    }else if(name=="الوزن"){
      C=Colors.green;

  }else if(name=="سكري"){
      if(double.parse(result)>120.0 || double.parse(result)<60.0){
        C=Colors.redAccent;
      }

  }else {
      C=Colors.green;

    }


    return C;
  }
  String retturndatenewformat(String DATE){

    String newMonth="";
    var parts = DATE.substring(0,10).split('-');
    String y = parts[0].trim();
    int m = int.parse(parts[1].trim());
    String d = parts[2].trim();

    if(m==1){
      newMonth='Jan';
    }else  if(m==2){
      newMonth='Feb';

    }else  if(m==3){
      newMonth='Mar';

    }else  if(m==4){
      newMonth='Apr';

    }else  if(m==5){
      newMonth='May';

    }else  if(m==6){
      newMonth='Jun';

    }else  if(m==7){
      newMonth='Jul';

    }else  if(m==8){
      newMonth='Aug';

    }else  if(m==9){
      newMonth='Sep';

    }else  if(m==10){
      newMonth='Oct';

    }else  if(m==11){
      newMonth='Nov';

    }else  if(m==12){
      newMonth='Dec';

    }

return newMonth+" "+ d+","+y ;

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


