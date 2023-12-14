import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:device_preview/device_preview.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hismobileapp/provider/HomeProvider.dart';
import 'package:hismobileapp/provider/HospitalProvider.dart';
import 'package:hismobileapp/provider/ImgaeXrayProvider.dart';
import 'package:hismobileapp/provider/LoginProvider.dart';
import 'package:hismobileapp/provider/MedicalREPProvider.dart';
import 'package:hismobileapp/provider/SingleEXAMProvider.dart';
import 'package:hismobileapp/provider/Them.dart';
import 'package:hismobileapp/provider/languageProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:arabic_font/arabic_font.dart';
import 'GlobalVar.dart';
import 'HexaColor.dart';
import 'Models/NotificationsM.dart';
import 'NotificationService.dart';
import 'UI/LoginScreen.dart';

import 'package:firebase_core/firebase_core.dart';

String language='';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
 // await Firebase.initializeApp();
  await Firebase.initializeApp();


  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<Language>(create: (_) => Language()),
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
        ChangeNotifierProvider<ImgaeXrayProvider>(create: (_) => ImgaeXrayProvider()),
        ChangeNotifierProvider<SingleEXAMProvider>(create: (_) => SingleEXAMProvider()),
        ChangeNotifierProvider<Them>(create: (_) => Them()),
        ChangeNotifierProvider<HospitalProvider>(create: (_) => HospitalProvider()),
        ChangeNotifierProvider<MedicalREPProvider>(create: (_) => MedicalREPProvider()),
      ],
      child:DevicePreview(enabled: false,builder:(context)=> const MyApp(),)));


  var value = FirebaseDatabase.instance.reference();
  var ActiveNotifications = await value.child('ActiveNotifications').once();
  var NotifiactionsDuration = await value.child('NotifiactionsDuration').once();


  print("ActiveNotifications : "+ActiveNotifications.snapshot.value.toString());


  if(ActiveNotifications.snapshot.value.toString()=='1'){
    print("Duration : "+NotifiactionsDuration.snapshot.value.toString());

    initializeService();
  NotificationService().initNotification();
}


}

const notificationChannelId = 'background_test';
const notificationId = 424;
var ticketId = '';
Future<List<NotificationsM>> getnotifications() async {
  await Firebase.initializeApp();

  var prefs = await SharedPreferences.getInstance();

 var userId= prefs.getString('userId');



  Uri postsURL =
  Uri.parse(Globalvireables.NotificationURL);
  print(Globalvireables.HospitalInfoURL.toString());

  var map = new Map<String, dynamic>();
  map['PatientNo'] = userId.toString();
  map['NotificationType'] = 'system';

  try {
    http.Response res = await http.post(
      postsURL,
      body: map,
    );

    if (res.statusCode == 200) {
      print("Doctors" + res.body.toString());

      List<dynamic> body = jsonDecode(res.body);

      print(res.body.toString()+"resresresres");



      List<NotificationsM> HINFO = body
          .map(
            (dynamic item) => NotificationsM.fromJson(item),
      )
          .toList();

      print(HINFO[0].dtl.toString()+"sdafdsf");

      return HINFO;
    } else {
      throw "Unable to retrieve Doctors. orrr";
    }
  } catch (e) {



  }

  throw "Unable to retrieve Doctors.";
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId,
    'MY FOREGROUNDSERVICE',
    description: 'hello world',
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: false,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
    ),
  );
  service.startService();
}

@pragma('vm:entry-point')
onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp();


    var value = FirebaseDatabase.instance.reference();
    var NotifiactionsDuration = await value.child('NotifiactionsDuration').once();

    print("NotifiactionsDuration : "+NotifiactionsDuration.toString());

    int DurationSeconds;
    try {
       DurationSeconds = int.parse(
          NotifiactionsDuration.snapshot.value.toString());
    }catch(_){
      DurationSeconds=99999;

    }


    Timer.periodic(Duration(seconds: DurationSeconds), (timer) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var ActiveNotifications = await value.child('ActiveNotifications').once();

    print("ActiveNotifications :::: " +ActiveNotifications.snapshot.value.toString());

    if(ActiveNotifications.snapshot.value.toString()=='1') {

    List<NotificationsM> x = await getnotifications();

    for (int i = 0; i < x.length; i++) {
      NotificationService().showNotification(
          id: i,
          title: x[i].hdr.toString(),
          body: x[i].dtl.toString());
    }
  }

    });
  }


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
     ),
      home: const MyHomePage(title: 'F'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  SetLanguage(BuildContext context) async {
    var language;
    SharedPreferences pref =
    await SharedPreferences.getInstance();
    language=pref.get('language') ?? 'AR';
    if(language==null ||language.isEmpty){
      language='AR';
    }
    pref.setString('language', language);
    Provider.of<Language>(context, listen: false)
        .setLanguage(language);
    print(language +" laaan");}
  @override
  Widget build(BuildContext context) {
    SetLanguage(context);
    return EasySplashScreen(
      backgroundImage: Image.asset(
        "assets/background.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ).image,
      logoWidth: MediaQuery.of(context).size.width/2.5,
      loaderColor:HexColor(Globalvireables.basecolor),
      logo: Image.asset(
        "assets/newlogo.png",
      ),
      showLoader: true,
      title:  Text(
        textAlign: TextAlign.center,
    'بـوابـتـك إلـى مـلـفـك الـطـبـي\n'+'Your gateway to your medical file'
      ,
        style: ArabicTextStyle(
          fontWeight: FontWeight.w300,
            fontSize: 22,
            arabicFont: ArabicFont.tajawal,
            ),

      ),
      loadingText:  Text(
        '',
        style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,color: HexColor(Globalvireables.basecolor)),
      ),
      navigator:  LoginScreen(),
      durationInSeconds: 5,
    );
  }

}
