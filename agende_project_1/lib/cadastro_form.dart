import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CadastroForm extends StatefulWidget {
  @override
  _CadastroFormState createState() => _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _isButtonDisabled = true; // Variável para controlar o estado dos botões

  // Método para verificar se os campos estão preenchidos
  void _validateFields() {
    setState(() {
      _isButtonDisabled =
          _usuarioController.text.isEmpty || _senhaController.text.isEmpty;
    });
  }

  // Método para realizar o cadastro
  void _cadastrar() async {
    final newUser = _usuarioController.text;
    final newSenha = _senhaController.text;

    // Simulando o cadastro (salvando os dados no SharedPreferences)
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', newUser);
    prefs.setString('senha', newSenha);

    // Mostrando um alerta com o resultado do cadastro
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

    // Limpando os campos após o cadastro
    _usuarioController.clear();
    _senhaController.clear();
    // Chamando a função para validar os campos após limpar
    _validateFields();
  }

  @override
  void initState() {
    super.initState();
    // Chamando a função para validar os campos inicialmente
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
              // Chamando a função para validar os campos sempre que houver alteração no campo de usuário
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
              // Chamando a função para validar os campos sempre que houver alteração no campo de senha
              _validateFields();
            },
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Nova Senha',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isButtonDisabled
                ? null // Desabilita o botão se os campos não estiverem preenchidos
                : _cadastrar,
            child: Text('Cadastrar'),
          ),
        ],
      ),
    );
  }
}
