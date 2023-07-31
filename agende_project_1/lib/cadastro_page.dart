import 'package:flutter/material.dart';
import 'cadastro_form.dart';

class CadastroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: CadastroForm(),
        ),
      ),
    );
  }
}
