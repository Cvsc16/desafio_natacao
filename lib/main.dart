import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/login.dart';
import 'screens/esqueceuSenha.dart';
import 'screens/homeAtleta.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Color(0xFF0b2d78), // Defina a cor da barra de status aqui
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // Define a cor de fundo da aplicação
      ),
      home: HomeAtleta(), // Use a tela de login como página inicial
    );
  }
}