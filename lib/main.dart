import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() async {
  runApp(MyApp());
}

int Votos = 0;
bool rodrigoval = false;
//String dropdownValue = 'Escolha...';
String dropdownValue;



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
      theme: Theme.of(context).platform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
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
              title: Text("Craque do jogo"),
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
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: DropdownButton<String>(
                      isExpanded: false,
                      hint: new Text("Escolha...",
                          textAlign: TextAlign.center),
                      value: dropdownValue,
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>[
                        'Armstrong',
                        'Arthur',
                        'Caio',
                        'Campolina',
                        'Claydson',
                        'Colômbia',
                        'Daniel',
                        'Denis',
                        'Henrique',
                        'Jonhatan(Pimenta)',
                        'Lucas',
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
                          if (dropdownValue != null) {enviarVotoOK(context);}
                        }),
                    RaisedButton(
                        //color: Theme.of(context).accentColor,
                        //textColor: Theme.of(context).primaryColorDark,
                        child: Text('Ver Resultados', textScaleFactor: 1.5),
                        onPressed: () {
                          if (dropdownValue != null) {lerresultado(context);}
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
    AssetImage assetImage = AssetImage('images/logoPFC.png');
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


  QuerySnapshot snapshot = await Firestore.instance.collection("CraquedoJogo").getDocuments();

  //QuerySnapshot snapshot2 = snapshot.documents.sort(a,b);

  //List<int> documentosVotos = [];
  //List<String> documentosJogadores = [];
  List<Aluno> AlunosJogadores = [];
  int countDocumentos =0;

  for(DocumentSnapshot doc in snapshot.documents){

    //Aluno aluno1 =

    AlunosJogadores.add(new Aluno(doc.documentID, int.parse(doc.data.values.first)));
    countDocumentos++;

    //ResultadoCraque = ResultadoCraque + "\n" + doc.documentID+" : "+doc.data.values.first;
    //print (doc.metadata.toString());
    //print(countDocumentos);
    /*if (documentosJogadores.length > 0 && documentosVotos[0] <= int.parse(doc.data.values.first)){
      //if (documentosVotos[0] < int.parse(doc.data.values.first)) {
        documentosJogadores.insert(0,doc.documentID);
        documentosVotos.insert(0,int.parse(doc.data.values.first));
      //}

    }else{
      documentosJogadores.add(doc.documentID);
      documentosVotos.add(int.parse(doc.data.values.first));

    }


    print(AlunosJogadores.length);*/


    //print(doc.data.keys);

    //print(doc.data);
    //print (doc.data.keys.first);
    //print (doc.data.keys);
    //print (doc.data.values);
    //print (doc.data.values.first);
    //print(doc.toString());
    //print(doc.metadata);
    //print(doc.documentID);

  }

  AlunosJogadores.sort((a,b){
    if(a.pontos < b.pontos) {
      return 1;
    }
    else return -1;
  });

  //ResultadoCraque = "";
  for(int i=0;i<AlunosJogadores.length;i++){
    ResultadoCraque = ResultadoCraque + "\n" + AlunosJogadores[i].nome+" : "+AlunosJogadores[i].pontos.toString();
    //print(AlunosJogadores[i]);
  }
//
//  print(AlunosJogadores[0].nome);
//  print(AlunosJogadores[0].pontos);
//  //print (documentosJogadores.length);
//  //print (documentosVotos.length);
//  //documentosJogadores.sort();
//  //documentosVotos.sort();
//  print (documentosJogadores[0]);
//  print (documentosJogadores[1]);
//  print (documentosJogadores[2]);
//  print (documentosJogadores[3]);
//  print (documentosVotos[0]);
//  print (documentosVotos[1]);
//  print (documentosVotos[2]);
//  print (documentosVotos[3]);

  var alertDialog = AlertDialog(
    title: Text(ResultadoCraque),
    content: FlatButton(
      child: Text('OK'), textColor: Colors.green,
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

void enviarVotoOK(BuildContext context) async{

  //int JafoiVotado = 0;

  //QuerySnapshot snapshot = await Firestore.instance.collection(dropdownValue).getDocuments();
  DocumentSnapshot snapshot = await Firestore.instance.collection("CraquedoJogo").document(dropdownValue).get();

  //print (snapshot.documents);
  //for(DocumentSnapshot doc in snapshot.documents){
    //Votos = Votos + 1;
  //}
  //if(snapshot.documents.length>0){
  if(snapshot.exists){
    String SomaAntiga = snapshot.data.values.toString();
    //print (SomaAntiga);
    //print (SomaAntiga.length);
    SomaAntiga = SomaAntiga.substring(1,2);
    //print (SomaAntiga);
    Votos = int.parse(SomaAntiga)+1;
    //Votos++;

  }else{Votos = 1;}

  //print(snapshot.documents.getda);
  //print (snapshot.documents.length);
  //print(dropdownValue);
  //print(snapshot.data);
  //print (snapshot.data.values);
  //print(Votos);

  //if(JafoiVotado!=0) {
    //Firestore.instance.collection("votacao").document().setData({dropdownValue: "1"});
    Firestore.instance.collection("CraquedoJogo").document(dropdownValue).setData({"SomadosVotos": Votos.toString()});
 // }else {
   // Firestore.instance.collection("votacao").document(dropdownValue).setData({Votos:"1"});
  //}


    var alertDialog = AlertDialog(
      title: Text("Voto computado: \n" + dropdownValue),
      content: FlatButton(
        child: Text('OK'), textColor: Colors.green,
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

  Aluno(String nome, int pontos){
    this.nome = nome;
    this.pontos = pontos;
  }

  //métodos

}

/*class _SIFormState extends State<SIForm> {



  var _formKey = GlobalKey<FormState>();

  bool armstrongval = false;
  bool rodrigoval = false;
  bool pvval = false;

  var _currencies = ['Lucas, Armstrong', 'Paulo Vitor'];
  var voto1 = null;
  var voto2 = null;
  var voto= "";
  var count = 0;

  final _minimumPadding = 5.0;

  TextEditingController principalControlled = TextEditingController();
  TextEditingController roinController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  Widget build(BuildContext context){


    return Scaffold(


      appBar: AppBar(
        title: Text('Pelada FC - Craque da Galera'),
      ),

      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minimumPadding*2),
          //margin: EdgeInsets.all(_minimumPadding*15),
          child: ListView(
            children: <Widget>[
              getImageAsset(),

              Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),

                  child: CheckboxListTile(
                    title: const Text('Armstrong'),
                    value: armstrongval,
                    onChanged: (bool value) {
                      setState(() {
                        armstrongval = value;
                      });
                    },
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: CheckboxListTile(
                    title: const Text('Rodrigo'),
                    value: rodrigoval,
                    onChanged: (bool value) {
                      setState(() {
                        rodrigoval = value;
                      });
                    },
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: CheckboxListTile(
                    title: const Text('PV'),
                    value: pvval,
                    onChanged: (bool value) {
                      setState(() {
                        pvval = value;
                      });
                    },
                  )
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    textColor: Theme.of(context).primaryColorDark,
                    child: Text(
                      'Enviar',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      count = 0;
                      voto = '';



//count é usado apenas para deixar 2 selecionados - soma dos votos é no banco de dados
                      if (armstrongval) {
                        voto = voto.toString() + '-armstrong';
                        count = count + 1;
                        //enviarVotosemcheckbox(context);
                      }

                      if (rodrigoval) {
                        voto = voto.toString() + '-rodrigo';
                        count = count + 1;
                      }

                      if (pvval) {
                        voto = voto.toString() + '-pv';
                        count = count + 1;
                      }

                      if (count == 2) {
                        enviarVotoOK(context);
                      }else {
                        enviarVotosemcheckbox(context);
                      }
                    }
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: _minimumPadding, bottom: _minimumPadding),
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    textColor: Theme.of(context).primaryColorDark,
                    child: Text(
                    'Ver Resultado',
                     textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      lerresultado(context);
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


Widget getImageAsset(){
  AssetImage assetImage = AssetImage('images/logoPFC.png');
  Image image = Image(image: assetImage, width: 125.0, height: 125.0,);
  return Container(child: image,margin: EdgeInsets.all(_minimumPadding*5),);
}


  void enviarVotoOK(BuildContext context){

    Firestore.instance.collection("teste").document("teste").setData({"teste" : "teste"});



    var alertDialog = AlertDialog(


      title: Text("Voto realizado com sucesso em: "+voto.toString()),
      content: Text("Obrigado!"),
    );

    showDialog(context: context, builder: (BuildContext context){
      return alertDialog;
    }
    );


  }

  void enviarVotosemcheckbox(BuildContext context){

    var alertDialog = AlertDialog(
      title: Text("Erro!"),
      content: Text("Favor selecionar ao menos ou apenas dois jogadores!"),
    );

    showDialog(context: context, builder: (BuildContext context){
      return alertDialog;
    }
    );


  }


  void lerresultado(BuildContext context) async{

    String $jogador = "armstrong";
    //Int $votos=1;

    Firestore.instance.collection("craquedagalera").snapshots().listen((snapshot){
      for (DocumentSnapshot doc in snapshot.documents){
        //$jogador = (doc.data.toString());
        print (doc.data);

      }

    });

    var alertDialog = AlertDialog(
      title: Text("Resultado!"),
      content: Text("Jogadores: "+ $jogador + "Total de votos respectivamente"),
    );

    showDialog(context: context, builder: (BuildContext context){
      return alertDialog;
    }
    );


  }

}
*/
