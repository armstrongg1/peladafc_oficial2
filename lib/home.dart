import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'metodos_votacao/enviarVotoOK.dart';
import 'metodos_votacao/lerresultado.dart';
import 'privacidade.dart';


String dropdownValue;

bool rodrigoval = false;
//String dropdownValue = 'Escolha...';



final _minimumPadding = 5.0;


class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  int _curIndex=0;
  var contents = "Home";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        top: false,
        child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.lightBlue,
              selectedItemColor: Colors.white,
              currentIndex: _curIndex,
              onTap: (int index) {
      setState(() {
        _curIndex = index;
        switch (_curIndex) {
          case 0:
            contents = "Home";
            home();
            break;
          case 1:
            contents = "Craque do Jogo";
            break;
          case 2:
            contents = "Profile";
            break;
          case 3:
            contents = "Privacidade";
            _launchURL();
            break;
        }
      });},
              items: [
                BottomNavigationBarItem(
                  icon: new Icon(Icons.home),
                  title: new Text('Home'),
                  //activeIcon:
                ),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.stars),
                  title: new Text('Craque do Jogo'),
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    title: Text('Profile')
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.security),
                    title: Text('Privacidade'),
                    //activeIcon: Selec//_launchURL()
                )
              ],
            ),
            appBar: AppBar(

              title: Text("PELADA FUTEBOL CLUBE"),

              centerTitle: true,
              //backgroundColor: Colors.black38,
              elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
            ),
            body: Column(children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: LogoImageAsset(),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 70, 0, 150),
                    child: DropdownButton<String>(
                      style: TextStyle(color: Colors.black),
                      isExpanded: false,
                      hint: new Text("Craque do jogo...",
                          textScaleFactor: 1.5, textAlign: TextAlign.center),
                      value: dropdownValue,
                      iconSize: 50,
                      elevation: 50,
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>[
                        'Armstrong',
                        'Arthur',
                        'Campolina',
                        'Claydson',
                        'Colômbia',
                        'Daniel',
                        'Denis',
                        'Donato',
                        'Henrique',
                        'Jonhatan(Pimenta)',
                        'Lucas',
                        'Matheus',
                        'Moura',
                        'Pedro',
                        'Rodrigo(Digão)',
                        'Sidnei',
                        'Wemerson(Ramires)'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Column(children: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      //color: Theme.of(context).accentColor,
                      //textColor: Theme.of(context).primaryColorDark,
                        child: Text('Enviar', textScaleFactor: 1.5),
                        onPressed: () {
                          enviarVotoOK(context);
                        }),
                    RaisedButton(
                      //color: Theme.of(context).accentColor,
                      //textColor: Theme.of(context).primaryColorDark,
                        child: Text('Ver Resultados', textScaleFactor: 1.5),
                        onPressed: () async {

                          //FutureBuilder<>
                          //await Future.wait(se)
                          //lerresultado.h
                          lerresultado(context);
                          //print('In Builder');
                          //CircularProgressIndicator(
//                              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
  //                        );
                        }
                        ),
                  ],
                ),
             /*   Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: <Widget>[


                    FlatButton(

                      onPressed: _launchURL,
                      child: Text('Política de Privacidade',
                          style: TextStyle(fontSize: 10.0)),
                    )

                  ],

                )*/
              ]),
            ])));
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

class LogoImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/Capturar.PNG');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 5),
    );
  }
}






