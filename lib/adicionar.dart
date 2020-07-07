import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Adicionar extends StatelessWidget {
  final databaseReference = Firestore.instance;
  final String _collection;
  Adicionar(this._collection);

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Adicionar")),
        body: Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: myController,
                ),
                Center(
                    child: RaisedButton(
                  onPressed: () { createRecord(context); },
                  child: const Text('Salvar'),
                ))
              ]),
        ));
  }

  void createRecord(context) async {
    databaseReference.collection(_collection).add({
      "nome": myController.text,
      "votos": 0,
    }).then((value) => {
      Navigator.of(context).pop(true)
    });
  }
}
