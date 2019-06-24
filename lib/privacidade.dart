import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';

class Privacidade extends StatelessWidget {

  Privacidade(this.listType);
  final String listType;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(

        title: Text("PRIVACIDADE"),

        centerTitle: true,
        backgroundColor: Colors.black38,
        elevation:
        Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: _launchURL,
              child: Text('Política de Privacidade',
                  style: TextStyle(fontSize: 25.0, decoration: TextDecoration.underline)),
            )
          ],
        ),
      ),
    );
  }
}


_launchURL() async {
  const url = 'https://peladafc.flycricket.io/privacy.html';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}