import 'dart:convert';
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
import '../Models/DrugInHos.dart';
import '../provider/HomeProvider.dart';
import '../provider/LoginProvider.dart';
import '../provider/SingleEXAMProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'Settings.dart';
import 'package:intl/intl.dart';
import 'package:arabic_font/arabic_font.dart';
class DrugInHOSPITAL extends StatefulWidget {
  @override
  State<DrugInHOSPITAL> createState() => _DrugInHOSPITALState();
}

class _DrugInHOSPITALState extends State<DrugInHOSPITAL> {
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
   // if(homeP.getVisitDate().toString().length==10)
    //dateinputC.text = homeP.getVisitDate();
  }

  @override
  Widget build(BuildContext context) {
    var ThemP = Provider.of<Them>(context, listen: false);

    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var stops = [0.0, 1.00];
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    var SINGLEEx = Provider.of<SingleEXAMProvider>(context, listen: false);
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
                LanguageProvider.Llanguage('drugH'),
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
                              controller: dateinputC,
                              //editing controller of this TextField
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.date_range,
                                  color: HexColor(ThemP.getcolor()),
                                  size: 27 * unitHeightValue,
                                ),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      print("ex 1");
                                      setState(() {
                                        dateinputC.text =
                                            LanguageProvider.Llanguage(
                                                'SearchbyDate');
                                      });
                                    },
                                    child: Icon(color: Colors.redAccent,dateinputC.text.isEmpty ||
                                            dateinputC.text.toString() ==
                                                LanguageProvider.Llanguage(
                                                    'SearchbyDate')
                                        ? null
                                        : Icons.cancel)),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            HexColor(ThemP.getcolor()),
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            HexColor(ThemP.getcolor()),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0)),
                                contentPadding: EdgeInsets.only(
                                    top: 18, bottom: 18, right: 20, left: 20),
                                fillColor: HexColor(Globalvireables.white),
                                filled: true,
                                hintText:
                                    LanguageProvider.Llanguage("SearchbyDate"),
                              ),
                              readOnly: true,
                              //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101));

                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(formattedDate + "formattedDate");
                                  setState(() {
                                    dateinputC.text = formattedDate
                                        .toString(); //set output date to TextField value.
                                  });
                                } else {
                                  print("Date is not selected");
                                }
                              },
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
                              future: getDrugInHOSPITAL(
                                context,
                                Loginprovider.getuserId(),
                                      dateinputC.text.isEmpty ||
                                      dateinputC.text.toString() ==
                                      LanguageProvider.Llanguage(
                                      'SearchbyDate')
                                      ? "202"
                                      : dateinputC.text,
                              ),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<DrugInHos>> snapshot) {
                                if (snapshot.hasData) {
                                  List<DrugInHos>? DrugInHOSPITAL = snapshot.data;
                                  return DrugInHOSPITAL!.isNotEmpty? Container(


                                    child: ListView(
                                      children: DrugInHOSPITAL!
                                          .map((DrugInHos inv) => SizedBox(
                                              child: GestureDetector(
                                           onTap: () {



                                                    },
                                                child: Column(
                                                  children: [
                                                    Card(
                                                        child:  Theme(
                                                          data : ThemeData().copyWith(dividerColor: Colors.transparent),
                                                          child: ExpansionTile(
                                                            leading: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Icon(Icons.expand_more_sharp),
                                                            ),
                                                            trailing:  Padding(
                                                              padding: const EdgeInsets.only(left: 0),
                                                              child: Text(
                                                                retDay(inv.cdate.toString()),
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
                                                                Spacer(),

                                                                Align(alignment: Alignment.topLeft,child: SizedBox(width: MediaQuery.of(context).size.width/3.3,
                                                                  child: Text( textAlign: TextAlign.left,inv.doctorname.toString(),
                                                                    style: ArabicTextStyle(
                                                                        arabicFont: ArabicFont.tajawal,fontWeight: FontWeight.w900,fontSize: 14*unitHeightValue,color: Colors.black),
                                                                    maxLines: 3,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                )),
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
                                                                              retMonth(inv.cdate.toString()),
                                                                              style: TextStyle(
                                                                                  fontSize: 16,
                                                                                  fontWeight: FontWeight
                                                                                      .w800,
                                                                                  height: 1)),
                                                                          Text(
                                                                              textAlign: TextAlign
                                                                                  .center,
                                                                              retYear(inv.cdate.toString()),
                                                                              style: TextStyle(
                                                                                  fontSize: 14,
                                                                                  height: 1)),
                                                                        ],

                                                                      ),



                                                                    ],),
                                                                )
                                                                ,
                                                              ],
                                                            ),
                                                            children: [
                                                              Column(children: [
                                                                for(int i=0;i<inv.drugHosAllModelS!.length;i++)
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(top: 12),
                                                                    child: Column(
                                                                      children: [

                                                                        Padding(
                                                                          padding: EdgeInsets.only(left: 16,right: 16,top: 6),
                                                                          child: Row(children: [


                                                                            GestureDetector(
                                                                                onTap: () {
                                                                                  showDialog(
                                                                                    context: context,
                                                                                    builder: (BuildContext context) {
                                                                                      return Expanded(
                                                                                        child: AlertDialog(
                                                                                          title: SizedBox(
                                                                                            height: MediaQuery.of(context).size.height/8,

                                                                                            child: Center(
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  Text(
                                                                                                      textAlign: TextAlign.center,

                                                                                                      LanguageProvider.Llanguage("Dosageinstructions"),
                                                                                                      style: ArabicTextStyle(
                                                                                                          arabicFont: ArabicFont.tajawal,
                                                                                                          fontSize: 22 *
                                                                                                              unitHeightValue)),
                                                                                                  Text(
                                                                                                    textAlign: TextAlign.center,

                                                                                                      inv.drugHosAllModelS![i].dose.toString()=='null'||inv.drugHosAllModelS![i].dose==null ?"":inv.drugHosAllModelS![i].dose.toString(),
                                                                                                    style: ArabicTextStyle(
                                                                                                        arabicFont: ArabicFont.tajawal,
                                                                                                        fontSize:
                                                                                                        16 * unitHeightValue),
                                                                                                  ),


                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          content:   SizedBox(
                                                                                            height: MediaQuery.of(context).size.height/8,

                                                                                            child: Column(
                                                                                        children: [
                                                                                        Text(
                                                                                        textAlign: TextAlign.center,

                                                                                              LanguageProvider.Llanguage("qt"),
                                                                                              style: ArabicTextStyle(
                                                                                                  arabicFont: ArabicFont.tajawal,
                                                                                                  fontSize: 22 * unitHeightValue)),
                                                                                        Text(
                                                                                                textAlign: TextAlign.center,
                                                                                               double.parse(inv.drugHosAllModelS![i].qt.toString()).toStringAsFixed(1)+" : "
                                                                                                +(
                                                                                                    LanguageProvider.getLanguage()=='AR'?inv.drugHosAllModelS![i].unit.toString().split(':').last:
                                                                                                    inv.drugHosAllModelS![i].unit.toString().split(':').first
                                                                                                ),
                                                                                                style: ArabicTextStyle(
                                                                                                arabicFont: ArabicFont.tajawal,
                                                                                                fontSize:
                                                                                                16 * unitHeightValue),
                                                                                        ),


                                                                                        ],
                                                                                      ),
                                                                                          ),
                                                                                          actions: [



                                                                                          ],
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  );


                                                                                },child: Icon(Icons.more_horiz))
                                                                            ,





                                                                            Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: SizedBox(
                                                                                width:MediaQuery.of(context).size.width/1.7,
                                                                                child: Text( textAlign: TextAlign.left,maxLines: 3,
                                                                                  overflow: TextOverflow.ellipsis,inv.drugHosAllModelS![i].cname.toString(),style: ArabicTextStyle(
                                                                                      arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w600),),
                                                                              ),
                                                                            ),


                                                                            SizedBox(width: 10,),
                                                                            Container(
                                                                              width: 28,
                                                                              height: 28,
                                                                              decoration: BoxDecoration(
                                                                                color:  Colors.white, // border color
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(2), // border width
                                                                                child: Container( // or ClipRRect if you need to clip the content
                                                                                  decoration: BoxDecoration(
                                                                                    shape: BoxShape.circle,
                                                                                    color: HexColor(ThemP.getcolor()), // inner circle color
                                                                                  ),
                                                                                  child: Center(child: Text((i+1).toString(),style: TextStyle(color: Colors.white),)), // inner content
                                                                                ),
                                                                              ),
                                                                            ),


                                                                          ],),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),


                                                              ],),
                                                            ],
                                                          ),
                                                        )


                                                    )
                                                   /* Card(
                                                        color: Colors.white,
                                                        shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: HexColor(
                                                                 ThemP.getcolor()),
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius.circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.all(13),
                                                          child: SizedBox(
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Column(
                                                                        children: [

                                                                          Align(
                                                                            alignment: Alignment.topLeft,
                                                                            child: Column(children: [
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: SizedBox(
                                                                                  width:MediaQuery.of(context).size.width/1.7,
                                                                                  child: Text(inv.doctorname.toString(), textAlign: TextAlign.left,maxLines: 3,
                                                                                    overflow: TextOverflow.ellipsis,style: ArabicTextStyle(
                                                                                        arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w600),),
                                                                                ),
                                                                              ),

                                                                              for(int i=0;i<inv.DrugInHOSPITALHdrModels!.length;i++)
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(top: 12),
                                                                                  child: Column(
                                                                                    children: [

                                                                                      Padding(
                                                                                        padding: EdgeInsets.only(left: 16,right: 16,top: 6),
                                                                                        child: Row(children: [


                                                                                          GestureDetector(
                                                                                              onTap: () {


                                                                                                showDialog(
                                                                                                  context: context,
                                                                                                  builder: (BuildContext context) {
                                                                                                    return Expanded(
                                                                                                      child: AlertDialog(
                                                                                                        title: Center(
                                                                                                          child: Text(
                                                                                                              textAlign: TextAlign.center,

                                                                                                              LanguageProvider.Llanguage("Dosageinstructions"),
                                                                                                              style: ArabicTextStyle(
                                                                                                                  arabicFont: ArabicFont.tajawal,
                                                                                                                  fontSize: 22 *
                                                                                                                      unitHeightValue)),
                                                                                                        ),
                                                                                                        content: Text(
                                                                                                          textAlign: TextAlign.center,

                                                                                                          inv.DrugInHOSPITALHdrModels![i].dos.toString(),
                                                                                                          style: ArabicTextStyle(
                                                                                                              arabicFont: ArabicFont.tajawal,
                                                                                                              fontSize:
                                                                                                              16 * unitHeightValue),
                                                                                                        ),
                                                                                                        actions: [



                                                                                                        ],
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                );


                                                                                              },child: Icon(Icons.more_horiz))
                                                                                          ,





                                                                                             Align(
                                                                                               alignment: Alignment.topLeft,
                                                                                               child: SizedBox(
                                                                                                 width:MediaQuery.of(context).size.width/1.7,
                                                                                                 child: Text( textAlign: TextAlign.left,maxLines: 3,
                                                                                                   overflow: TextOverflow.ellipsis,inv.DrugInHOSPITALHdrModels![i].cname.toString(),style: ArabicTextStyle(
                                                                                                        arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,color: Colors.black,fontWeight: FontWeight.w600),),
                                                                                               ),
                                                                                             ),


                                                                                          SizedBox(width: 10,),
                                                                                          Container(
                                                                                            width: 28,
                                                                                            height: 28,
                                                                                            decoration: BoxDecoration(
                                                                                              color:  Colors.white, // border color
                                                                                              shape: BoxShape.circle,
                                                                                            ),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsets.all(2), // border width
                                                                                              child: Container( // or ClipRRect if you need to clip the content
                                                                                                decoration: BoxDecoration(
                                                                                                  shape: BoxShape.circle,
                                                                                                  color: HexColor(ThemP.getcolor()), // inner circle color
                                                                                                ),
                                                                                                child: Center(child: Text((i+1).toString(),style: TextStyle(color: Colors.white),)), // inner content
                                                                                              ),
                                                                                            ),
                                                                                          ),


                                                                                        ],),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),



                                                                            ],),



                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),



                                                              ],
                                                            ),
                                                          ),
                                                        )),*/
                                                  ],
                                                ),
                                              )))
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
            ),
          )),
    ]);
  }

  Future<List<DrugInHos>> getDrugInHOSPITAL(
      BuildContext context, String patientid, String date ) async {
    var homeP = Provider.of<HomeProvider>(context, listen: false);

    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var ip= Loginprovider.getFirebaseIp().toString();


    print('ordernoo '+homeP.getvisitNo());
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    Uri postsURL = Uri.parse(ip+Globalvireables.DrugInHOSPITALURL);
    try {
      var map = new Map<String, dynamic>();
      map['PatientNo'] = patientid;
      map['Date'] = date;
      map['vno'] = homeP.getvisitNo();

      http.Response res = await http.post(
        postsURL,
        body: map,
      );

      if (res.statusCode == 200) {
        print("DrugInHOSPITAL" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<DrugInHos> DrugInHOSPITAL = body
            .map(
              (dynamic item) => DrugInHos.fromJson(item),
            )
            .toList();

        return DrugInHOSPITAL;
      } else {
        throw "Unable to retrieve DrugInHOSPITAL." + res.statusCode.toString();
      }
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('العلاجات'),
          content: Text(e.toString()),
          actions: <Widget>[],
        ),
      );
    }

    throw "Unable to retrieve DrugInHOSPITAL.";
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
