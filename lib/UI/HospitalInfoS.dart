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
import 'package:url_launcher/url_launcher.dart';

import '../Models/HospitalInfo.dart';
import '../provider/LoginProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'Settings.dart';
import 'package:http/http.dart' as http;

class HospitalInfoS extends StatefulWidget {
  @override
  State<HospitalInfoS> createState() => _HospitalInfoSState();
}

class _HospitalInfoSState extends State<HospitalInfoS> {
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
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var stops = [ 0.0, 1.00];
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    var ThemP = Provider.of<Them>(context, listen: false);

    return Stack(children: <Widget>[
      Image.asset(
        "assets/backgroundhinfo.png",
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
                  label: LanguageProvider.Llanguage('HospitalInfoS')
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
            title: Widgets.Appbar(context,LanguageProvider.Llanguage('HospitalInfoS') , unitHeightValue,LanguageProvider.langg,LanguageProvider.getDirection()),
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



 FutureBuilder(
                         future: getHospitalInf(context),
                         builder: (BuildContext context,
                             AsyncSnapshot<List<HospitalInfo>> snapshot) {
                           if (snapshot.hasData) {
                             List<HospitalInfo>? Doctors = snapshot.data;
                             return Column(
                               children: [
                                 SizedBox(
                                   width: 200,
                                   height: 200,
                                   child: Image(
                                       image: new AssetImage(
                                           "assets/newlogo.png")),
                                 ),
                                 Text(LanguageProvider.getLanguage()=='AR'? Doctors![0].desCA.toString():Doctors![0].desCE.toString(),
                                   style: TextStyle(
                                       fontWeight: FontWeight.w700,
                                       color: HexColor(Globalvireables
                                           .black),
                                       fontSize:
                                       18 *
                                           unitHeightValue),),
                                 SizedBox(
                                   height: 30,
                                 ),


                                 Card(
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
                                           Icons.location_on,
                                         ),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.all(10),
                                         child: Center(child: Text(LanguageProvider.getLanguage()=='AR'? Doctors![0].addresSEXPA.toString():Doctors![0].addresSEXPE.toString(),
                                           style: TextStyle(
                                               fontWeight: FontWeight.w700,
                                               color: HexColor(Globalvireables
                                                   .black),
                                               fontSize:
                                               18 *
                                                   unitHeightValue),),),
                                       ),
                                     ],
                                   ),

                                 )
,
                                 Card(
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
                                       Padding(
                                         padding: const EdgeInsets.all(10),
                                         child: Center(child: Text(LanguageProvider.getLanguage()=='AR'? Doctors![0].email.toString():Doctors![0].email.toString(),
                                           style: TextStyle(
                                               fontWeight: FontWeight.w700,
                                               color: HexColor(Globalvireables
                                                   .black),
                                               fontSize:
                                               18 *
                                                   unitHeightValue),),),
                                       ),
                                     ],
                                   ),

                                 )
,
                                 GestureDetector(
                                   onTap: () async {
                                     String url="tel:+"+Doctors![0].phonE1.toString();
                                     if (await canLaunch(url)) {
                                     launch(url);
                                     } else {
                                     throw "Could not launch $url";
                                     }
                                   },
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
                                             Icons.phone,
                                           ),
                                         ),
                                         Padding(
                                           padding: const EdgeInsets.all(10),
                                           child: Center(child: Text(LanguageProvider.getLanguage()=='AR'? Doctors![0].phonE1.toString():Doctors![0].phonE1.toString(),
                                             style: TextStyle(
                                                 fontWeight: FontWeight.w700,
                                                 color: HexColor(Globalvireables
                                                     .black),
                                                 fontSize:
                                                 18 *
                                                     unitHeightValue),),),
                                         ),
                                       ],
                                     ),
                                   ),
                                 )
,
                                 GestureDetector(
                                   onTap: (){
                                     openUrl(Doctors![0].websitEADDRESS.toString().trim());

                                   },
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
                                             Icons.link,
                                           ),
                                         ),
                                         Padding(
                                           padding: const EdgeInsets.all(10),
                                           child: Container(
                                             width: MediaQuery.of(context).size.width/1.5,
                                             child: Center(child: Text(LanguageProvider.getLanguage()=='AR'? Doctors![0].websitEADDRESS.toString():Doctors![0].websitEADDRESS.toString(),
                                               style: TextStyle(
                                                   fontWeight: FontWeight.w700,
                                                   color: HexColor(Globalvireables
                                                       .black),
                                                   fontSize:
                                                   18 *
                                                       unitHeightValue),),),
                                           ),
                                         ),
                                       ],
                                     ),

                                   ),
                                 ),

SizedBox(height: 30,),
                                 Center(
                                   child: Row(children: [
Spacer(),
                           GestureDetector(
                           onTap: (){

                             openUrl(Doctors![0].Facebook.toString().trim());

                           },
                                       child: Image.asset(
                                         "assets/facebook.png",
                                         height: 70,
                                         width: 70,
                                       ),
                                     ),
                                     Spacer(),

                                     GestureDetector(
                                       onTap: (){

                                         openUrl(Doctors![0].Twitter.toString().trim());

                                       },
                                       child: Image.asset(
                                         "assets/twitter.png",
                                         height: 70,
                                         width: 70,
                                       ),
                                     ),


                                     Spacer(),



                                   ],),
                                 )



                               ],


                             );
                           } else {
                             return Center(
                                 child: CircularProgressIndicator());
                           }
                         },
                       ),


                      /* Center(
                         child: Container(
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
                             width:
                             MediaQuery.of(context).size.width / 2.3,
                             height:
                             MediaQuery.of(context).size.width / 2.3,
                             child: Image(
                                 image: new AssetImage(
                                     "assets/esraalogo.png"))),
                       ),*/

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
    setState(() {
      selectedIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nav[index]),);
    });
  }
  int selectedIndex = 1;

  final List<Widget> nav = [
    Settings(),
    Home(),
    profile(),
  ];


  Future<List<HospitalInfo>> getHospitalInf(BuildContext context) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);

    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var ip= Loginprovider.getFirebaseIp().toString();


    Uri postsURL =
    Uri.parse(ip+Globalvireables.HospitalInfoURL);
    try {
      http.Response res = await http.post(
        postsURL,
      );

      if (res.statusCode == 200) {
        print("Doctors" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<HospitalInfo> Doctors = body
            .map(
              (dynamic item) => HospitalInfo.fromJson(item),
        )
            .toList();

print("facebookAPI "+Doctors[0].Facebook.toString());

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
  Future<void> openUrl(String url) async {
    final _url = Uri.parse(url);

    print("urrri "+url);

    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) { // <--
      throw Exception('Could not launch $_url');
    }
  }

}
