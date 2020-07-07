import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String nome;
  final int votos;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['nome'] != null),
        assert(map['votos'] != null),
        nome = map['nome'],
        votos = map['votos'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$nome:$votos>";
}