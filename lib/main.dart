import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home.dart';

void main() async {
  runApp(MyApp());
}


final ThemeData kIOSTheme = ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light);

final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pelada FC",
      debugShowCheckedModeBanner: false,
      //theme: Theme.of(context).platform == TargetPlatform.iOS
      //  ? kIOSTheme
      //: kDefaultTheme,
      home: home(),
    );
  }
}
