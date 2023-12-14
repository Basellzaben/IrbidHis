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
import 'package:intl/intl.dart';
import '../Models/Doctor.dart';
import '../provider/LoginProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'Settings.dart';

class Doctors extends StatefulWidget {
  @override
  State<Doctors> createState() => _DoctorsState();
}
class _DoctorsState extends State<Doctors> {
  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {

    var ThemP = Provider.of<Them>(context, listen: false);

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
                LanguageProvider.Llanguage('Doctors'),
                unitHeightValue,
                LanguageProvider.langg,
                LanguageProvider.getDirection()),
          ),
          backgroundColor: HexColor(ThemP.getcolor()),
          // backgroundColor: Colors.transparent,
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
                            onChanged: (content) {
                             setState(() {

                             });
                            },
                            controller: dateinputC, //editing controller of this TextField
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search,color: HexColor(
                                  ThemP.getcolor()),size: 27*unitHeightValue,),
                              suffixIcon: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                     dateinputC.text='';

                                    });
                                  },
                                  child: Icon(color: Colors.redAccent,dateinputC.text.isEmpty||dateinputC.text.toString()==LanguageProvider.Llanguage('Search')
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
                                  "Search"),
                            ),
                          //a  readOnly: true,  //set it true, so that user will not able to edit text
                            onTap: () async {
                              setState(() {

                              });
                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          color: Colors.transparent,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.1,
                            height: MediaQuery.of(context).size.height / 1.4,

                            child: FutureBuilder(
                              future: getDoctors(context,"all"),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<Doctor>> snapshot) {
                                if (snapshot.hasData) {
                                  List<Doctor>? Doctors2 = snapshot.data;
                                  List<Doctor>? Doctors = Doctors2!.where(
                                      (map)=>(map.firsT_NAME_A.toString() +
                                      " " + map.fatheR_NAME_A.toString() +
                                      " " + map.lasT_NAME_A.toString()).toString().contains(dateinputC.text.toString())
                                  || map.depName.toString().contains(dateinputC.text.toString())
                                  ).toList();
                                  return Doctors!.isNotEmpty? Container(
                                    child: ListView(
                                      children: Doctors!
                                          .map((Doctor Doctor) => SizedBox(
                                              child:  Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(30),
                                                    // if you need this
                                                    side: BorderSide(
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .height,
                                                      //  color: Colors.black12.withOpacity(0.1),
                                                    ),
                                                  ),
                                                  child: LanguageProvider.getLanguage() ==
                                                          "EN"
                                                      ? Container(
                                                          width:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                  1.1,
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                "assets/doctor2.png",
                                                                height: 90 *
                                                                    unitHeightValue,
                                                                width: 90 *
                                                                    unitHeightValue,
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(context).size.width / 1.8,
                                                                child: Column(
                                                                  children: [
                                                                      Row(
                                                                        children: [
                                                                          (Doctor.firsT_NAME_A.toString() +
                                                                              "" + Doctor.fatheR_NAME_A.toString() +
                                                                              "" + Doctor.lasT_NAME_A.toString()).length<14? Container(
                                                                            width: MediaQuery.of(context).size.width/2,
                                                                                child: Text(
                                                                            maxLines: 2,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            Doctor.firsT_NAME_A.toString() +
                                                                                  " " +
                                                                                  Doctor.fatheR_NAME_A.toString() +
                                                                                  " " +
                                                                                  Doctor.lasT_NAME_A.toString(),
                                                                            style: ArabicTextStyle(
                                                                                  arabicFont: ArabicFont.tajawal,
                                                                                  fontSize: 18 * unitHeightValue,
                                                                                  fontWeight: FontWeight.w700,
                                                                                  color: Colors.black87),
                                                                          ),
                                                                              ):
                                                                          Container(
                                                                            width: MediaQuery.of(context).size.width/2,
                                                                            child: Text(
                                                                              maxLines: 2,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              Doctor.firsT_NAME_A.toString() +
                                                                                  " " +
                                                                                  Doctor.lasT_NAME_A.toString() ,
                                                                              style: ArabicTextStyle(
                                                                                  arabicFont: ArabicFont.tajawal,
                                                                                  fontSize: 18 * unitHeightValue,
                                                                                  fontWeight: FontWeight.w700,
                                                                                  color: Colors.black87),
                                                                            ),
                                                                          ),
                                                                          Spacer(),
                                                                        ],
                                                                      ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          Doctor.depName
                                                                              .toString(),
                                                                          style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
                                                                              fontSize: 14 *
                                                                                  unitHeightValue),
                                                                        ),
                                                                        Spacer(),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),

                                                              ),
                                                              Spacer(),
                                                              Spacer(),
                                                            ],
                                                          ),
                                                        )
                                                      : Row(
                                                    children: [
                                                     // Spacer(),
                                                     // Spacer(),

                                                      Container(
                                                        width: MediaQuery.of(context).size.width / 1.8,
                                                        margin: EdgeInsets.all(10),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Spacer(),
                                                                Center(
                                                                  child: SizedBox(
                                                                    width: MediaQuery.of(context).size.width / 2,
                                                                    child: Row(
                                                                      children: [
                                                                        Spacer(),

                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width/2,

                                                                          child: Text(
                                                                            textAlign: TextAlign.right,
                                                                            maxLines: 2,
                                                                            overflow: TextOverflow.ellipsis,
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
                                                                                fontSize: 16 *
                                                                                    unitHeightValue,
                                                                                fontWeight:
                                                                                FontWeight
                                                                                    .w700,
                                                                                color: Colors
                                                                                    .black87),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),

                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Spacer(),
                                                                Text(
                                                                  Doctor.depName
                                                                      .toString(),
                                                                  style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
                                                                      fontSize: 14 *
                                                                          unitHeightValue),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),

                                                      ),
                                                      Image.asset(
                                                        "assets/doctor3.png",
                                                        height: 90 *
                                                            unitHeightValue,
                                                        width: 90 *
                                                            unitHeightValue,
                                                      ),
                                                    ],
                                                  ),)))
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

  Future<List<Doctor>> getDoctors(BuildContext context,String search) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);

    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var ip= Loginprovider.getFirebaseIp().toString();

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
        builder: (context) => new AlertDialog(
          title: new Text('بيانات الأطباء'),
          content: Text(e.toString()),
          actions: <Widget>[],
        ),
      );
    }

    throw "Unable to retrieve Doctors.";
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
}
