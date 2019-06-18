import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pelada/Classes/Jogador.dart';

//String dropdownValue;
//String ResultadoCraqueVoto = "";

void lerresultado(BuildContext context) async {
  String ResultadoCraque = "";

  //if (dropdownValue != null &&
  //    ResultadoCraqueVoto != "" &&
  //    ResultadoCraqueVoto != "Favor escolher algum jogador!") {

    QuerySnapshot snapshot =
    await Firestore.instance.collection("CraquedoJogo").getDocuments();

    List<Jogador> Jogadores = [];
    int countDocumentos = 0;

    for (DocumentSnapshot doc in snapshot.documents) {
      Jogadores.add(
          new Jogador(doc.documentID, int.parse(doc.data.values.first)));
      countDocumentos++;
    }

    Jogadores.sort((a, b) {
      if (a.pontos < b.pontos) {
        return 1;
      } else
        return -1;
    });

    //ResultadoCraque = "";
    int somadevotos=0;
    for (int i = 0; i < Jogadores.length; i++) {
      somadevotos = somadevotos + Jogadores[i].pontos;
      ResultadoCraque = ResultadoCraque +
          "\n" +
          Jogadores[i].nome +
          " : " +
          Jogadores[i].pontos.toString();



      //print(AlunosJogadores[i]);
    }

    ResultadoCraque= ResultadoCraque + "\n\nTotal de votos: " + somadevotos.toString();

    if (Jogadores.length == 0) {
      ResultadoCraque = "Nenhum voto computado!";
    }
  //} else
  //  ResultadoCraque = "Favor votar primeiro!";

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