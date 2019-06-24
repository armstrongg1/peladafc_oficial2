import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _minimumPadding = 5.0;

class Home extends StatelessWidget {
  Home(this.listType);
  final String listType;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: LogoImageAsset(),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/Capturar.PNG');
    Image image = Image(
      image: assetImage,
      width: 225.0,
      height: 225.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 5),
    );
  }
}