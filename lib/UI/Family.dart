import 'dart:convert';

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hismobileapp/Models/ProfileM.dart';
import 'package:hismobileapp/UI/profile.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../GlobalVar.dart';
import '../HexaColor.dart';
import 'package:flutter/services.dart';

import '../Models/Doctor.dart';
import '../Models/FamilyModel.dart';
import '../Models/HospitalInfo.dart';
import '../provider/HomeProvider.dart';
import '../provider/LoginProvider.dart';
import '../provider/Them.dart';
import '../provider/languageProvider.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'Settings.dart';
import 'package:http/http.dart' as http;

class Family extends StatefulWidget {
  @override
  State<Family> createState() => _FamilyState();
}

class _FamilyState extends State<Family> {
  @override
  void initState() {
    getparent();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var parent='';
  final newpass2 = TextEditingController();
  final newpass1 = TextEditingController();
  final oldpass = TextEditingController();



  @override
  Widget build(BuildContext context) {
    var Loginproviderr = Provider.of<LoginProvider>(context, listen: false);
    var ThemP = Provider.of<Them>(context, listen: false);

    var colors = [HexColor((Globalvireables.secondcolor)), HexColor((ThemP.getcolor()))];
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var stops = [ 0.0, 1.00];
    var LanguageProvider = Provider.of<Language>(context, listen: false);

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
            title: Widgets.Appbar(context,LanguageProvider.Llanguage('family') , unitHeightValue,LanguageProvider.langg,LanguageProvider.getDirection()),
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


                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.1,
                          height: MediaQuery.of(context).size.height / 1.4,
                          child: FutureBuilder(
                            future: getFamily(context),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<FamilyModel>> snapshot) {
                              if (snapshot.hasData) {
                                List<FamilyModel>? VitalSigns = snapshot.data;
                                return VitalSigns!.asMap().length>0  ? Container(margin: EdgeInsets.only(bottom: 80),
                                  child: ListView(
                                    children: VitalSigns!
                                        .map((FamilyModel Doctor) => SizedBox(
                                        child:  Card(
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
                                          child: Column(children: [

                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(children: [

                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Align(
                                                    alignment: Alignment
                                                        .bottomCenter,
                                                    child: Container(
                                                      height: 40,
                                                      width: 100,
                                                      color: HexColor(
                                                          Globalvireables
                                                              .white),
                                                      child:
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:Loginproviderr.getuserId() == Doctor.childID.toString()?Colors.green: HexColor(
                                                              ThemP
                                                                  .getcolor()),
                                                        ),
                                                        child: Text(
                                                          Loginproviderr.getuserId() == Doctor.childID.toString()?LanguageProvider.Llanguage('change2'): LanguageProvider.Llanguage('change'),
                                                          style: ArabicTextStyle(
                                                              arabicFont: ArabicFont
                                                                  .tajawal,
                                                              color: HexColor(
                                                                  Globalvireables
                                                                      .white),
                                                              fontSize:
                                                              12 *
                                                                  unitHeightValue),
                                                        ),
                                                        onPressed:
                                                            () async {

  Loginproviderr.setuserId(Doctor.childID.toString());
  Loginproviderr.setnameE(Doctor.chilD_FULL_E_NAME.toString());
  Loginproviderr.setnameA(Doctor.chilD_FULL_A_NAME.toString());

setState(() {



});


  Navigator.pop(context);

  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
          (Route<dynamic> route) => false);


                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Container(
                                                  width:MediaQuery.of(context).size.width/2,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      children: [

                                                        Container(alignment: Alignment.topRight,child: Text( textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.w700),
                                                            Doctor.chilD_FULL_A_NAME.toString())),

                                                        Row(
                                                          children: [
                                                            Spacer(),
                                                            Container(alignment: Alignment.topRight,child: Text( textAlign: TextAlign.right
                                                                ,Doctor.relation.toString())),
                                                          ],
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],),
                                            ),



                                            
                                            
                                          ],))))
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




                        Loginproviderr.getParentuserId()==Loginproviderr.getuserId()? Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 50,
                            width:
                            MediaQuery.of(context).size.width / 1.2,
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            color: HexColor(Globalvireables.white),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary:HexColor(ThemP.getcolor()),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                  )),
                              child: Text(
                               LanguageProvider.Llanguage(
                                    'Add'),
                                style: ArabicTextStyle(
                                    arabicFont: ArabicFont.tajawal,
                                    color:
                                    HexColor(Globalvireables.white),
                                    fontSize:  16 * unitHeightValue),
                              ),
                              onPressed: () async {

                                showLoaderDialog(context);
                              },
                            ),
                          ),
                        ):Container()


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





showLoaderDialog(BuildContext context) {

  TextEditingController childidcontroller = TextEditingController();
  TextEditingController relationcontroller = TextEditingController();


  showModalBottomSheet(
      isScrollControlled: true,
      context: context,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,


      builder: (context) {
        return SizedBox(
          child: Column(
            children: <Widget> [
              SizedBox(height: 20,),
              Center(
                child: Text(
                  Provider.of<Language>(context, listen: false).Llanguage("Addfimilypersion"),
                  style: ArabicTextStyle(
                      arabicFont: ArabicFont.tajawal,
                      fontSize: 17.5 * (MediaQuery
                          .of(context)
                          .size
                          .height * 0.00122),
                      color: HexColor(Globalvireables.black),
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: 20,),

              Center(
                child: Padding(
                  padding:  EdgeInsets.all(16.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: childidcontroller,
                    decoration: InputDecoration(
                      labelText: Provider.of<Language>(context, listen: false).Llanguage("childid"),
                    ),
                  ),
                )
              ),

              Center(
                  child: Padding(
                    padding:  EdgeInsets.all(16.0),
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.name,
                      controller: relationcontroller,
                      decoration: InputDecoration(
                        labelText: Provider.of<Language>(context, listen: false).Llanguage("relation"),

                      ),
                    ),
                  )
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
                      AddFamily(context,relationcontroller.text ,childidcontroller.text);
                    },
                  ),
                ),
              ),
              SizedBox(height: 20,),


            ],
          ),
        );
      });
}
AddFamily(BuildContext context,String relation,String childid) async {



    var LanguageProvider = Provider.of<Language>(context, listen: false);
    var prefs = await SharedPreferences.getInstance();

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(LanguageProvider.getLanguage()=="AR"?'تحديث البيانات':'Updating'),
          content: Text(LanguageProvider.getLanguage()=="AR"?'جار تحديث البيانات ...':'Updating...'),
        ));

    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    Uri postsURL =
    Uri.parse(Loginprovider.getFirebaseIp().toString()+
        Globalvireables.AddFamily);
    try {
      var map = new Map<String, dynamic>();
      map['PatientNo'] =await prefs.getString('parent');
      map['relation'] = relation;
      map['childid'] = childid;

      print("VitalSignsINPUT "+map.toString());

      http.Response res = await http.post(
        postsURL,
        body: map,
      ).whenComplete(() => Navigator.pop(context));

      print("ggggggggg"+res.statusCode.toString());


      if (res.statusCode == 200) {
        print("ChangePass" + res.body.toString());

        var body = jsonDecode(res.body);

        if(body.toString().contains('1')){

          Navigator.pop(context);
          updateScreen();
        }else{
          Navigator.pop(context);
          await showDialog(
            context: context,
            builder: (context) =>
            new AlertDialog(
              title: new Text(LanguageProvider.Llanguage('anerrortitle') + "NNNNNNNNNNNNNN"),
              content: Text(LanguageProvider.Llanguage('anerror')),      actions: <Widget>[],
            ),
          );

        }
      } else {
        Navigator.pop(context);

        new AlertDialog(
          title: new Text(LanguageProvider.Llanguage('anerrortitle')),
          content: Text(LanguageProvider.Llanguage('anerror')),     actions: <Widget>[],
        );
      }
    } catch (e) {
      Navigator.pop(context);
      await showDialog(
        context: context,
        builder: (context) =>
        new AlertDialog(
          title: new Text(LanguageProvider.Llanguage('anerrortitle') + e.toString()),
          content: Text(LanguageProvider.Llanguage('anerror')),
          actions: <Widget>[],
        ),

      );
    }

  }




