import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CadastroForm extends StatefulWidget {
  @override
  _CadastroFormState createState() => _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _isButtonDisabled = true;

  void _validateFields() {
    setState(() {
      _isButtonDisabled =
          _usuarioController.text.isEmpty || _senhaController.text.isEmpty;
    });
  }

  void _cadastrar() async {
    final newUser = _usuarioController.text;
    final newSenha = _senhaController.text;

    final Map<String, dynamic> requestBody = {
      "username": newUser,
      "password": newSenha,
    };

    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.6:8080/Cadastro"), // Change the endpoint to the appropriate URL for registration
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Cadastro'),
            content: Text('Usuário e senha cadastrados com sucesso!'),
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

        _usuarioController.clear();
        _senhaController.clear();
        _validateFields();
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Erro de cadastro'),
            content: Text('Ocorreu um erro ao cadastrar o usuário.'),
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
          content: Text('Ocorreu um erro ao fazer o cadastro.'),
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
              labelText: 'Novo Usuário',
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
              labelText: 'Nova Senha',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isButtonDisabled ? null : _cadastrar,
            child: Text('Cadastrar'),
          ),
        ],
      ),
    );
  }
}
