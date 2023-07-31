import 'package:flutter/material.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo à página Home'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Aqui você pode adicionar a lógica para lidar com a seleção do menu
              switch (value) {
                case 'Home':
                  // Navegar para a página "Home" novamente
                  Navigator.pushReplacementNamed(context, '/home');
                  break;
                case '1':
                  // Navegar para a página "1"
                  Navigator.pushReplacementNamed(context, '/page1');
                  break;
                case '2':
                  // Navegar para a página "2"
                  Navigator.pushReplacementNamed(context, '/page2');
                  break;
                case '3':
                  // Navegar para a página "3"
                  Navigator.pushReplacementNamed(context, '/page3');
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return ['Home', '1', '2', '3'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Conteúdo da página Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar para a página de login
          Navigator.pushReplacementNamed(context, '/login');
        },
        child: Icon(Icons.logout),
        tooltip: 'Sair',
      ),
    );
  }
}
