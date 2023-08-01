import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _isButtonDisabled = true;

  void _validateFields() {
    setState(() {
      _isButtonDisabled =
          _usuarioController.text.isEmpty || _senhaController.text.isEmpty;
    });
  }

  void _login() async {
    final enteredUser = _usuarioController.text;
    final enteredSenha = _senhaController.text;

    final Map<String, dynamic> requestBody = {
      "username": enteredUser,
      "password": enteredSenha,
    };

    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.6:8080/Login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Erro de login'),
            content: Text('Usuário ou senha incorretos.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro'),
          content: Text('Ocorreu um erro ao fazer o login.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _validateFields();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _usuarioController,
            onChanged: (value) {
              _validateFields();
            },
            decoration: InputDecoration(
              labelText: 'Usuário',
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _senhaController,
            onChanged: (value) {
              _validateFields();
            },
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Senha',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isButtonDisabled ? null : _login,
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
