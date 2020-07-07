import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:votos/adicionar.dart';
import 'package:votos/api.dart';
import 'package:votos/colecoes/filmes.dart';
import 'package:votos/colecoes/livros.dart';
import 'colecoes/lugares.dart';
import 'service/UsuarioService.dart';

class Home extends StatefulWidget {
  @override

  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    Filmes(),
    Livros(),
    Lugares(),
    API(dados: UsuarioService().getUsuarios())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Vota Aí'),
      ),
      body: _children[_currentIndex],
      floatingActionButton: Visibility(
        visible:  _currentIndex >= 0 && _currentIndex <= 2 ? true : false,
        child: FloatingActionButton(
          onPressed: () { onAdicionar(context); },
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.movie),
            title: Text('Filmes'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text('Livros'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.place),
              title: Text('Lugares')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.web),
              title: Text('API')
          )
        ],
      ),
    );
  }

  void onAdicionar(BuildContext buildContext) {

    String collection = "";
    if (_currentIndex == 0) collection = "filmes";
    else if (_currentIndex == 1) collection = "livros";
    else if (_currentIndex == 2) collection = "lugares";
    else collection = null;

    Navigator
        .of(buildContext)
        .push(MaterialPageRoute(
      builder: (context) => Adicionar(collection),
    ));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}