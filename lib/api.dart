import 'package:flutter/material.dart';
import 'model/Usuario.dart';

class API extends StatelessWidget {
  final Future<List<Usuario>> dados;
  API({Key key, this.dados}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: FutureBuilder<List<Usuario>>(
            future: dados,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: ListTile(
                            leading: Image.network(snapshot.data[index].foto),
                            title: Text(snapshot.data[index].nome),
                            subtitle: Text(snapshot.data[index].celular),
                          ));
                    });
              } else if (snapshot.hasError) {
                return Center(child: Text("ERRO: ${snapshot.error}"));
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
