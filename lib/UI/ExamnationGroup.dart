import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hismobileapp/UI/profile.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/ExamnationGroupM.dart';
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


import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';



class ExamnationGroup extends StatefulWidget {
  @override
  State<ExamnationGroup> createState() => _ExamnationGroupState();
}

class _ExamnationGroupState extends State<ExamnationGroup> {
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
  TextEditingController dateinputC = TextEditingController();

  setsearch(BuildContext context) {
    var homeP = Provider.of<HomeProvider>(context, listen: false);

  //  dateinputC.text = homeP.getVisitDate();
  }
   GlobalKey globalKey = GlobalKey();
  Future<void> _capturePng() async {
    RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();



    await ImageGallerySaver.saveImage(pngBytes);
    print(pngBytes);
  }

  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();

  void _takeScreenshot() async {
    RenderRepaintBoundary boundary =
    globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      Uint8List pngBytes = byteData.buffer.asUint8List();
    //  makePdf(pngBytes);





    showDialog(
    context: context,
    builder: (BuildContext context) {
    return  PdfPreview(
      build: (context) => makePdf(pngBytes),
    );
    },
    );

      // Saving the screenshot to the gallery
     /* final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(pngBytes),
          quality: 90,
          name: 'screenshot-${DateTime.now()}.pdf');
        print(result.toString() +"  resssult");*/

    }
  }

  @override
  Widget build(BuildContext context) {

    var ThemP = Provider.of<Them>(context, listen: false);

    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var stops = [0.0, 1.00];
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var SINGLEEx = Provider.of<SingleEXAMProvider>(context, listen: false);

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
                LanguageProvider.Llanguage('Examnation'),
                unitHeightValue,
                LanguageProvider.langg,
                LanguageProvider.getDirection()),
          ),
          backgroundColor: HexColor(ThemP.getcolor()),
          // backgroundColor: Colors.transparent,
          body: RepaintBoundary(
/*LanguageProvider.getDirection()*/
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
                child: RepaintBoundary(
                //  key: globalKey,

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


                          RepaintBoundary(
                            key: globalKey,
                            child: Column(children: [

                              Container(
                                color: Colors.white,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(children: [
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

                                                'Patient Laboratory Tests',
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
                                      SizedBox(height: 5,),
                                      Row(children: [ Text(
                                        'Patient Name : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: HexColor(Globalvireables
                                                .black),
                                            fontSize:
                                            12 *
                                                unitHeightValue),
                                      ),
                                        Text(
                                          Loginprovider.nameE,
                                          style: TextStyle(
                                              color: HexColor(Globalvireables
                                                  .black),
                                              fontSize:
                                              12 *
                                                  unitHeightValue),
                                        ),
                                        Spacer(),

                                      ],)
                                      ,
                                      Row(children: [ Text(
                                        'Doctor Name :',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,

                                            color: HexColor(Globalvireables
                                                .black),
                                            fontSize:
                                            12 *
                                                unitHeightValue),
                                      ),
                                        Text(
                                          SINGLEEx.getDOCTORNAME(),
                                          style: TextStyle(

                                              color: HexColor(Globalvireables
                                                  .black),
                                              fontSize:
                                              12 *
                                                  unitHeightValue),
                                        ),
                                        Spacer(),

                                      ],),

                                      Row(children: [
                                        Text(
                                          'Date :',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,

                                              color: HexColor(Globalvireables
                                                  .black),
                                              fontSize:
                                              12 *
                                                  unitHeightValue),
                                        ),
                                        Text(
                                          SINGLEEx.getDATE(),
                                          style: TextStyle(

                                              color: HexColor(Globalvireables
                                                  .black),
                                              fontSize:
                                              12 *
                                                  unitHeightValue),
                                        ),
                                        Spacer(),

                                      ],)
                                      ,
                                      Row(children: [
                                        Text(
                                          'Patient No : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,

                                              color: HexColor(Globalvireables
                                                  .black),
                                              fontSize:
                                              12 *
                                                  unitHeightValue),
                                        ),
                                        Text(
                                          Loginprovider.id,
                                          style: TextStyle(

                                              color: HexColor(Globalvireables
                                                  .black),
                                              fontSize:
                                              12 *
                                                  unitHeightValue),
                                        ),


                                        Spacer(),


                                      ],),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Divider(),
                                      ),

                                      Row(
                                        children: [
                                          Text(
                                            SINGLEEx.SERVDESC,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: HexColor(Globalvireables
                                                    .black),
                                                fontSize:
                                                12 *
                                                    unitHeightValue),
                                          ),
                                          Spacer()

                                        ],
                                      ),
SizedBox(height: 6,),
                                      //ListView
                                      SizedBox(
                                        height: 180,
                                        child: FutureBuilder(
                                          future: getExamnation(
                                            context,
                                            Loginprovider.getuserId(),
                                              '20',
                                              SINGLEEx.getOrderNo(),
                                              SINGLEEx.getServNo(),
                                              /*SINGLEEx.getServNo()*/
                                          ),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<List<ExamnationGroupM>> snapshot) {
                                            if (snapshot.hasData) {
                                              List<ExamnationGroupM>? Examnation = snapshot.data;
                                              return Examnation!.isNotEmpty? ListView(
                                                children: Examnation!
                                                    .map((ExamnationGroupM inv) => SizedBox(
                                                    child: Row(children: [
                                                      Text(
                                                        inv.serVDESC.toString(),
                                                        style: TextStyle(

                                                            color: HexColor(Globalvireables
                                                                .black),
                                                            fontSize:
                                                            12 *
                                                                unitHeightValue),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        inv.result.toString(),
                                                        style: TextStyle(

                                                            color: HexColor(Globalvireables
                                                                .black),
                                                            fontSize:
                                                            12 *
                                                                unitHeightValue),
                                                      ),
                                                      Spacer(),

                                                      Text(
                                                          inv.unitDesc.toString(),

                                                        style: TextStyle(

                                                            color: HexColor(Globalvireables
                                                                .black),
                                                            fontSize:
                                                            12 *
                                                                unitHeightValue),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        inv.normalRange.toString(),

                                                        style: TextStyle(

                                                            color: HexColor(Globalvireables
                                                                .black),
                                                            fontSize:
                                                            12 *
                                                                unitHeightValue),
                                                      ),


                                                    ],)


                                                ))
                                                    .toList(),
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



                                    ],),
                                  ),
                                ),
                              ),
                             /* Image.asset(
                                "assets/fotter.jpg",
                                width: MediaQuery.of(context).size.width,
                              ),
                              */
                              
                              
                            ],),
                          ),

