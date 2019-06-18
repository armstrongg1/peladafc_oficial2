import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pelada/home.dart';


//String dropdownValue;
int votouumavez = 0;
String ResultadoCraqueVoto = "";
int Votos = 0;

void enviarVotoOK(BuildContext context) async {

  print (dropdownValue);

  //if (dropdownValue != null && ResultadoCraqueVoto != "") {
  if (dropdownValue != null) {
  //if (ResultadoCraqueVoto != "") {
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