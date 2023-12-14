import 'dart:convert';
import 'dart:ui';
import 'dart:ui';
import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hismobileapp/UI/profile.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../Models/InvoicesM.dart';
import '../provider/HomeProvider.dart';
import '../provider/LoginProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'Settings.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';
import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hismobileapp/UI/profile.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'dart:ui' as ui;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../provider/HomeProvider.dart';
import '../provider/LoginProvider.dart';
import '../provider/SingleEXAMProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'Settings.dart';
import 'package:intl/intl.dart';

class Invoices extends StatefulWidget {

  const Invoices({super.key});

  @override
  State<Invoices> createState() => _InvoicesState();
}

class _InvoicesState extends State<Invoices> {
  int selectedTile = -1;
  @override
  void initState() {
   // setsearch(context);
    super.initState();
  }


  final List<GlobalObjectKey<FormState>> formKeyList = List.generate(10, (index) => GlobalObjectKey<FormState>(index));


  GlobalKey globalKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
  }
var sumPatient=0;
  int selectedIndex = 1;
var leng=0;
  final List<Widget> nav = [
    Settings(),
    Home(),
    profile(),
  ];
  TextEditingController dateinputC = TextEditingController();
  setsearch(BuildContext context){

    var homeP = Provider.of<HomeProvider>(context, listen: false);
if(homeP.getVisitDate().toString().length>7)
    dateinputC.text=homeP.getVisitDate();
  }
  @override
  Widget build(BuildContext context) {

    var ThemP = Provider.of<Them>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

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
                icon: Icon(Icons.settings ,),
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
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 800.0,
            elevation: 4.0,
            title: Widgets.Appbar(
                context,
                LanguageProvider.Llanguage('Invoices'),
                unitHeightValue,
                LanguageProvider.langg,
                LanguageProvider.getDirection()),
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
                          SizedBox(
                            child: TextField(
                              controller: dateinputC, //editing controller of this TextField
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.date_range,color: HexColor(
                                    ThemP.getcolor()),size: 27*unitHeightValue,),
                                suffixIcon: GestureDetector(
                                    onTap: (){
                                      dateinputC.text=LanguageProvider.Llanguage('SearchbyDate');

                                      setState(() {
                                      });
                                    },
                                    child: Icon(color: Colors.redAccent,dateinputC.text.isEmpty||dateinputC.text.toString()==LanguageProvider.Llanguage('SearchbyDate')
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
                                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  print(formattedDate +"formattedDate");
                               setState(() {
                                 dateinputC.text = formattedDate.toString(); //set output date to TextField value.

                               });
                                }else{
                                  print("Date is not selected");
                                }
                              },
                            ),
                          ),