/*Spacer(),

                          Image.asset(
                            "assets/fotter.jpg",
                            width: MediaQuery.of(context).size.width,
                            height: 200,

                          ),*/





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
                                child:

                                Icon(
                                  Icons.cloud_download,
                                  color: Colors.white,
                                  size: 30.0,
                                ),/*Text(
                                 LanguageProvider.Llanguage('download'),
                                  style: ArabicTextStyle(
                                      arabicFont: ArabicFont.tajawal,
                                      color:
                                      HexColor(Globalvireables.white),
                                      fontSize: 13 * unitHeightValue),
                                ),*/
                                onPressed: () async {
                                  _takeScreenshot();
                                //  _capturePng();
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
          )),
    ]);
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
  Future<List<ExamnationGroupM>> getExamnation(
      BuildContext context, String patientid, String date,String orderNo,String ServNo) async {
    var homeP = Provider.of<HomeProvider>(context, listen: false);


    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var ip= Loginprovider.getFirebaseIp().toString();


    Uri postsURL = Uri.parse(ip+Globalvireables.ExamnatioGroupURL);
    try {
      var map = new Map<String, dynamic>();
      map['PatientNo'] = patientid;
      map['Date'] = date;
      map['OrderNo'] = orderNo;
      map['ServNo'] = ServNo;
      map['vno'] = homeP.getvisitNo();
      map['VisitType'] = homeP.getvisittype();

      http.Response res = await http.post(
        postsURL,
        body: map,
      );

      if (res.statusCode == 200) {
        print("ExamnationG" + map.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<ExamnationGroupM> Examnation = body
            .map(
              (dynamic item) => ExamnationGroupM.fromJson(item),
        )
            .toList();

        return Examnation;
      } else {
        throw "Unable to retrieve Examnation." + res.statusCode.toString();
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

    throw "Unable to retrieve Examnation.";
  }

  ////////////////////////////////////////////////



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

  Future<Uint8List> makePdf2() async {
    final pdf = pw.Document();
    final ByteData bytes = await rootBundle.load('assets/fotter.jpg');
    final Uint8List byteList = bytes.buffer.asUint8List();
    pdf.addPage(
        pw.Page(
            margin: const pw.EdgeInsets.all(10),
            pageFormat: PdfPageFormat.a4,
            build: (context) {
              return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Header(text: "About Cat", level: 1),
                          pw.Image(pw.MemoryImage(byteList), fit: pw.BoxFit.fitHeight, height: 100, width: 100)
                        ]
                    ),
                    pw.Divider(borderStyle: pw.BorderStyle.dashed),
                    pw.Paragraph(text: 'text'),
                  ]
              );
            }
        ));
    return pdf.save();
  }


}