updateScreen(){
  setState(() {

  });
}



getparent() async {

  var prefs = await SharedPreferences.getInstance();
parent=(await prefs.getString('parent'))!;

}
  Future<List<FamilyModel>> getFamily(BuildContext context) async {
    var homeP = Provider.of<HomeProvider>(context, listen: false);


    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var ip= Loginprovider.getFirebaseIp().toString();

    var prefs = await SharedPreferences.getInstance();

    Uri postsURL = Uri.parse(ip+Globalvireables.GETFamily);
    try {
      var map = new Map<String, dynamic>();
      map['PatientNo'] = Loginprovider.getParentuserId();

      http.Response res = await http.post(
        postsURL,
        body: map,
      );
      print("VitalSignsINPUT" + map.toString());

      if (res.statusCode == 200) {
        print("VitalSigns" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<FamilyModel> VitalSignss = body
            .map(
              (dynamic item) => FamilyModel.fromJson(item),
        )
            .toList();

        VitalSignss.add(new FamilyModel(
            childID:Loginprovider.getParentuserId() ,
            chilD_FULL_A_NAME:Loginprovider.getparentnamea() ,
            chilD_FULL_E_NAME:Loginprovider.getparentnamee() ,
            relation :'انــت'

        ));


         
         

        return VitalSignss;
      } else {
        throw "Unable to retrieve VitalSigns." ;
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

    throw "Unable to retrieve VitalSigns." ;
  }



}
