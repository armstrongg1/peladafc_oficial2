import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'home.dart';
import 'craquedojogo.dart';
import 'privacidade.dart';
//import 'profile.dart';



void main() => runApp(new MyApp());

//final ThemeData kIOSTheme = ThemeData(
//    primarySwatch: Colors.orange,
//    primaryColor: Colors.grey[100],
//    primaryColorBrightness: Brightness.light);
//
//final ThemeData kDefaultTheme = ThemeData(
//  primarySwatch: Colors.purple,
//  accentColor: Colors.orangeAccent[400],
//);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      //title: 'Flutter Bottom Navigation',
      debugShowCheckedModeBanner: false,
      //theme: new ThemeData(
      //primaryColor: const Color(0xFF02BB9F),
      //primaryColorDark: const Color(0xFF167F67),
      //accentColor: const Color(0xFFFFAD32),
      //),

      home: new DashboardScreen(title: 'PELADA FUTEBOL CLUBE'),
    );
  }

}

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key, this.title}) : super(key: key);

  final String title;



  @override
  _DashboardScreenState createState() => new _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }


  void navigationTapped(int page) {
    // Animating to the page.
    // You can use whatever duration and curve you like
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          widget.title,
          style: new TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: new PageView(
        children: [
          new Home("Home screen"),
          new craquedojogo(),
          new Privacidade("Privacidade"),
        ],
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: const Color(0xFF167F67),
          //backgroundColor: Colors.red
        ), // sets the inactive color of the `BottomNavigationBar`
        child: new BottomNavigationBar(
          backgroundColor: Colors.amber,
          //selectedItemColor: Colors.red,
          items: [
            new BottomNavigationBarItem(
                icon: new Icon(
                  Icons.home,
                  //color: const Color(0xFFFFFFFF),
                  color: Colors.black,
                ),
                title: new Text(
                  "Home",
                  style: new TextStyle(
                    //color: const Color(0xFFFFFFFF),
                    color: Colors.black,
                  ),
                )),
            new BottomNavigationBarItem(
                icon: new Icon(
                  Icons.star_border,
                  //color: const Color(0xFFFFFFFF),
                  color: Colors.black,
                ),
                title: new Text(
                  "Craque da partida",
                  style: new TextStyle(
                    //color: const Color(0xFFFFFFFF),
                    color: Colors.black,
                  ),
                )),
            new BottomNavigationBarItem(
                icon: new Icon(
                  Icons.security,
                  //color: const Color(0xFFFFFFFF),
                  color: Colors.black,
                ),
                title: new Text(
                  "Privacidade",
                  style: new TextStyle(
                    //color: const Color(0xFFFFFFFF),
                    color: Colors.black,
                  ),
                ))
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }
}


//https://www.developerlibs.com/2018/07/flutter-bottom-navigation-bar.html