SizedBox(height: 10,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.1,
                            height: MediaQuery.of(context).size.height / 1.4,

                            child: FutureBuilder(
                              future: getInvoices(context, Loginprovider.getuserId() , dateinputC.text.isEmpty||dateinputC.text.toString()==LanguageProvider.Llanguage('SearchbyDate')?"202":dateinputC.text),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<InvoicesM>> snapshot) {
                                if (snapshot.hasData ) {
                                  List<InvoicesM>? Invoices = snapshot.data;

                                  return Invoices!.isNotEmpty? Container(

                                    child: ListView(
                                      key: Key(selectedTile.toString()),
                                      children: Invoices
                                      .map((InvoicesM inv) => SizedBox(
                                         child: Card(
                                                    child:  Theme(
                                                      data : ThemeData().copyWith(dividerColor: Colors.transparent),
                                                      child: ExpansionTile(
                                                        key: Key((inv.invDate.toString().substring(0,4)).toString()),
                                                        initiallyExpanded: (inv.invDate.toString().substring(0,4)) == selectedTile,
                                                        leading: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Icon(Icons.expand_more_sharp),
                                                        ),
                                                        trailing:  Padding(
                                                          padding: const EdgeInsets.only(left: 0),
                                                          child: Text(
                                                            retDay(inv.invDate.toString()),
                                                            style: TextStyle(
                                                                fontSize: 35,
                                                                fontWeight: FontWeight
                                                                    .w800,
                                                                color: HexColor(
                                                                    ThemP
                                                                        .getcolor())),
                                                          ),
                                                        ),
                                                          title:Row(
                                                            children: [

                                                              Spacer(),
                                                              Align(alignment: Alignment.topLeft,child: Text(inv.bilLTOTALVALUE.toString()+" JD",
                                                                style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,fontWeight: FontWeight.w900,fontSize: 22*unitHeightValue,color: Colors.black),)),
                                                              Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Container(
                                                                    color: HexColor(ThemP.getcolor()),
                                                                    child: SizedBox(height: 50,width: 2,)),
                                                              ),
                                                              SizedBox(
                                                                child: Row(
                                                                  children: [

                                                                    Column(
                                                                      children: [
                                                                        Text(
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            retMonth(inv.invDate.toString()),
                                                                            style: TextStyle(
                                                                                fontSize: 17,
                                                                                fontWeight: FontWeight
                                                                                    .w800,
                                                                                height: 1)),
                                                                        Text(
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            retYear(inv.invDate.toString()),
                                                                            style: TextStyle(
                                                                                fontSize: 16,
                                                                                height: 1)),
                                                                      ],

                                                                    ),



                                                                  ],),
                                                              )
                                                               ],
                                                          ),
                                                        children: [


                                                          Row(
                                                            children: [
                                                              Spacer(),
                                                              Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: SizedBox(
                                                                  width: MediaQuery.of(context).size.width/2,
                                                                  height: 40,
                                                                  child: SfBarcodeGenerator(
                                                                    value: inv.invId.toString(),
                                                                    symbology: Code128(),
                                                                    showValue: false,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),



                                                          Padding(
                                                            padding: EdgeInsets.only(left: 16,right: 16,top: 6),
                                                            child: Row(children: [
                                                              Container(
                                                                  width: 120,
                                                                  child: Text("اسم الاجراء",style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w900),)),
                                                              Spacer(),
                                                              Container(
                                                                  alignment: Alignment.center,
                                                                  child: Text("دفعه المريض",style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w900),)),
                                                              Spacer(),
                                                              Container(
                                                                  alignment: Alignment.center,
                                                                  width: 70,
                                                                  child: Text("المجموع",style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w900),)),


                                                            ],),
                                                          ),

                                                          Column(children: [
                                                            for(int i=0;i<inv.iNVOICESAllModelS!.length;i++)
                                                            Padding(
                                                              padding: EdgeInsets.only(left: 16,right: 16,top: 6),
                                                              child: Container(
                                                                child: Row(children: [

                                                                  Container(
                                                                        width: 120,
                                                                        child: Text(

                                                                           inv.iNVOICESAllModelS![i].servicEDETAILSDESC.toString().split(':').toList().length>2?
                                                                            LanguageProvider.getLanguage()=='AR'
                                                                            ?inv.iNVOICESAllModelS![i].servicEDETAILSDESC.toString().split(':').toList()[2].toString()
                                                                            :inv.iNVOICESAllModelS![i].servicEDETAILSDESC.toString().split(':').toList()[1].toString()

                                                                               :inv.iNVOICESAllModelS![i].servicEDETAILSDESC.toString().split(':').toList()[0].toString()


                                                                          ,style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w600),)),
                                                                     Spacer(),
                                                                     Container(
                                                                      alignment: Alignment.center,
                                                                      width: 60,
                                                                       child: Text(
                                                                         (double.parse(inv.iNVOICESAllModelS![i].servicETOTALAMT.toString())
                                                                         -
                                                                             double.parse(inv.iNVOICESAllModelS![i].servicEPAYORAMT.toString())).toStringAsFixed(3).toString()


                                                                         /*inv.iNVOICESAllModelS![i].servicEPATIENTAMT.toString()*/,style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w600),)),
                                                                     Spacer(),

                                                                  Container(
                                                                      width: 70,
                                                                      child: Text(
                                                                        textAlign: TextAlign.left,
                                                                        inv.iNVOICESAllModelS![i].servicETOTALAMT.toString(),style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w600),)),

                                                                ],),
                                                              ),
                                                            ),

                                                          ],),

SizedBox(height: 15,),

                                                          Padding(
                                                            padding: EdgeInsets.only(left: 16,right: 16,top: 6),
                                                            child: Row(children: [
                                                              Container(
                                                                  alignment: Alignment.center,
                                                                  child: Text( LanguageProvider.getLanguage()=='AR'?'المجموع  ':'Total  ',style: ArabicTextStyle(
                                                                      arabicFont: ArabicFont.tajawal,fontSize: 16*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w900),)),
                                                              Spacer(),
                                                              Container(
                                                                  alignment: Alignment.center,
                                                                  child: Text(inv.patienTTOTALVALUE.toString(),style: ArabicTextStyle(
                                                                      arabicFont: ArabicFont.tajawal,fontSize: 16*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w900),)),
                                                              Spacer(),
                                                              Container(
                                                                  alignment: Alignment.center,
                                                                  child: Text(inv.bilLTOTALVALUE.toString(),style: ArabicTextStyle(
                                                                      arabicFont: ArabicFont.tajawal,fontSize: 16*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w900),)),


                                                            ],),
                                                          ),



                                                          Align(
                                                            alignment: Alignment.bottomCenter,
                                                            child: Container(
                                                              height: 50,
                                                              width:
                                                              MediaQuery.of(context).size.width / 1.6,
                                                              margin: EdgeInsets.only(top: 40, bottom: 5),
                                                              color: HexColor(Globalvireables.white),
                                                              child: ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                  primary: HexColor(ThemP.getcolor()),),
                                                                child:

                                                                Icon(
                                                                  Icons.cloud_download,
                                                                  color: Colors.white,
                                                                  size: 30.0,
                                                                ),
                                                                onPressed: () async {

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
                                                                                        key: globalKey,
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(0.0),
                                                                                          child: Column(children: [

                                                                                          Column(children: [
                                                                                            Row(
                                                                                              children: [
                                                                                                Spacer(),
                                                                                                Spacer(),
                                                                                                Column(
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      'MARKA SPECIALITY HOSPITAL',
                                                                                                      style: TextStyle(
                                                                                                          fontWeight: FontWeight.w700,
                                                                                                          color: HexColor(Globalvireables
                                                                                                              .black),
                                                                                                          fontSize:
                                                                                                          12 *
                                                                                                              unitHeightValue),
                                                                                                    ),
                                                                                                    Text(

                                                                                                      'مستشفى ماركا التخصصي',
                                                                                                      style: TextStyle(
                                                                                                          fontWeight: FontWeight.w700,
                                                                                                          color: HexColor(Globalvireables
                                                                                                              .black),
                                                                                                          fontSize:
                                                                                                          12 *
                                                                                                              unitHeightValue),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Spacer(),
                                                                                                Container(
                                                                                                    width:60,
                                                                                                    height:60,
                                                                                                    child: Image(
                                                                                                        image: new AssetImage(
                                                                                                            "assets/newlogo.png")))
                                                                                              ],
                                                                                            ),
                                                                                            Divider(thickness: 1.0, color: Colors.black),


                                                                                            Padding(
                                                                                              padding: const EdgeInsets.all(15.0),
                                                                                              child: Container(
                                                                                                decoration: BoxDecoration(
                                                                                                    border: Border.all(color: Colors.black),
                                                                                                  color: Colors.black12,

                                                                                                ),
                                                                                                width: MediaQuery.of(context).size.width/2,
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: Text(
                                                                                                    textAlign: TextAlign.center,

                                                                                                    'فاتورة المريض ',
                                                                                                    style: TextStyle(
                                                                                                        fontWeight: FontWeight.w900,
                                                                                                        color: HexColor(Globalvireables
                                                                                                            .black),
                                                                                                        fontSize:
                                                                                                        12 *
                                                                                                            unitHeightValue),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),


                                                                                            Row(
                                                                                              children: [
                                                                                                Spacer(),
                                                                                                Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: SizedBox(
                                                                                                    width: MediaQuery.of(context).size.width/2,
                                                                                                    height: 40,
                                                                                                    child: SfBarcodeGenerator(
                                                                                                      value: inv.invId.toString(),
                                                                                                      symbology: Code128(),
                                                                                                      showValue: true,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Spacer(),

                                                                                              ],
                                                                                            ),


                                                                                          ],),
                                                                                          Row(children: [
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.all(3.0),
                                                                                              child: Container(
                                                                                              width: MediaQuery.of(context).size.width/2.6,
                                                                                              decoration: BoxDecoration(
                                                                                                border: Border.all(color: Colors.black),
                                                                                                color: Colors.transparent,

                                                                                              ),
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.all(3.0),
                                                                                                child: Text(
                                                                                                  textAlign: TextAlign.center,
                                                                                                  LanguageProvider.getLanguage()=='AR'?'اسم المريض  ':'Patient Name  ',
                                                                                                  style: TextStyle(
                                                                                                      fontWeight: FontWeight.w700,
                                                                                                      color: HexColor(Globalvireables
                                                                                                          .black),
                                                                                                      fontSize:
                                                                                                      12 *
                                                                                                          unitHeightValue),
                                                                                                ),
                                                                                              ),
                                                                                                                                                                                        ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.all(3.0),
                                                                                              child: Container(
                                                                                                width: MediaQuery.of(context).size.width/2.3,

                                                                                                decoration: BoxDecoration(
                                                                                                  border: Border.all(color: Colors.black),
                                                                                                  color: Colors.transparent,

                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(3.0),
                                                                                                  child: Text(
                                                                                                    textAlign: TextAlign.center,
                                                                                                    Loginprovider.nameE,
                                                                                                    style: TextStyle(
                                                                                                        color: HexColor(Globalvireables
                                                                                                            .black),
                                                                                                        fontSize:
                                                                                                        12 *
                                                                                                            unitHeightValue),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Spacer(),

                                                                                          ],),
                                                                                          Row(children: [
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.all(3.0),
                                                                                              child: Container(
                                                                                                width: MediaQuery.of(context).size.width/2.6,

                                                                                                decoration: BoxDecoration(
                                                                                                  border: Border.all(color: Colors.black),
                                                                                                  color: Colors.transparent,

                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(3.0),
                                                                                                  child: Text(
                                                                                                    textAlign: TextAlign.center,

                                                                                                    LanguageProvider.getLanguage()=='AR'?'التاريخ ':'Date ',
                                                                                                    style: TextStyle(
                                                                                                        fontWeight: FontWeight.w700,

                                                                                                        color: HexColor(Globalvireables
                                                                                                            .black),
                                                                                                        fontSize:
                                                                                                        12 *
                                                                                                            unitHeightValue),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.all(3.0),
                                                                                              child: Container(
                                                                                                width: MediaQuery.of(context).size.width/2.3,

                                                                                                decoration: BoxDecoration(
                                                                                                border: Border.all(color: Colors.black),
                                                                                                color: Colors.transparent,

                                                                                              ),
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(3.0),
                                                                                                  child: Text(
                                                                                                    textAlign: TextAlign.center,

                                                                                                    inv.invDate.toString(),
                                                                                                    style: TextStyle(

                                                                                                        color: HexColor(Globalvireables
                                                                                                            .black),
                                                                                                        fontSize:
                                                                                                        12 *
                                                                                                            unitHeightValue),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Spacer(),

                                                                                          ],)
                                                                                          ,
                                                                                          Row(children: [
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.all(3.0),
                                                                                              child: Container(
                                                                                                width: MediaQuery.of(context).size.width/2.6,

                                                                                                decoration: BoxDecoration(
                                                                                                  border: Border.all(color: Colors.black),
                                                                                                  color: Colors.transparent,

                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(3.0),
                                                                                                  child: Text(
                                                                                                    textAlign: TextAlign.center,

                                                                                                    LanguageProvider.getLanguage()=='AR'?'رقم المريض  ':'Patient No  ',
                                                                                                    style: TextStyle(
                                                                                                        fontWeight: FontWeight.w700,

                                                                                                        color: HexColor(Globalvireables
                                                                                                            .black),
                                                                                                        fontSize:
                                                                                                        12 *
                                                                                                            unitHeightValue),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.all(3.0),
                                                                                              child: Container(
                                                                                                width: MediaQuery.of(context).size.width/2.3,

                                                                                                decoration: BoxDecoration(
                                                                                                  border: Border.all(color: Colors.black),
                                                                                                  color: Colors.transparent,

                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(3.0),
                                                                                                  child: Text(
                                                                                                    textAlign: TextAlign.center,

                                                                                                    Loginprovider.id,
                                                                                                    style: TextStyle(

                                                                                                        color: HexColor(Globalvireables
                                                                                                            .black),
                                                                                                        fontSize:
                                                                                                        12 *
                                                                                                            unitHeightValue),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),


                                                                                            Spacer(),


                                                                                          ],),


                                                                                            Row(children: [
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.all(3.0),
                                                                                                child: Container(
                                                                                                  width: MediaQuery.of(context).size.width/2.6,

                                                                                                  decoration: BoxDecoration(
                                                                                                    border: Border.all(color: Colors.black),
                                                                                                    color: Colors.transparent,

                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                    padding: const EdgeInsets.all(3.0),
                                                                                                    child: Text(
                                                                                                      textAlign: TextAlign.center,

                                                                                                      LanguageProvider.getLanguage()=='AR'?'رقم الفاتوره  ':'Patient No  ',
                                                                                                      style: TextStyle(
                                                                                                          fontWeight: FontWeight.w700,

                                                                                                          color: HexColor(Globalvireables
                                                                                                              .black),
                                                                                                          fontSize:
                                                                                                          12 *
                                                                                                              unitHeightValue),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.all(3.0),
                                                                                                child: Container(
                                                                                                  width: MediaQuery.of(context).size.width/2.3,

                                                                                                  decoration: BoxDecoration(
                                                                                                    border: Border.all(color: Colors.black),
                                                                                                    color: Colors.transparent,

                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                    padding: const EdgeInsets.all(3.0),
                                                                                                    child: Text(
                                                                                                      textAlign: TextAlign.center,

                                                                                                      inv.invId.toString(),
                                                                                                      style: TextStyle(

                                                                                                          color: HexColor(Globalvireables
                                                                                                              .black),
                                                                                                          fontSize:
                                                                                                          12 *
                                                                                                              unitHeightValue),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),


                                                                                              Spacer(),


                                                                                            ],),

                                                                                            Row(children: [
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.all(3.0),
                                                                                                child: Container(
                                                                                                  width: MediaQuery.of(context).size.width/2.6,

                                                                                                  decoration: BoxDecoration(
                                                                                                    border: Border.all(color: Colors.black),
                                                                                                    color: Colors.transparent,

                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                    padding: const EdgeInsets.all(3.0),
                                                                                                    child: Text(
                                                                                                      textAlign: TextAlign.center,

                                                                                                      LanguageProvider.getLanguage()=='AR'?'تاريخ الاصدار  ':'Patient No  ',
                                                                                                      style: TextStyle(
                                                                                                          fontWeight: FontWeight.w700,

                                                                                                          color: HexColor(Globalvireables
                                                                                                              .black),
                                                                                                          fontSize:
                                                                                                          12 *
                                                                                                              unitHeightValue),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.all(3.0),
                                                                                                child: Container(
                                                                                                  width: MediaQuery.of(context).size.width/2.3,

                                                                                                  decoration: BoxDecoration(
                                                                                                    border: Border.all(color: Colors.black),
                                                                                                    color: Colors.transparent,

                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                    padding: const EdgeInsets.all(3.0),
                                                                                                    child: Text(
                                                                                                      textAlign: TextAlign.center,

                                                                                                      DateTime.now().toString(),
                                                                                                      style: TextStyle(

                                                                                                          color: HexColor(Globalvireables
                                                                                                              .black),
                                                                                                          fontSize:
                                                                                                          12 *
                                                                                                              unitHeightValue),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),


                                                                                              Spacer(),


                                                                                            ],),




SizedBox(height: 10,),

                                                                                            Padding(
                                                                                              padding: const EdgeInsets.all(4.0),
                                                                                              child: Container(
                                                                                                decoration: BoxDecoration(
                                                                                                  border: Border.all(color: Colors.black),
                                                                                                  color: Colors.black12,

                                                                                                ),
                                                                                                width: MediaQuery.of(context).size.width/1.2,
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(4.0),
                                                                                                  child: Text(
                                                                                                    textAlign: TextAlign.center,

                                                                                                    'الخدمات المقدمة للمريض ',
                                                                                                    style: TextStyle(
                                                                                                        fontWeight: FontWeight.w900,
                                                                                                        color: HexColor(Globalvireables
                                                                                                            .black),
                                                                                                        fontSize:
                                                                                                        12 *
                                                                                                            unitHeightValue),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),


                                                                                          Padding(
                                                                                            padding: EdgeInsets.only(left: 16,right: 16,top: 6),
                                                                                            child: Row(children: [
                                                                                              Container(

                                                                                                  decoration: BoxDecoration(
                                                                                                    border: Border.all(color: Colors.black),
                                                                                                    color: Colors.transparent,

                                                                                                  ),
                                                                                                width: MediaQuery.of(context).size.width/5,
                                                                                                  height: 34,
                                                                                                  alignment: Alignment.center,

                                                                                                  child: Text(
                                                                                                    "الخدمة",style: ArabicTextStyle(
                                                                                                      arabicFont: ArabicFont.tajawal,fontSize: 12*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w400),)),
                                                                                              Spacer(),
                                                                                              Spacer(),
                                                                                              Container(
                                                                                                  height: 34,

                                                                                                  decoration: BoxDecoration(
                                                                                                    border: Border.all(color: Colors.black),
                                                                                                    color: Colors.transparent,

                                                                                                  ),
                                                                                                  width: MediaQuery.of(context).size.width/5,
                                                                                                  alignment: Alignment.center,
                                                                                                  child: Text("مبلغ المريض",style: ArabicTextStyle(
                                                                                                      arabicFont: ArabicFont.tajawal,fontSize: 12*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w400),)),
                                                                                              Spacer(),
                                                                                              Container(
                                                                                                  height: 34,

                                                                                                  decoration: BoxDecoration(
                                                                                                    border: Border.all(color: Colors.black),
                                                                                                    color: Colors.transparent,

                                                                                                  ),
                                                                                                  width: MediaQuery.of(context).size.width/5,
                                                                                                  alignment: Alignment.center,
                                                                                                  child: Text("مبلغ التامين",style: ArabicTextStyle(
                                                                                                      arabicFont: ArabicFont.tajawal,fontSize: 12*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w400),)),
                                                                                              Spacer(),
                                                                                              Container(
                                                                                                  height: 34,

                                                                                                  decoration: BoxDecoration(
                                                                                                    border: Border.all(color: Colors.black),
                                                                                                    color: Colors.transparent,

                                                                                                  ),
                                                                                                  width: MediaQuery.of(context).size.width/5,
                                                                                                  alignment: Alignment.center,
                                                                                                  child: Text("المجموع",style: ArabicTextStyle(
                                                                                                      arabicFont: ArabicFont.tajawal,fontSize: 12*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w400),)),

                                                                                            ],),
                                                                                          ),

                                                                                          Column(children: [
                                                                                            for(int i=0;i<inv.iNVOICESAllModelS!.length;i++)
                                                                                              Padding(
                                                                                                padding: EdgeInsets.only(left: 16,right: 16,top: 6),
                                                                                                child: Container(
                                                                                                  child: Row(children: [

                                                                                                    Container(
                                                                                                        width: MediaQuery.of(context).size.width/5,
                                                                                                        height: 34,

                                                                                                        decoration: BoxDecoration(
                                                                                                          border: Border.all(color: Colors.black),
                                                                                                          color: Colors.transparent,

                                                                                                        ),
                                                                                                        child: Text(

                                                                                                          inv.iNVOICESAllModelS![i].servicEDETAILSDESC.toString().split(':').toList().length>2?
                                                                                                          LanguageProvider.getLanguage()=='AR'
                                                                                                              ?inv.iNVOICESAllModelS![i].servicEDETAILSDESC.toString().split(':').toList()[2].toString()
                                                                                                              :inv.iNVOICESAllModelS![i].servicEDETAILSDESC.toString().split(':').toList()[1].toString()

                                                                                                              :inv.iNVOICESAllModelS![i].servicEDETAILSDESC.toString().split(':').toList()[0].toString()


                                                                                                          ,style: ArabicTextStyle(
                                                                                                            arabicFont: ArabicFont.tajawal,fontSize: 12*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w400),)),
                                                                                                    Spacer(),
                                                                                                    Container(
                                                                                                        width: MediaQuery.of(context).size.width/5,
                                                                                                        height: 34,

                                                                                                        decoration: BoxDecoration(
                                                                                                          border: Border.all(color: Colors.black),
                                                                                                          color: Colors.transparent,

                                                                                                        ),
                                                                                                        alignment: Alignment.center,
                                                                                                        child: Text(
                                                                                                          (double.parse(inv.iNVOICESAllModelS![i].servicETOTALAMT.toString())
                                                                                                              -
                                                                                                              double.parse(inv.iNVOICESAllModelS![i].servicEPAYORAMT.toString())).toStringAsFixed(3).toString()


                                                                                                          /*inv.iNVOICESAllModelS![i].servicEPATIENTAMT.toString()*/,style: ArabicTextStyle(
                                                                                                            arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w400),)),
                                                                                                    Spacer(),

                                                                                                    Container(
                                                                                                        decoration: BoxDecoration(
                                                                                                          border: Border.all(color: Colors.black),
                                                                                                          color: Colors.transparent,

                                                                                                        ),
                                                                                                        width: MediaQuery.of(context).size.width/5,
                                                                                                        height: 34,

                                                                                                        child: Text(
                                                                                                          textAlign: TextAlign.center,
                                                                                                          ( double.parse(inv.iNVOICESAllModelS![i].servicETOTALAMT.toString()) - ((double.parse(inv.iNVOICESAllModelS![i].servicETOTALAMT.toString())
                                                                                                              -
                                                                                                              double.parse(inv.iNVOICESAllModelS![i].servicEPAYORAMT.toString())))  ).toStringAsFixed(3).toString(),style: ArabicTextStyle(
                                                                                                            arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w400),)),

                                                                                                    Container(     decoration: BoxDecoration(
                                                                                                      border: Border.all(color: Colors.black),
                                                                                                      color: Colors.transparent,

                                                                                                    ),
                                                                                                        width: MediaQuery.of(context).size.width/5,
                                                                                                        height: 34,

                                                                                                        child: Text(
                                                                                                          textAlign: TextAlign.center,
                                                                                                          inv.iNVOICESAllModelS![i].servicETOTALAMT.toString(),style: ArabicTextStyle(
                                                                                                            arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w400),)),

                                                                                                  ],),
                                                                                                ),
                                                                                              ),




                                                                                          ],),

                                                                                          SizedBox(height: 0,),

                                                                                          Padding(
                                                                                            padding: EdgeInsets.only(left: 16,right: 16,top: 0),
                                                                                            child: Row(children: [
                                                                                              Container(
                                                                                            decoration: BoxDecoration(
                                                                                            border: Border.all(color: Colors.black),
                                                                                            color: Colors.transparent,

                                                                                          ),
                                                                                                  width: MediaQuery.of(context).size.width/5,
                                                                                                  alignment: Alignment.center,
                                                                                                  child: Text( LanguageProvider.getLanguage()=='AR'?'المجموع  ':'Total  ',style: ArabicTextStyle(
                                                                                                      arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w700),)),
                                                                                              Spacer(),
                                                                                              Container(
                                                                                                  decoration: BoxDecoration(
                                                                                                    border: Border.all(color: Colors.black),
                                                                                                    color: Colors.transparent,

                                                                                                  ),
                                                                                                  width: MediaQuery.of(context).size.width/5,
                                                                                                  alignment: Alignment.center,
                                                                                                  child: Text(inv.patienTTOTALVALUE.toString(),style: ArabicTextStyle(
                                                                                                      arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w700),)),
                                                                                              Spacer(),
                                                                                              Container( decoration: BoxDecoration(
                                                                                                border: Border.all(color: Colors.black),
                                                                                                color: Colors.transparent,

                                                                                              ),
                                                                                                  width: MediaQuery.of(context).size.width/5,
                                                                                                  alignment: Alignment.center,
                                                                                                  child: Text(

                                                                                                    (double.parse(inv.bilLTOTALVALUE.toString())
                                                                                                    -
                                                                                                        double.parse(inv.patienTTOTALVALUE.toString())).toStringAsFixed(3)


                                                                                                  ,style: ArabicTextStyle(
                                                                                                      arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w700),)),
                                                                                              Spacer(),
                                                                                              Container( decoration: BoxDecoration(
                                                                                                border: Border.all(color: Colors.black),
                                                                                                color: Colors.transparent,

                                                                                              ),
                                                                                                  width: MediaQuery.of(context).size.width/5,
                                                                                                  alignment: Alignment.center,
                                                                                                  child: Text(inv.bilLTOTALVALUE.toString(),style: ArabicTextStyle(
                                                                                                      arabicFont: ArabicFont.tajawal,fontSize: 14*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w700),)),


                                                                                            ],),
                                                                                          ),
                                                                                            SizedBox(height: 20,),

Padding(

  padding: EdgeInsets.only(left: 16,right: 16,top: 0),

  child: Column(children: [
                                                                                              Row(children: [
                                                                                                Container( decoration: BoxDecoration(
                                                                                                  border: Border.all(color: Colors.black),
                                                                                                  color: Colors.black12,

                                                                                                ),
                                                                                                    width: MediaQuery.of(context).size.width/2,
                                                                                                    alignment: Alignment.center,
                                                                                                    child: Text('صافي المريض',style: ArabicTextStyle(
                                                                                                        arabicFont: ArabicFont.tajawal,fontSize: 12*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w500),)),



                                                                                                Container( decoration: BoxDecoration(
                                                                                                  border: Border.all(color: Colors.black),
                                                                                                  color: Colors.transparent,

                                                                                                ),
                                                                                                    width: MediaQuery.of(context).size.width/5,
                                                                                                    alignment: Alignment.center,
                                                                                                    child: Text(inv.patienTTOTALVALUE.toString(),style: ArabicTextStyle(
                                                                                                        arabicFont: ArabicFont.tajawal,fontSize: 12*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w500),)),



                                                                                              ],)

,
    Row(children: [
      Container( decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.black12,

      ),
          width: MediaQuery.of(context).size.width/2,
          alignment: Alignment.center,
          child: Text('المبلغ المطلوب من التامين',style: ArabicTextStyle(
              arabicFont: ArabicFont.tajawal,fontSize: 12*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w500),)),



      Container( decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.transparent,

      ),
          width: MediaQuery.of(context).size.width/5,
          alignment: Alignment.center,
          child: Text( (double.parse(inv.bilLTOTALVALUE.toString())
              -
              double.parse(inv.patienTTOTALVALUE.toString())).toStringAsFixed(3),style: ArabicTextStyle(
              arabicFont: ArabicFont.tajawal,fontSize: 12*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w500),)),



    ],),


    Row(children: [
      Container( decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.black12,

      ),
          width: MediaQuery.of(context).size.width/2,
          alignment: Alignment.center,
          child: Text('صافي الخصم',style: ArabicTextStyle(
              arabicFont: ArabicFont.tajawal,fontSize: 12*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w500),)),



      Container( decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.transparent,

      ),
          width: MediaQuery.of(context).size.width/5,
          alignment: Alignment.center,
          child: Text( (double.parse(inv.patienTTOTALDISCOUNT.toString())
              +
              double.parse(inv.payoRTOTALDISCOUNT.toString())).toStringAsFixed(3),style: ArabicTextStyle(
              arabicFont: ArabicFont.tajawal,fontSize: 12*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w500),)),



    ],),




                                                                                            ],),
)




                                                                                          ],),
                                                                                        ),
                                                                                      ),
                                                                                      Align(
                                                                                          alignment: Alignment.bottomCenter,
                                                                                          child: Container(
                                                                                              height: 50,
                                                                                              width:
                                                                                              MediaQuery.of(context).size.width / 1.6,
                                                                                              margin: EdgeInsets.only(top: 40, bottom: 5),
                                                                                              color: HexColor(Globalvireables.white),
                                                                                              child: ElevatedButton(
                                                                                                  style: ElevatedButton.styleFrom(
                                                                                                    primary: HexColor(ThemP.getcolor()),),
                                                                                                  child:

                                                                                                  Icon(
                                                                                                    Icons.cloud_download,
                                                                                                    color: Colors.white,
                                                                                                    size: 30.0,
                                                                                                  ),
                                                                                                  onPressed: () async {
                                                                                                    _takeScreenshot();


                                                                                                  })))



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




                                                              //    _takeScreenshot();
                                                                  //  _capturePng();
                                                                },
                                                              ),
                                                            ),
                                                          ),


                                                        ],
                                                      ),
                                                    )


                                                ),
                                       )).toList(),),
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
            ),
          )),
    ]);
  }

  Future<List<InvoicesM>> getInvoices(BuildContext context,String patientid,String date) async {
    var homeP = Provider.of<HomeProvider>(context, listen: false);

    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var ip= Loginprovider.getFirebaseIp().toString();



    var LanguageProvider = Provider.of<Language>(context, listen: false);
    Uri postsURL =
        Uri.parse(ip+Globalvireables.InvoicesURL);
    try {

      print("vnoo "+homeP.getvisittype());

      var map = new Map<String, dynamic>();
      map['patientNo'] = patientid;
      map['searchDate'] = date;
      map['vno'] =homeP.visitNo;
      map['VisitType'] = homeP.getvisittype();



      http.Response res = await http.post(
        postsURL,
        body: map,);

      if (res.statusCode == 200) {
        print("Invoices" + res.body.toString());


        List<dynamic> body = jsonDecode(res.body);

        List<InvoicesM> Invoices = body
            .map(
              (dynamic item) => InvoicesM.fromJson(item),
            )
            .toList();

        return Invoices;
      } else {
        throw "Unable to retrieve Invoices."+res.statusCode.toString();
      }
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('بيانات الفواتير'),
          content: Text(e.toString()),
          actions: <Widget>[],
        ),
      );
    }

    throw "Unable to retrieve Invoices.";
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


  String retturndatenewformat(String DATE){

    String newMonth="";
    var parts = DATE.substring(0,10).split('-');
    String y = parts[0].trim();
    int m = int.parse(parts[1].trim());
    String d = parts[2].trim();

    if(m==1){
      newMonth='January';
    }else  if(m==2){
      newMonth='Februay';

    }else  if(m==3){
      newMonth='March';

    }else  if(m==4){
      newMonth='April';

    }else  if(m==5){
      newMonth='May';

    }else  if(m==6){
      newMonth='June';

    }else  if(m==7){
      newMonth='July';

    }else  if(m==8){
      newMonth='August';

    }else  if(m==9){
      newMonth='September';

    }else  if(m==10){
      newMonth='October';

    }else  if(m==11){
      newMonth='November';

    }else  if(m==12){
      newMonth='December';

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

  void _takeScreenshot() async {
    RenderRepaintBoundary boundary =
    globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      Uint8List pngBytes = byteData.buffer.asUint8List();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return  PdfPreview(
            build: (context) => makePdf(pngBytes),
          );
        },
      );
    }
  }

  Future<Uint8List> makePdf(Uint8List byteList) async {
    final pdf = pw.Document();
    pdf.addPage(
        pw.Page(
            margin: const pw.EdgeInsets.all(10),
            pageFormat: PdfPageFormat.a4,
            build: (context) {
              return  pw.Center(child: pw.Image(pw.MemoryImage(byteList)));

            }
        ));
    return pdf.save();
  }
}
