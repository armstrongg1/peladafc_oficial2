import 'package:flutter/material.dart';



void main(){

  runApp(
    MaterialApp(
      title: 'Pelada FC',
      home: SIForm(),
        debugShowCheckedModeBanner: false
    )

  );

}


class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }

}


class _SIFormState extends State<SIForm> {



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


}