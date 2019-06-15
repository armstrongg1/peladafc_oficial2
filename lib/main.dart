import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  runApp(MyApp());
}

int Votos = 0;
int votouumavez = 0;
bool rodrigoval = false;
//String dropdownValue = 'Escolha...';
String dropdownValue;
String ResultadoCraqueVoto = "";

final ThemeData kIOSTheme = ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light);

final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

final _minimumPadding = 5.0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pelada FC",
      debugShowCheckedModeBanner: false,
      //theme: Theme.of(context).platform == TargetPlatform.iOS
      //  ? kIOSTheme
      //: kDefaultTheme,
      home: CraqueScreen(),
    );
  }
}

class CraqueScreen extends StatefulWidget {
  @override
  _CraqueScreenState createState() => _CraqueScreenState();
}

class _CraqueScreenState extends State<CraqueScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        top: false,
        child: Scaffold(
            appBar: AppBar(
              title: Text("CRAQUE DO JOGO - PFC"),
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
                        onPressed: () {
                          lerresultado(context);
                        }),
                  ],
                )
              ]),
            ])));
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

void lerresultado(BuildContext context) async {
  String ResultadoCraque = "";

  if (dropdownValue != null &&
      ResultadoCraqueVoto != "" &&
      ResultadoCraqueVoto != "Favor escolher algum jogador!") {
    QuerySnapshot snapshot =
        await Firestore.instance.collection("CraquedoJogo").getDocuments();

    List<Aluno> AlunosJogadores = [];
    int countDocumentos = 0;

    for (DocumentSnapshot doc in snapshot.documents) {
      AlunosJogadores.add(
          new Aluno(doc.documentID, int.parse(doc.data.values.first)));
      countDocumentos++;
    }

    AlunosJogadores.sort((a, b) {
      if (a.pontos < b.pontos) {
        return 1;
      } else
        return -1;
    });

    //ResultadoCraque = "";
    int somadevotos=0;
    for (int i = 0; i < AlunosJogadores.length; i++) {
      somadevotos = somadevotos + AlunosJogadores[i].pontos;
      ResultadoCraque = ResultadoCraque +
          "\n" +
          AlunosJogadores[i].nome +
          " : " +
          AlunosJogadores[i].pontos.toString();



      //print(AlunosJogadores[i]);
    }

    ResultadoCraque= ResultadoCraque + "\n\nTotal de votos: " + somadevotos.toString();

    if (AlunosJogadores.length == 0) {
      ResultadoCraque = "Nenhum voto computado!";
    }
  } else
    ResultadoCraque = "Favor votar primeiro!";

  var alertDialog = AlertDialog(
    title: Text(ResultadoCraque),

    content: FlatButton(
      child: Text('OK'),
      textColor: Colors.green,
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

void enviarVotoOK(BuildContext context) async {
  if (dropdownValue != null && ResultadoCraqueVoto != "") {
    if (votouumavez == 0) {
      DocumentSnapshot snapshot = await Firestore.instance
          .collection("CraquedoJogo")
          .document(dropdownValue)
          .get();

      if (snapshot.exists) {
        String SomaAntiga = snapshot.data.values.toString();
        //print (SomaAntiga);
        //print (SomaAntiga.length);
        SomaAntiga = SomaAntiga.substring(1, 2);
        //print (SomaAntiga);
        Votos = int.parse(SomaAntiga) + 1;
        //Votos++;

      } else {
        Votos = 1;
      }

      Firestore.instance
          .collection("CraquedoJogo")
          .document(dropdownValue)
          .setData({"SomadosVotos": Votos.toString()});

      ResultadoCraqueVoto = "Voto computado: \n" + dropdownValue;
      votouumavez = 1;
    }else { ResultadoCraqueVoto = "Você já votou!";}
  } else
    ResultadoCraqueVoto = "Favor escolher algum jogador!";

  var alertDialog = AlertDialog(
    title: Text(ResultadoCraqueVoto),
    content: FlatButton(
      child: Text('OK'),
      textColor: Colors.green,
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

class Aluno {
  String nome;
  int pontos;

  Aluno(String nome, int pontos) {
    this.nome = nome;
    this.pontos = pontos;
  }

//métodos

}
