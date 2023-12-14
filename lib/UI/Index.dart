import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../GlobalVar.dart';
import '../HexaColor.dart';
import '../provider/languageProvider.dart';
import 'Doctors.dart';
import 'Home.dart';
import 'profile.dart';
import 'Settings.dart';

class Index extends StatefulWidget {
  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  var check = false;

  @override
  void dispose() {
    super.dispose();
  }

  int selectedIndex = 1;

  final List<Widget> nav = [
    Settings(),
    Home(),
    profile(),
    Doctors(),
  ];

  @override
  Widget build(BuildContext context) {
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    return Scaffold(
        //appBar: null,
        body: ResponsiveBuilder(builder: (context, sizeInfo) {
          return Center(
            child: nav.elementAt(selectedIndex),
          );
        }),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          selectedItemColor: HexColor(Globalvireables.white),
          unselectedItemColor: Colors.white,
          backgroundColor: HexColor(Globalvireables.basecolor),
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
        ));
  }

  _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
