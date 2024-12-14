import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:finance/constants.dart';
import 'package:finance/navigation_pages/add_nav_page.dart';
import 'package:finance/navigation_pages/info_nav_page.dart';
import 'package:finance/navigation_pages/setting_nav_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appHomeTheme,
      home: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          buttonBackgroundColor: appHomeTheme.primaryColor,
          color: appHomeTheme.primaryColor,
          backgroundColor: formColor,
          items: <Widget>[
            Icon(Icons.home, size: 30, color: formColor,),
            Icon(Icons.add, size: 30, color: formColor,),
            Icon(Icons.settings, size: 30, color: formColor,),
          ],
          onTap: (index){
            setState(() {
              _page = index;
            });
          },
        ),
        body: <Widget>[
          InfoNavPage(),
          AddNavPage(),
          SettingNavPage()
        ][_page]
      ),
    );
  }
}
