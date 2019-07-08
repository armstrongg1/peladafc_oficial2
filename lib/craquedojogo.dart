import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'metodos_votacao/enviarVotoOK.dart';
import 'metodos_votacao/lerresultado.dart';

import 'home.dart';

String dropdownValue;

class craquedojogo extends StatefulWidget {
  @override

  _craquedojogoState createState() => _craquedojogoState();
}

class _craquedojogoState extends State<craquedojogo> {

  int _curIndex=1;
  var contents = "CraquedoJogo";


  @override
  Widget build(BuildContext context) {
    print ('entrou');
    return SafeArea(
        bottom: false,
        top: false,
        child: Scaffold(
            appBar: AppBar(

              title: Text("CRAQUE DA PARTIDA"),

              centerTitle: true,
              backgroundColor: Colors.black38,
              elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
            ),
            body: Column(children: <Widget>[

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
                        'Bruno',
                        'Caio',
                        'Colômbia',
                        'Daniel',
                        'Digão',
                        'Fabricio',
                        'Henrique',
                        'Paulo',
                        'PV',
                        'Jonathan',
                        'Lucas',
                        'Matheus',
                        'Moura',
                        'Renato',
                        'Sidnei',
                        'Wemerson'
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


