
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<Login> {

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  String _email, _senha;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Login'),
      ),
      body: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (entrada) {
                    if (entrada.isEmpty) {
                      return 'Informe um email válido.';
                    }
                    return null;
                },
                decoration: InputDecoration(
                    labelText: 'Email'
                ),
                onSaved: (input) => _email = input.trim(),
              ),
              TextFormField(
                validator: (entrada) {
                  if (entrada.isEmpty) {
                    return 'Informe uma senha válida.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Senha'
                ),
                onSaved: (input) => _senha = input,
                obscureText: true,
              ),
              RaisedButton(
                onPressed: () => auth(false),
                child: Text('Entrar'),
              ),
              RaisedButton(
                onPressed: () => auth(true),
                child: Text('Cadastrar'),
              ),
            ],
          )
      ),
    );
  }

  void auth(bool cadastro) async {
    if(_form.currentState.validate()){
      _form.currentState.save();
      AuthResult auth;
      try{
        if(cadastro)
          auth = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _senha);
        else
          auth = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _senha);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
      }catch(e){
        showAlertDialog(context);
      }
    }
  }

  showAlertDialog(BuildContext context) {

    Widget ok = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Atenção"),
      content: Text("Não foi possível concluir a solicitação."),
      actions: [
        ok,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}