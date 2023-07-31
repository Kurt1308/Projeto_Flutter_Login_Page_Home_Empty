import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Defina a página inicial aqui
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(), // Adicione a rota para a página "Home"
      },
    );
  }
}
